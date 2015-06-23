# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, gomp, hspec, mtl, QuickCheck, z3 }:

cabal.mkDerivation (self: {
  pname = "z3";
  version = "4.0.0";
  sha256 = "1axn3kzy6hsrnq5mcgf2n1sv63q3pqkhznvvhlj13k6jc3h2jzhl";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [ mtl ];
  testDepends = [ hspec QuickCheck ];
  extraLibraries = [ gomp z3 ];
  meta = {
    homepage = "http://bitbucket.org/iago/z3-haskell";
    description = "Bindings for the Z3 Theorem Prover";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})