// Use an existing window if there is one
url_remoting_fn = load_url_in_new_buffer;

homepage = "http://localhost:3000";

// Load some useful modes
require('gmail');
//require('github');
require('duckduckgo');
require('xkcd');
xkcd_add_title = true;

define_webjump('imdb', 'http://www.imdb.com/find?q=%s');

// Rename google webjump to realgoogle, so it doesn't pollute the tab
// completions for "g" (which is a nice default key, since it's the 'go to URL'
// key)
webjumps.realgoogle      = webjumps.google;
webjumps.realgoogle.name = "realgoogle";
delete webjumps.google;

// Put a copy of duckduckgo as webjump "g", so we can just hit "gg" to get ddg
webjumps.g      = webjumps.duckduckgo;
webjumps.g.name = "g";

// Stop sites like github from disabling our browser keys
require("key-kill");
key_kill_mode.test.push(build_url_regexp($domain = "github"));

view_source_use_external_editor = true;
editor_shell_command = "emacsclient -c";

//io_service.manageOfflineStatus = false;
//io_service.offline = false;
