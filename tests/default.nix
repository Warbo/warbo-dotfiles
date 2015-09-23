with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tests";
  src  = ./.;
  buildInputs = [
    ArbitraryHaskell
    coalp
    get_iplayer
    git2html
    gnumake
    haskellPackages.random
    haskellPackages.hlint
    haskellPackages.packunused
    haskellPackages.ShellCheck
    HS2AST
    ml4hs
    ml4pg
    mlspec
    panhandle
    panpipe
    quickspec
    subversionClient
    te-unstable.ArbitraryHaskell
    te-unstable.AstPlugin
    te-unstable.HS2AST
    te-unstable.ml4hs
    te-unstable.mlspec
    te-unstable.treefeatures
    treefeatures
    warbo-utilities
    weka
    which
    xidel
  ];
}
