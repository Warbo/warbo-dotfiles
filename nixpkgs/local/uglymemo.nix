# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal }:

cabal.mkDerivation (self: {
  pname = "uglymemo";
  version = "0.1.0.1";
  sha256 = "0ixqg5d0ly1r18jbgaa89i6kjzgi6c5hanw1b1y8c5fbq14yz2gy";
  meta = {
    description = "A simple (but internally ugly) memoization function";
    license = self.stdenv.lib.licenses.publicDomain;
    platforms = self.ghc.meta.platforms;
  };
})
