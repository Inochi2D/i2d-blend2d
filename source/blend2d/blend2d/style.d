module blend2d.blend2d.style;
import blend2d.blend2d.api;
import blend2d.blend2d.image;
import blend2d.blend2d.geometry;

//! Pattern quality.
enum BLPatternQuality : uint {
    
  //! Nearest neighbor interpolation.
  BL_PATTERN_QUALITY_NEAREST = 0,
  //! Bilinear interpolation.
  BL_PATTERN_QUALITY_BILINEAR = 1,
}

struct BLPattern {
    mixin BLExtends!BLObject;

    //! Image used by the pattern.
    BLImage image;

    //! Image area to use.
    BLRectI area;

    //! Pattern transformation matrix.
    BLMatrix2D transform;
}

version(B2D_Static) {
nothrow @nogc extern(C):

} else {
nothrow @nogc extern(C):

}