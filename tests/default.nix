with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tests";
  src  = ./.;
  buildInputs = [
    bazaar
    darcs
    gnumake
    haskellPackages.hlint
    haskellPackages.packunused
    haskellPackages.ShellCheck
    mercurial
    subversionClient
    which
    xidel
  ];
}
