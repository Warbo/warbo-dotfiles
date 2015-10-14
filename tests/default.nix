with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tests";
  src  = ./.;
  buildInputs = [
    darcs
    gnumake
    haskellPackages.hlint
    haskellPackages.packunused
    haskellPackages.ShellCheck
    subversionClient
    which
    xidel
  ];
}
