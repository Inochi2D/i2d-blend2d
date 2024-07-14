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

//! Gradient type.
enum BLGradientType : uint {

  //! Linear gradient type.
  BL_GRADIENT_TYPE_LINEAR = 0,
  //! Radial gradient type.
  BL_GRADIENT_TYPE_RADIAL = 1,
  //! Conic gradient type.
  BL_GRADIENT_TYPE_CONIC = 2,
}

//! Gradient data index.
enum BLGradientValue : uint {
    
    //! x0 - start 'x' for a Linear gradient and `x` center for both Radial and Conic gradients.
    BL_GRADIENT_VALUE_COMMON_X0 = 0,
    //! y0 - start 'y' for a Linear gradient and `y` center for both Radial and Conic gradients.
    BL_GRADIENT_VALUE_COMMON_Y0 = 1,
    //! x1 - end 'x' for a Linear gradient and focal point `x` for a Radial gradient.
    BL_GRADIENT_VALUE_COMMON_X1 = 2,
    //! y1 - end 'y' for a Linear/gradient and focal point `y` for a Radial gradient.
    BL_GRADIENT_VALUE_COMMON_Y1 = 3,
    //! Radial gradient center radius.
    BL_GRADIENT_VALUE_RADIAL_R0 = 4,
    //! Radial gradient focal radius.
    BL_GRADIENT_VALUE_RADIAL_R1 = 5,
    //! Conic gradient angle.
    BL_GRADIENT_VALUE_CONIC_ANGLE = 2,
    //! Conic gradient angle.
    BL_GRADIENT_VALUE_CONIC_REPEAT = 3,
}

//! Gradient rendering quality.
enum BLGradientQuality : uint {
    
    //! Nearest neighbor.
    BL_GRADIENT_QUALITY_NEAREST = 0,

    //! Use smoothing, if available (currently never available).
    BL_GRADIENT_QUALITY_SMOOTH = 1,

    //! The renderer will use an implementation-specific dithering algorithm to prevent banding.
    BL_GRADIENT_QUALITY_DITHER = 2,
}

//! Defines an `offset` and `rgba` color that us used by `BLGradient` to define
//! a linear transition between colors.
struct BLGradientStop {
    double offset;
    BLRgba64 rgba;
}

//! Linear gradient values packed into a structure.
struct BLLinearGradientValues {
    double x0;
    double y0;
    double x1;
    double y1;
}

//! Radial gradient values packed into a structure.
struct BLRadialGradientValues {
    double x0;
    double y0;
    double x1;
    double y1;
    double r0;
    double r1;
}


//! Conic gradient values packed into a structure.
struct BLConicGradientValues {
    double x0;
    double y0;
    double angle;
    double repeat;
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

struct BLGradient {
    mixin BLExtends!BLObject;
}

version(B2D_Static) {
nothrow @nogc extern(C):
    BLResult blPatternInit(BLPattern* self);
    BLResult blPatternInitMove(BLPattern* self, BLPattern* other);
    BLResult blPatternInitWeak(BLPattern* self, const(BLPattern)* other);
    BLResult blPatternInitAs(BLPattern* self, const(BLImage)* image, const(BLRectI)* area, BLExtendMode extendMode, const(BLMatrix2D)* transform);
    BLResult blPatternDestroy(BLPattern* self);
    BLResult blPatternReset(BLPattern* self);
    BLResult blPatternAssignMove(BLPattern* self, BLPattern* other);
    BLResult blPatternAssignWeak(BLPattern* self, const(BLPattern)* other);
    BLResult blPatternAssignDeep(BLPattern* self, const(BLPattern)* other);
    BLResult blPatternCreate(BLPattern* self, const(BLImage)* image, const(BLRectI)* area, BLExtendMode extendMode, const(BLMatrix2D)* transform);

    BLResult blPatternGetImage(const(BLPattern)* self, BLImage* image);
    BLResult blPatternSetImage(BLPattern* self, const(BLImage)* image, const(BLRectI)* area);
    BLResult blPatternResetImage(BLPattern* self);

    BLResult blPatternGetArea(const(BLPattern)* self, BLRectI* areaOut);
    BLResult blPatternSetArea(BLPattern* self, const(BLRectI)* area);
    BLResult blPatternResetArea(BLPattern* self);

    BLExtendMode blPatternGetExtendMode(const(BLPattern)* self) pure;
    BLResult blPatternSetExtendMode(BLPattern* self, BLExtendMode extendMode);

    BLResult blPatternGetTransform(const(BLPattern)* self, BLMatrix2D* transformOut);
    BLTransformType blPatternGetTransformType(const(BLPattern)* self) pure;
    BLResult blPatternApplyTransformOp(BLPattern* self, BLTransformOp opType, const(void)* opData);

    bool blPatternEquals(const(BLPattern)* a, const(BLPattern)* b);

    BLResult blGradientInit(BLGradient* self);
    BLResult blGradientInitMove(BLGradient* self, BLGradient* other);
    BLResult blGradientInitWeak(BLGradient* self, const BLGradient* other);
    BLResult blGradientInitAs(BLGradient* self, BLGradientType type, const void* values, BLExtendMode extendMode, const BLGradientStop* stops, size_t n, const BLMatrix2D* transform);
    BLResult blGradientDestroy(BLGradient* self);
    BLResult blGradientReset(BLGradient* self);
    BLResult blGradientAssignMove(BLGradient* self, BLGradient* other);
    BLResult blGradientAssignWeak(BLGradient* self, const BLGradient* other);
    BLResult blGradientCreate(BLGradient* self, BLGradientType type, const void* values, BLExtendMode extendMode, const BLGradientStop* stops, size_t n, const BLMatrix2D* transform);
    BLResult blGradientShrink(BLGradient* self);
    BLResult blGradientReserve(BLGradient* self, size_t n);
    BLGradientType blGradientGetType(const BLGradient* self) pure;
    BLResult blGradientSetType(BLGradient* self, BLGradientType type);
    BLExtendMode blGradientGetExtendMode(const BLGradient* self) pure;
    BLResult blGradientSetExtendMode(BLGradient* self, BLExtendMode extendMode);
    double blGradientGetValue(const BLGradient* self, size_t index) pure;
    BLResult blGradientSetValue(BLGradient* self, size_t index, double value);
    BLResult blGradientSetValues(BLGradient* self, size_t index, const double* values, size_t n);
    size_t blGradientGetSize(const BLGradient* self) pure;
    size_t blGradientGetCapacity(const BLGradient* self) pure;
    const BLGradientStop* blGradientGetStops(const BLGradient* self) pure;
    BLResult blGradientResetStops(BLGradient* self);
    BLResult blGradientAssignStops(BLGradient* self, const BLGradientStop* stops, size_t n);
    BLResult blGradientAddStopRgba32(BLGradient* self, double offset, uint32_t argb32);
    BLResult blGradientAddStopRgba64(BLGradient* self, double offset, uint64_t argb64);
    BLResult blGradientRemoveStop(BLGradient* self, size_t index);
    BLResult blGradientRemoveStopByOffset(BLGradient* self, double offset, uint32_t all);
    BLResult blGradientRemoveStopsByIndex(BLGradient* self, size_t rStart, size_t rEnd);
    BLResult blGradientRemoveStopsByOffset(BLGradient* self, double offsetMin, double offsetMax);
    BLResult blGradientReplaceStopRgba32(BLGradient* self, size_t index, double offset, uint32_t rgba32);
    BLResult blGradientReplaceStopRgba64(BLGradient* self, size_t index, double offset, uint64_t rgba64);
    size_t blGradientIndexOfStop(const BLGradient* self, double offset) pure;
    BLResult blGradientGetTransform(const BLGradient* self, BLMatrix2D* transformOut);
    BLTransformType blGradientGetTransformType(const BLGradient* self);
    BLResult blGradientApplyTransformOp(BLGradient* self, BLTransformOp opType, const void* opData);
    bool blGradientEquals(const BLGradient* a, const BLGradient* b) pure;
} else {
nothrow @nogc extern(C):

}