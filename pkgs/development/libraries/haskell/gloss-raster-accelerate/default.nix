# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, accelerate, accelerateCuda, gloss, glossAccelerate }:

cabal.mkDerivation (self: {
  pname = "gloss-raster-accelerate";
  version = "1.8.15.0";
  sha256 = "1fs3ybrzkykslac1zzh6g73lfdfysn6y2fr1pra9hd0a7x5a8j10";
  buildDepends = [ accelerate accelerateCuda gloss glossAccelerate ];
  meta = {
    description = "Parallel rendering of raster images using Accelerate";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    hydraPlatforms = self.stdenv.lib.platforms.none;
  };
})
