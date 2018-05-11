{ config, pkgs, warbo-utilities }:

with builtins;
with pkgs // { inherit warbo-utilities; };  # Prevents shadowing
with rec {
  # Polls regularly and runs the 'start' script whenever 'shouldRun' is true
  pollingService =
    {
      name,         # Used for naming scripts, etc.
      description,  # Shows up in systemd output
      extra ? {},   # Any extra systemd options we don't have by default
      RestartSec,   # Number of seconds to sleep between polls
      shouldRun,    # Script: exit status is whether or not to run 'start'
      start         # Script: do the required task then exit (not long-lived)
    }:
      monitoredService {
        inherit name description extra RestartSec shouldRun start;
        stop      = "${coreutils}/bin/true";
        isRunning = "${coreutils}/bin/false";
        allGood   = "${coreutils}/bin/true";  # We're stateless, so always good
      };

  # Polls regularly, checking whether 'shouldRun' and 'isRunning' are consistent
  # and running 'start' or 'stop' if they're not
  monitoredService =
    {
      name,           # Used to name scripts, etc.
      description,    # Shows up in systemd output
      extra ? {},     # Extra options to pass through to systemd
      isRunning,      # Script: whether the functionality is currently running
      RestartSec,     # How long to wait between checks
      shouldRun,      # Script: whether to be started or stopped, e.g. if online
      start,          # Script to start the functionality. Not long-lived.
      stop,           # Idempotent script to stop (e.g. kill) the functionality
      allGood ? "",   # Script: whether we're started/stopped correctly
      User ? "chris"  # User to run scripts as
    }:
      with rec {
        extraNoCfg = removeAttrs extra [ "serviceConfig" ];

        generalConfig = {
          inherit description;
          script  = wrap {
            name   = name + "-script";
            vars   = {
              inherit allGood isRunning name shouldRun start stop;
              secs = toString RestartSec;
            };
            paths  = [ bash fail ];
            script = ''
              #!/usr/bin/env bash
              set -e

              # Stopping on exit puts us in a known state
              trap "$stop" EXIT

              function allIsWell {
                # If allGood script is provided, use that to check that we're in
                # a sensible state
                if [[ -n "$allGood" ]]
                then
                  "$allGood"
                  return "$?"
                fi

                # If not, check that we're running iff we should be
                consistent || return 1
                return 0
              }

              function consistent {
                # Whether we're running iff we should be
                "$shouldRun" && "$isRunning" && return 0
                "$shouldRun" || "$isRunning" || return 0
                return 1
              }

              function startOrStop {
                # Take an action (start or stop) as appropriate
                if "$shouldRun"
                then
                  echo "Running start script for '$name'" 1>&2
                  "$start"
                else
                  echo "Running stop script for '$name'" 1>&2
                  "$stop"
                fi

                # Bail out if we're not in a sensible state
                allIsWell || echo "Inconsistent state for '$name'" 1>&2
              }

              # Make a long-running process, since 'start' exits immediately
              while true
              do
                # Iff we've become inconsistent, trigger an action
                consistent || startOrStop
                sleep "$secs"
              done
            '';
          };
        } // extraNoCfg;

        serviceConfig = {
          inherit RestartSec User;
          Restart = "always";

        } // (extra.serviceConfig or {});
      };
      mkService (generalConfig // { inherit serviceConfig; });

  findProcess = pat: wrap {
    name   = "find-process";
    paths  = [ bash procps psutils ];
    vars   = { inherit pat; };
    script = ''
      #!/usr/bin/env bash
      pgrep -f "$pat"
    '';
  };

  killProcess = pat: wrap {
    name   = "kill-process";
    paths  = [ bash procps psutils ];
    vars   = { inherit pat; };
    script = ''
      #!/usr/bin/env bash
      pkill "$pat"
    '';
  };

  SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";

  sshfsHelpers = rec {
    paths = [ bash coreutils fuse fuse3 iputils openssh procps sshfsFuse
              (utillinux.bin or utillinux) ];

    vars = dir: {
      inherit dir SSH_AUTH_SOCK;
      DISPLAY = ":0"; # For potential ssh passphrase dialogues
    };

    stop  = dir: wrap {
      inherit paths;
      name = "sshfuse-unmount";
      vars = { inherit dir; };
      script = ''
        #!/usr/bin/env bash
        pkill -f -9 "sshfs.*$dir"
        "${config.security.wrapperDir}/fusermount" -u -z "$dir"
      '';
    };

    isRunning = dir: wrap {
      name   = "desktop-is-mounted";
      paths  = sshfsHelpers.paths;
      vars   = vars dir // { checkProc = findProcess "sshfs.*${dir}"; };
      script = ''
        #!/usr/bin/env bash
        set -e

        # If we can't list what's in the directory then we don't count as
        # running, even if the processes exist, etc.
        ls "$dir" 1> /dev/null 2> /dev/null || exit 1

        "$checkProc" || exit 1
      '';
    };
  };

  mkService = opts:
    with rec {
      service       = srvDefaults // opts;
      serviceConfig = if opts ? serviceConfig
                         then { serviceConfig = cfgDefaults //
                                                opts.serviceConfig; }
                         else {};
      cfgDefaults   = { Type = "simple"; };
      srvDefaults   = {
        enable   = true;
        wantedBy = [ "default.target"  ];
      };

      combined  = service // serviceConfig;

      # Some attributes must be strings of commands, rather than externally
      # defined scripts. We replace such scripts with strings that call them.
      stringify = x: if x ? script && lib.isDerivation x.script
                        then stringify (x // { script = toString x.script; })
                        else x;
    };
    stringify combined;

  sudoWrapper = runCommand "sudo-wrapper" {} ''
    mkdir -p "$out/bin"
    ln -s "${config.security.wrapperDir}/sudo" "$out/bin/sudo"
  '';

  pingOnce  = "${config.security.wrapperDir}/ping -c 1";

  online    = "${pingOnce} google.com 1>/dev/null 2>/dev/null";

  areOnline = wrap {
    name   = "are-online";
    paths  = [ bash ];
    script = ''
      #!/usr/bin/env bash
      ${online} && exit 0
      exit 1
    '';
  };

  atHome = wrap {
    name   = "atHome";
    paths  = [ bash ];
    script = ''
      #!/usr/bin/env bash
      set -e

      LOC=$(cat /tmp/location)
      [[ "x$LOC" = "xhome" ]] || exit 1
    '';
  };

  atWork = wrap {
    name   = "atWork";
    paths  = [ bash ];
    script = ''
      #!/usr/bin/env bash
      set -e

      LOC=$(cat /tmp/location)
      [[ "x$LOC" = "xwork" ]] || exit 1
    '';
  };
};
{
  thermald-nocheck = mkService {
    description = "Thermal Daemon Service";
    wantedBy    = [ "multi-user.target" ];
    script      = wrap {
      name   = "thermald-nocheck";
      paths  = [ bash thermald ];
      script = ''
        #!/usr/bin/env bash
        exec thermald --no-daemon --dbus-enable --ignore-cpuid-check
      '';
    };
  };

  coolDown = mkService {
    description   = "Suspend common resource hogs when temperature's too hot";
    path          = [ procps warbo-utilities ];
    serviceConfig = {
      User       = "root";
      Restart    = "always";
      RestartSec = 30;
      ExecStart  = wrap {
        name  = "cool-now";
        paths = [ bash warbo-utilities ];
        script = ''
          #!/usr/bin/env bash
          coolDown
        '';
      };
    };
  };

  emacs = mkService {
    description     = "Emacs daemon";
    path            = [ all emacs mu sudoWrapper ];
    environment     = {
      inherit SSH_AUTH_SOCK;
      COLUMNS = "80";
    };
    reloadIfChanged = true;  # As opposed to restarting
    serviceConfig   = {
      User       = "chris";
      Type       = "forking";
      Restart    = "always";
      ExecStart  = writeScript "emacs-start" ''
        #!${bash}/bin/bash
        cd "$HOME"
        exec emacs --daemon
      '';
      ExecStop = writeScript "emacs-stop" ''
        #!${bash}/bin/bash
        exec emacsclient --eval "(kill-emacs)"
      '';
      ExecReload = writeScript "emacs-reload" ''
        #!${bash}/bin/bash
        emacsclient --eval "(load-file \"~/.emacs.d/init.el\")"
      '';
    };
  };

  shell = mkService {
    description     = "Long-running terminal multiplexer";
    path            = [ dvtm dtach ];
    environment     = {
      DISPLAY = ":0";
      TERM    = "xterm"; # Useful when remote servers don't have dvtm
    };
    reloadIfChanged = true;  # As opposed to restarting
    serviceConfig   = {
      User      = "chris";
      Restart   = "always";
      ExecStart = wrap {
        name   = "shell-start";
        paths  = [ bash dtach ];
        vars   = {
          session = wrap {
            name   = "session";
            paths  = [ bash dvtm ];
            script = ''
              #!/usr/bin/env bash
              exec dvtm -M -m ^b
            '';
          };
        };
        script = ''
          #!/usr/bin/env bash
          cd "$HOME"
          exec dtach -A "$HOME/.sesh" -r winch "$session"
        '';
      };

      # Don't stop, since it may kill programs we want to keep using
      ExecStop   = "${coreutils}/bin/true";
      ExecReload = "${coreutils}/bin/true";

      # Since we run at startup, X might not be up; pretend we're on a virtual
      # terminal (e.g. ctrl-alt-f6) for the purpose of DVTM's capability queries
      StandardInput  = "tty";
      StandardOutput = "tty";
      TTYPath        = "/dev/tty6";
    };
  };

  hometime =
    with {
      workingLate = wrap {
        name   = "workingLate";
        vars   = { inherit atWork; };
        paths  = [ bash ];
        script = ''
          #!/usr/bin/env bash
          set -e

          HOUR=$(date "+%H")
          [[ "$HOUR" -gt 16 ]] || exit 1

          "$atWork" || exit 1
          exit 0
        '';
      };
    };
    pollingService {
      name        = "hometime";
      description = "Count down to the end of the work day";
      RestartSec  = 300;
      shouldRun   = workingLate;
      start       = wrap {
        name  = "hometime";
        paths = [ bash gksu libnotify iputils networkmanager pmutils ];
        vars  = {
          inherit workingLate;
          DISPLAY    = ":0";
          XAUTHORITY = "/home/chris/.Xauthority";
        };
        script = ''
          #!/usr/bin/env bash
          set -e

          # Set DBus variables to make notifications appear on X display
          MID=$(cat /etc/machine-id)
            D=$(echo "$DISPLAY" | cut -d '.' -f1 | tr -d :)
          source ~/.dbus/session-bus/"$MID"-"$D"
          export DBUS_SESSION_BUS_ADDRESS

          function notify {
            notify-send -t 0 "Home Time" "$1"
          }

          "$workingLate" || exit
          notify "Past 5pm; half an hour until suspend"
          sleep 600

          "$workingLate" || exit
          notify "20 minutes until suspend"
          sleep 600

          "$workingLate" || exit
          notify "10 minutes until suspend"
          sleep 600

          "$workingLate" || exit
          notify "Suspending"
          sleep 60

          "$workingLate" || exit
          gksudo -S pm-suspend
        '';
      };
    };

  checkLocation = pollingService {
    name        = "check-location";
    description = "Use WiFi name to check where we are";
    extra       = { requires = [ "network.target" ]; };
    RestartSec  = 10;
    shouldRun   = "${coreutils}/bin/true";
    start       = wrap {
      name   = "setLocation";
      paths  = [ bash networkmanager ];
      script = ''
        #!/usr/bin/env bash
        set -e

        ${online} || {
          echo "unknown" > /tmp/location
          exit 0
        }

        WIFI=$(nmcli c | grep -v -- "--"  | grep -v "DEVICE" |
                         cut -d ' ' -f1   )
        if echo "$WIFI" | grep "aa.net.uk" > /dev/null
        then
          echo "home" > /tmp/location
          exit 0
        fi
        if echo "$WIFI" | grep "UoD_WiFi" > /dev/null
        then
          echo "work" > /tmp/location
          exit 0
        fi
        if echo "$WIFI" | grep "eduroam" > /dev/null
        then
          echo "work" > /tmp/location
          exit 0
        fi
        echo "unknown" > /tmp/location
      '';
    };
  };

  joX2X = monitoredService {
    name        = "jo-x2x";
    description = "Connect to X display when home";
    extra       = { requires = [ "network.target" ]; };
    RestartSec  = 10;
    isRunning   = findProcess "x2x -west";
    shouldRun   = atHome;
    stop        = killProcess "x2x -west";
    start       = wrap {
      name   = "jo-x2x-start";
      paths  = [ bash coreutils openssh warbo-utilities ];
      vars   = {
        DISPLAY = ":0";
        TERM    = "xterm";
      };
      script = ''
        #!/usr/bin/env bash
        set -e
        nohup jo
        sleep 5
      '';
    };
  };

  workX2X = monitoredService {
    name        = "work-x2x";
    description = "Connect to X display when at work";
    extra       = { requires = [ "network.target" ]; };
    RestartSec  = 10;
    isRunning   = findProcess "x2x -east";
    shouldRun   = atWork;
    stop        = killProcess "x2x -east";
    start       = wrap {
      name   = "work-x2x";
      paths  = [ bash coreutils openssh warbo-utilities ];
      vars   = { DISPLAY = ":0"; };
      script = ''
        #!/usr/bin/env bash
        nohup ssh -Y user@localhost -p 22222 "x2x -east -to :0"
        sleep 5
      '';
    };
  };

  workScreen =
    with {
      # "1080" means active; "disconnected" means not plugged in
      disconnectedButActive = ''xrandr | grep "VGA1 disconnected 1080"'';

      connectedButInactive = ''xrandr | grep "VGA1 connected ("'';
    };
    monitoredService {
      name        = "work-screen";
      description = "Turn on/off VGA screen";
      extra       = { requires = [ "graphical.target" ]; };
      RestartSec  = 10;
      isRunning   = wrap {
        name   = "work-screen-running";
        paths  = [ bash nettools psmisc warbo-utilities xorg.xrandr ];
        vars   = { DISPLAY = ":0"; };
        script = ''
          #!/usr/bin/env bash
          ${connectedButInactive}  && exit 1
          ${disconnectedButActive} && exit 0
          exit 1 # Otherwise, assume not running
        '';
      };
      shouldRun = wrap {
        name   = "display-query";
        paths  = [ bash nettools psmisc xorg.xrandr ];
        vars   = { DISPLAY = ":0"; };
        script = ''
          #!/usr/bin/env bash
          ${connectedButInactive}  && exit 0
          ${disconnectedButActive} && exit 1
          exit 1 # Otherwise, assume we shouldn't run
        '';
      };
      start = wrap {
        name   = "display-on";
        paths  = [ bash psmisc warbo-utilities xorg.xrandr ];
        vars   = { DISPLAY = ":0"; };
        script = ''
          #!/usr/bin/env bash
          set -e
          on  # Enable external monitor

          # Force any X2X sessions to restart, since we've messed up X
          pkill -f 'x2x -' || true
        '';
      };
      stop = wrap {
        name   = "display-off";
        paths  = [ bash psmisc warbo-utilities xorg.xrandr ];
        vars   = { DISPLAY = ":0"; };
        script = ''
          #!/usr/bin/env bash
          set -e
          off  # Disable external monitor

          # Force any X2X sessions to restart, since we've messed up X
          pkill -f 'x2x -' || true
        '';
      };
    };

  inboxen = mkService {
    description   = "Fetch mail inboxes";
    requires      = [ "network.target" ];
    serviceConfig = {
      User       = "chris";
      Restart    = "always";
      RestartSec = 600;
      ExecStart  = wrap {
        name   = "inboxen-start";
        paths  = [ bash coreutils iputils isync mu procps psutils gnused ];
        script = ''
          #!/usr/bin/env bash
          set -e
          ${online} || exit
          CODE=0

          echo "Fetching mail" 1>&2
          if timeout -s 9 3600 mbsync --verbose gmail dundee
          then
            echo "Finished syncing" 1>&2
          else
            echo "Error syncing" 1>&2
            CODE=1
          fi

          # Try waiting for existing mu processes to die
          for RETRY in $(seq 1 20)
          do
            # Find running mu processes. Try to exclude mupdf, etc.
            if P=$(ps auxww | grep '[ /]mu\( \|$\)')
            then
              echo "Stopping running mu instances" 1>&2
              echo "$P" | sed -e 's/  */ /g' | cut -d ' ' -f2 | while read -r I
              do
                kill -INT "$I"
              done
              sleep 1
            else
              # Stop early if nothing's running
              break
            fi
          done

          echo "Indexing maildirs for Mu" 1>&2
          if mu index --maildir=~/Mail
          then
            echo "Finished indexing" 1>&2
          else
            echo "Error indexing" 1>&2
            CODE=2
          fi
          exit "$CODE"
        '';
      };
    };
  };

  news = mkService {
    description   = "Fetch news";
    requires      = [ "network.target" ];
    serviceConfig = {
      User       = "chris";
      Restart    = "always";
      RestartSec = 60 * 60 * 4;
      ExecStart  = wrap {
        name  = "get-news-start";
        paths = [ findutils.out warbo-utilities ];
        vars  = { LANG = "en_GB.UTF-8"; };
        file  = "${warbo-utilities}/bin/get_news";
      };
    };
  };

  mailbackup = mkService {
    description   = "Fetch all mail";
    requires      = [ "network.target" ];
    serviceConfig = {
      User       = "chris";
      Restart    = "always";
      RestartSec = 3600;
      ExecStart  = wrap {
        name   = "mail-backup";
        paths  = [ bash coreutils iputils isync ];
        script = ''
          #!/usr/bin/env bash
          set -e
          ${online} || exit
          timeout -s 9 3600 mbsync --verbose gmail-backup
          echo "Finished syncing" 1>&2
        '';
      };
    };
  };

  keeptesting = mkService {
    description   = "Run tests";
    enable        = false;
    serviceConfig = {
      User       = "chris";
      Restart    = "always";
      RestartSec = 300;
      ExecStart  = wrap {
        name  = "keep-testing";
        paths = [ bash basic nix.out warbo-utilities ];
        vars  = {
          LOCATE_PATH = /var/cache/locatedb;
          NIX_PATH    = getEnv "NIX_PATH";
          NIX_REMOTE  = getEnv "NIX_REMOTE";
        };
        script = ''
          #!/usr/bin/env bash
          set -e
          plugged_in || exit
          hot        && exit

          cd "$HOME/System/Tests" || exit 1

          # Choose one successful script at random
          S=$(find results/pass -type f | shuf | head -n1)

          # Choose one test at random
          #T=$(shuf | head -n1)

          # Choose the oldest test
          O=$(ls -1tr results/pass | head -n1)

          # Force chosen tests to be re-run
          for TST in "$S" "$O"
          do
            NAME=$(basename "$TST")
            touch results/pass/"$NAME"
            mv results/pass/"$NAME" results/check/
          done

          # Run chosen tests, along with any existing failures
          ./run
        '';
      };
    };
  };

  pi-mount =
    with rec {
      dir       = "/home/chris/Public";
      isRunning = sshfsHelpers.isRunning dir;
      stop      = sshfsHelpers.stop dir;
      vars      = sshfsHelpers.vars dir;
    };
    monitoredService {
      inherit isRunning stop;
      name        = "pi-mount";
      description = "Raspberry pi mount";
      extra       = { requires = [ "network.target" ]; };
      RestartSec  = 30;
      shouldRun   = wrap {
        name   = "desktop-mount-query";
        paths  = sshfsHelpers.paths;
        vars   = vars // { inherit atHome; };
        script = ''
          #!/usr/bin/env bash

          # We must be online
          ${online} || exit 1

          # We must be home
          "$atHome" || exit 1

          # Try to contact the pi
          ${pingOnce} dietpi.local || exit 1
        '';
      };
      start = wrap {
        name   = "pi-mount-start";
        paths  = sshfsHelpers.paths;
        vars   = vars // { inherit stop; };
        script = ''
          #!/usr/bin/env bash

          "$stop" || true

          sshfs -o follow_symlinks                      \
                -o allow_other                          \
                -o IdentityFile=/home/chris/.ssh/id_rsa \
                -o debug                                \
                -o sshfs_debug                          \
                -o reconnect                            \
                -o ServerAliveInterval=15               \
                "pi@dietpi.local:/opt/shared" "$dir"
          sleep 5
        '';
      };
    };

  desktop-mount =
    with rec {
      dir       = "/home/chris/DesktopFiles";
      isRunning = sshfsHelpers.isRunning dir;
      stop      = sshfsHelpers.stop dir;
      vars      = sshfsHelpers.vars dir;
    };
    monitoredService {
      inherit isRunning stop;
      name        = "desktop-mount";
      description = "Desktop files";
      extra       = { requires = [ "network.target" ]; };
      RestartSec  = 30;
      shouldRun   = wrap {
        name   = "desktop-mount-query";
        paths  = sshfsHelpers.paths;
        vars   = vars // { PAT = "ssh.*22222:localhost:22222"; };
        script = ''
          #!/usr/bin/env bash

          # Check if our port is bound
          pgrep -f "$PAT" || exit 1

          # Check if we're online
          ${online} || exit 1

          # Check if the bind works
          if timeout 10 ssh -A user@localhost -p 22222 true
          then
            exit 0
          else
            exit 1
          fi
        '';
      };
      start = wrap {
        name   = "desktop-mount-start";
        paths  = sshfsHelpers.paths;
        vars   = vars // { inherit stop; };
        script = ''
          #!/usr/bin/env bash
          set -e

          # Force a clean slate
          "$stop" || true

          sshfs -p 22222 -o follow_symlinks                      \
                         -o allow_other                          \
                         -o IdentityFile=/home/chris/.ssh/id_rsa \
                         -o debug                                \
                         -o sshfs_debug                          \
                         -o reconnect                            \
                         -o ServerAliveInterval=15               \
                         "user@localhost:/" "$dir"
          sleep 5
        '';
      };
    };

  desktop-bind =
    with {
      pat = "ssh.*22222:localhost:22222";
    };
    monitoredService {
      name          = "desktop-bind";
      description   = "Bind desktop SSH";
      extra         = { requires = [ "network.target" ]; };
      RestartSec    = 20;
      isRunning     = wrap {
        name   = "desktop-bind-query";
        paths  = [ bash coreutils openssh procps ];
        vars   = { inherit SSH_AUTH_SOCK; check = findProcess pat; };
        script = ''
          #!/usr/bin/env bash
          echo "Checking for bind process" 1>&2
          "$check" || {
            echo "Bind process not found" 1>&2
            exit 1
          }

          echo "Bind is running, see if it's working" 1>&2
          timeout 10 ssh -A user@localhost -p 22222 true && {
            echo "Bind works" 1>&2
            exit 0
          }

          echo "Bind not working" 1>&2
          exit 1
        '';
      };
      shouldRun     = areOnline;
      start         = wrap {
        name   = "desktop-bind";
        paths  = [ bash iputils openssh procps ];
        vars   = { inherit pat SSH_AUTH_SOCK; };
        script = ''
          #!/usr/bin/env bash

          echo "Killing any existing bind" 1>&2
          pkill -f -9 "$pat" || true

          echo "Setting up bind" 1>&2
          ssh -f -N -A -L 22222:localhost:22222 chriswarbo.net
          sleep 5
          echo "Done" 1>&2
        '';
      };
      stop = wrap {
        name   = "unbind-desktop";
        paths  = [ bash procps ];
        vars   = { inherit pat; };
        script = ''
          #!/usr/bin/env bash
          echo "Stopping bind (if running)" 1>&2
          pkill -f -9 "$pat" || true
        '';
      };
    };

  hydra-bind =
    with {
      paths = [ bash coreutils curl iputils openssh procps ];
      vars  = {
        inherit SSH_AUTH_SOCK;
        pat = "ssh.*3000:localhost:3000";
      };
    };
    monitoredService {
      name        = "hydra-bind";
      description = "Bind desktop SSH";
      extra      = { requires   = [ "network.target" ]; };
      RestartSec  = 20;
      isRunning   = wrap {
        inherit paths vars;
        name   = "hydra-bind-running";
        script = ''
          #!/usr/bin/env bash
          pgrep -f "$pat" && exit 0
          exit 1
        '';
      };
      shouldRun = areOnline;
      start     = wrap {
        inherit paths vars;
        name   = "hydra-bind";
        script = ''
          #!/usr/bin/env bash
          set -e

          pkill -f -9 "$pat" || true

          echo "Checking for identity"
          if ssh-add -L | grep "The agent has no identities"
          then
            echo "No identity found, adding"
            ssh-add /home/chris/.ssh/id_rsa
          fi

          echo "Binding port"
          ssh -f -N -A -L 3000:localhost:3000 user@localhost -p 22222
          sleep 5
        '';
      };
      stop = wrap {
        inherit paths vars;
        name   = "hydra-bind-query";
        script = ''
          #!/usr/bin/env bash
          pkill -f -9 "$pat" || true
        '';
      };
    };

  keys = monitoredService {
    name        = "keys";
    description = "Sets up keyboard";
    RestartSec  = "10";
    isRunning   = findProcess "xcape";
    shouldRun   = "${coreutils}/bin/true";
    stop        = wrap {name="keys-stop";paths=[psmisc];script=''
      #!/usr/bin/env bash
      killall xcape || true
    '';};
    start       = wrap {
      name  = "start-keys";
      vars  = { DISPLAY = ":0"; };
      paths = [ psmisc warbo-utilities xorg.setxkbmap ];
      file  = "${warbo-utilities}/bin/keys";
    };
  };

  ssh-agent = mkService {
    description   = "Run ssh-agent";
    serviceConfig = {
      User       = "chris";
      Restart    = "always";
      RestartSec = 20;
      ExecStart  = wrap {
        name   = "ssh-agent-start";
        paths  = [ bash openssh ];
        script = ''
          #!/usr/bin/env bash
          set -e
          [[ -e /run/user/1000/ssh-agent ]] && exit

          exec ssh-agent -D -a /run/user/1000/ssh-agent
        '';
      };
      ExecStop   = wrap {
        name   = "ssh-agent-stop";
        paths  = [ bash openssh ];
        vars   = { inherit SSH_AUTH_SOCK; };
        script = ''
          #!/usr/bin/env bash
          ssh-agent -k
        '';
      };
    };
  };

  kill-network-mounts = mkService {
    description   = "Force kill network mounts after suspend/resume";

    # suspend.target causes this to be invoked, but only after (i.e. on resume)
    after         = [ "suspend.target" ];
    wantedBy      = [ "suspend.target" ];
    serviceConfig = {
      User      = "root";
      Type      = "oneshot";
      ExecStart = wrap {
        name   = "kill-network-filesystems";
        paths  = [ bash psmisc];
        script = ''
          #!/usr/bin/env bash
          killall -9 sshfs || true
        '';
      };
    };
  };

  # Turn off power saving on WiFi to work around
  # https://bugzilla.kernel.org/show_bug.cgi?id=56301 (or something similar)
  wifiPower = mkService {
    wantedBy      = [ "multi-user.target" ];
    before        = [ "network.target" ];
    serviceConfig = {
      Type       = "simple";
      User       = "root";
      Restart    = "always";
      RestartSec = 60;
      ExecStart  = wrap {
        name   = "wifipower";
        paths  = [ bash iw ];
        script = ''
          #!/usr/bin/env bash
          iw dev wlp2s0 set power_save off
        '';
      };
    };
  };
}
