# Allow git repos to be used without pre-determined revisions or hashes, in the
# same way we can use `src = ./.`.
#
# For example:
#
# let latestGit = import /path/to/latestGit.nix
#  in stdenv.mkDerivation {
#       name = "My Project";
#       src  = latestGit { url = "http://example.com/project.git"; };
#     }

with import <nixpkgs> {};
with builtins;

# We need the url. ref lets us pick branches, etc.
{ url, ref ? "HEAD" }:

let

  # Get the commit ID for the given ref in the given repo. Use currentTime as a
  # version to miss any cached result. This is a cheap operation and needs to be
  # up-to-date.
  getHeadRev = stdenv.mkDerivation {
    inherit url ref;
    name         = "repo-head-${hashString "sha256" url}";
    version      = toString currentTime;
    buildInputs  = [ git gnused ];
    buildCommand = ''
      source $stdenv/setup
      # printf is an ugly way to avoid trailing newlines
      printf "%s" $(git ls-remote "$url" "$ref" | sed -e 's/\s.*//g') > "$out"
    '';
  };

  # Extract the commit ID as a string. Ignore how we got it, to avoid cache
  # misses (git repos are expensive).
  rev = unsafeDiscardStringContext (readFile "${getHeadRev}");

  # fetchgit does all of the hard work, but it requires a hash. Make one up.
  fg = fetchgit {
    inherit url rev;

    # Dummy hash
    sha256 = hashString "sha256" url;
  };

# Use the result of fetchgit, but throw away all of the made up hashes; Nix will
# calculate fresh ones, rather than complaining.
in stdenv.lib.overrideDerivation fg (old: {
    outputHash     = null;
    outputHashAlgo = null;
    outputHashMode = null;
    sha256         = null;
  })
