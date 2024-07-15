module blend2d.blend2d.context;
import blend2d.blend2d.api;
import blend2d.blend2d.geometry;
import blend2d.blend2d.image;
import blend2d.blend2d.font;
import blend2d.blend2d.glyphs;
import blend2d.blend2d.array;

/// Rendering context type.
enum BLContextType : uint {

    /// No rendering context.
    BL_CONTEXT_TYPE_NONE = 0,
    /// Dummy rendering context.
    BL_CONTEXT_TYPE_DUMMY = 1,

    /// Software-accelerated rendering context.
    BL_CONTEXT_TYPE_RASTER = 3,


}

/// Rendering context hint.
enum BLContextHint : uint {

    /// Rendering quality.
    BL_CONTEXT_HINT_RENDERING_QUALITY = 0,
    /// Gradient quality.
    BL_CONTEXT_HINT_GRADIENT_QUALITY = 1,
    /// Pattern quality.
    BL_CONTEXT_HINT_PATTERN_QUALITY = 2,


}

/// Describes a rendering context style slot - fill or stroke.
enum BLContextStyleSlot : uint {

    /// Fill operation style slot.
    BL_CONTEXT_STYLE_SLOT_FILL = 0,
    /// Stroke operation style slot.
    BL_CONTEXT_STYLE_SLOT_STROKE = 1,


}

/// The type of a text rendering operation.
///
/// This value specifies the type of the parameter passed to the text rendering API.
///
/// \note In most cases this should not be required to use by Blend2D users. The C API provides functions that
/// wrap all of the text operations and C++ API provides functions that use `BLContextRenderTextOp` internally.
enum BLContextRenderTextOp : uint {

    /// UTF-8 text rendering operation - UTF-8 string passed as `BLStringView` or `BLArrayView<uint8_t>`.
    BL_CONTEXT_RENDER_TEXT_OP_UTF8 = BLTextEncoding.BL_TEXT_ENCODING_UTF8,
    /// UTF-16 text rendering operation - UTF-16 string passed as `BLArrayView<uint16_t>`.
    BL_CONTEXT_RENDER_TEXT_OP_UTF16 = BLTextEncoding.BL_TEXT_ENCODING_UTF16,
    /// UTF-32 text rendering operation - UTF-32 string passed as `BLArrayView<uint>`.
    BL_CONTEXT_RENDER_TEXT_OP_UTF32 = BLTextEncoding.BL_TEXT_ENCODING_UTF32,
    /// LATIN1 text rendering operation - LATIN1 string is passed as `BLStringView` or `BLArrayView<uint8_t>`.
    BL_CONTEXT_RENDER_TEXT_OP_LATIN1 = BLTextEncoding.BL_TEXT_ENCODING_LATIN1,
    /// Glyph run text rendering operation - the `BLGlyphRun` parameter is passed.
    BL_CONTEXT_RENDER_TEXT_OP_GLYPH_RUN = 4,
}

/// Rendering context flush flags, used by \ref BLContext::flush().
enum BLContextFlushFlags : uint {
    BL_CONTEXT_FLUSH_NO_FLAGS = 0u,

    /// Flushes the command queue and waits for its completion (will block until done).
    BL_CONTEXT_FLUSH_SYNC = 0x80000000u
}

/// Rendering context creation flags.
enum BLContextCreateFlags : uint {
    /// No flags.
    BL_CONTEXT_CREATE_NO_FLAGS = 0u,

    /// Disables JIT pipeline generator.
    BL_CONTEXT_CREATE_FLAG_DISABLE_JIT = 0x00000001u,

    /// Fallbacks to a synchronous rendering in case that the rendering engine wasn't able to acquire threads. This
    /// flag only makes sense when the asynchronous mode was specified by having `threadCount` greater than 0. If the
    /// rendering context fails to acquire at least one thread it would fallback to synchronous mode with no worker
    /// threads.
    ///
    /// \note If this flag is specified with `threadCount == 1` it means to immediately fallback to synchronous
    /// rendering. It's only practical to use this flag with 2 or more requested threads.
    BL_CONTEXT_CREATE_FLAG_FALLBACK_TO_SYNC = 0x00100000u,

    /// If this flag is specified and asynchronous rendering is enabled then the context would create its own isolated
    /// thread-pool, which is useful for debugging purposes.
    ///
    /// Do not use this flag in production as rendering contexts with isolated thread-pool have to create and destroy all
    /// threads they use. This flag is only useful for testing, debugging, and isolated benchmarking.
    BL_CONTEXT_CREATE_FLAG_ISOLATED_THREAD_POOL = 0x01000000u,

    /// If this flag is specified and JIT pipeline generation enabled then the rendering context would create its own
    /// isolated JIT runtime. which is useful for debugging purposes. This flag will be ignored if JIT pipeline
    /// compilation is either not supported or was disabled by other flags.
    ///
    /// Do not use this flag in production as rendering contexts with isolated JIT runtime do not use global pipeline
    /// cache, that's it, after the rendering context is destroyed the JIT runtime is destroyed with it with all
    /// compiled pipelines. This flag is only useful for testing, debugging, and isolated benchmarking.
    BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT_RUNTIME = 0x02000000u,

    /// Enables logging to stderr of isolated runtime.
    ///
    /// \note Must be used with \ref BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT_RUNTIME otherwise it would have no effect.
    BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT_LOGGING = 0x04000000u,

    /// Override CPU features when creating isolated context.
    BL_CONTEXT_CREATE_FLAG_OVERRIDE_CPU_FEATURES = 0x08000000u
}

/// Error flags that are accumulated during the rendering context lifetime and that can be queried through
/// `BLContext::queryAccumulatedErrorFlags()`. The reason why these flags exist is that errors can happen during
/// asynchronous rendering, and there is no way the user can catch these errors.
enum BLContextErrorFlags : uint {
    
    /// No flags.
    BL_CONTEXT_ERROR_NO_FLAGS = 0u,

    /// The rendering context returned or encountered `BL_ERROR_INVALID_VALUE`, which is mostly related to the function
    /// argument handling. It's very likely some argument was wrong when calling `BLContext` API.
    BL_CONTEXT_ERROR_FLAG_INVALID_VALUE = 0x00000001u,

    /// Invalid state describes something wrong, for example a pipeline compilation error.
    BL_CONTEXT_ERROR_FLAG_INVALID_STATE = 0x00000002u,

    /// The rendering context has encountered invalid geometry.
    BL_CONTEXT_ERROR_FLAG_INVALID_GEOMETRY = 0x00000004u,

    /// The rendering context has encountered invalid glyph.
    BL_CONTEXT_ERROR_FLAG_INVALID_GLYPH = 0x00000008u,

    /// The rendering context has encountered invalid or uninitialized font.
    BL_CONTEXT_ERROR_FLAG_INVALID_FONT = 0x00000010u,

    /// Thread pool was exhausted and couldn't acquire the requested number of threads.
    BL_CONTEXT_ERROR_FLAG_THREAD_POOL_EXHAUSTED = 0x20000000u,

    /// Out of memory condition.
    BL_CONTEXT_ERROR_FLAG_OUT_OF_MEMORY = 0x40000000u,

    /// Unknown error, which we don't have flag for.
    BL_CONTEXT_ERROR_FLAG_UNKNOWN_ERROR = 0x80000000u
}

/// Specifies the behavior of \ref BLContext::swapStyles() operation.
enum BLContextStyleSwapMode : uint {
  /// Swap only fill and stroke styles without affecting fill and stroke alpha.
  BL_CONTEXT_STYLE_SWAP_MODE_STYLES = 0,

  /// Swap both fill and stroke styles and their alpha values.
  BL_CONTEXT_STYLE_SWAP_MODE_STYLES_WITH_ALPHA = 1,


}

/// Specifies how style transformation matrix is combined with the rendering context transformation matrix, used by
/// \ref BLContext::setStyle() function.
enum BLContextStyleTransformMode : uint {

  /// Style transformation matrix should be transformed with the rendering context user and meta matrix (default).
  ///
  /// \note This transformation mode is identical to how user geometry is transformed and it's the default
  /// transformation and most likely the behavior expected in most cases.
  BL_CONTEXT_STYLE_TRANSFORM_MODE_USER = 0,

  /// Style transformation matrix should be transformed with the rendering context meta matrix.
  BL_CONTEXT_STYLE_TRANSFORM_MODE_META = 1,

  /// Style transformation matrix is considered absolute, and is not combined with a rendering context transform.
  BL_CONTEXT_STYLE_TRANSFORM_MODE_NONE = 2,


}

/// Clip mode.
enum BLClipMode : uint {

    /// Clipping to a rectangle that is aligned to the pixel grid.
    BL_CLIP_MODE_ALIGNED_RECT = 0,
    /// Clipping to a rectangle that is not aligned to pixel grid.
    BL_CLIP_MODE_UNALIGNED_RECT = 1,
    /// Clipping to a non-rectangular area that is defined by using mask.
    BL_CLIP_MODE_MASK = 2,

    /// Count of clip modes.
    BL_CLIP_MODE_COUNT = 3
}

/// Composition & blending operator.
enum BLCompOp : uint {

    /// Source-over [default].
    BL_COMP_OP_SRC_OVER = 0,
    /// Source-copy.
    BL_COMP_OP_SRC_COPY = 1,
    /// Source-in.
    BL_COMP_OP_SRC_IN = 2,
    /// Source-out.
    BL_COMP_OP_SRC_OUT = 3,
    /// Source-atop.
    BL_COMP_OP_SRC_ATOP = 4,
    /// Destination-over.
    BL_COMP_OP_DST_OVER = 5,
    /// Destination-copy [nop].
    BL_COMP_OP_DST_COPY = 6,
    /// Destination-in.
    BL_COMP_OP_DST_IN = 7,
    /// Destination-out.
    BL_COMP_OP_DST_OUT = 8,
    /// Destination-atop.
    BL_COMP_OP_DST_ATOP = 9,
    /// Xor.
    BL_COMP_OP_XOR = 10,
    /// Clear.
    BL_COMP_OP_CLEAR = 11,
    /// Plus.
    BL_COMP_OP_PLUS = 12,
    /// Minus.
    BL_COMP_OP_MINUS = 13,
    /// Modulate.
    BL_COMP_OP_MODULATE = 14,
    /// Multiply.
    BL_COMP_OP_MULTIPLY = 15,
    /// Screen.
    BL_COMP_OP_SCREEN = 16,
    /// Overlay.
    BL_COMP_OP_OVERLAY = 17,
    /// Darken.
    BL_COMP_OP_DARKEN = 18,
    /// Lighten.
    BL_COMP_OP_LIGHTEN = 19,
    /// Color dodge.
    BL_COMP_OP_COLOR_DODGE = 20,
    /// Color burn.
    BL_COMP_OP_COLOR_BURN = 21,
    /// Linear burn.
    BL_COMP_OP_LINEAR_BURN = 22,
    /// Linear light.
    BL_COMP_OP_LINEAR_LIGHT = 23,
    /// Pin light.
    BL_COMP_OP_PIN_LIGHT = 24,
    /// Hard-light.
    BL_COMP_OP_HARD_LIGHT = 25,
    /// Soft-light.
    BL_COMP_OP_SOFT_LIGHT = 26,
    /// Difference.
    BL_COMP_OP_DIFFERENCE = 27,
    /// Exclusion.
    BL_COMP_OP_EXCLUSION = 28,


}

/// Rendering quality.
enum BLRenderingQuality : uint {

  /// Render using anti-aliasing.
  BL_RENDERING_QUALITY_ANTIALIAS = 0,


}

struct BLContextCreateInfo {
nothrow @nogc:

    /// Create flags, see \ref BLContextCreateFlags.
    BLContextCreateFlags flags;

    /// Number of worker threads to use for asynchronous rendering, if non-zero.
    ///
    /// If `threadCount` is zero it means to initialize the context for synchronous rendering. This means that every
    /// operation will take effect immediately. If `threadCount` is `1` it means that the rendering will be asynchronous,
    /// but no thread would be acquired from a thread-pool, because the user thread will be used as a worker. And
    /// finally, if `threadCount` is greater than `1` then total of `threadCount - 1` threads will be acquired from
    /// thread-pool and used as additional workers.
    uint threadCount;

    /// CPU features to use in isolated JIT runtime (if supported), only used when `flags` contains
    /// `BL_CONTEXT_CREATE_FLAG_OVERRIDE_CPU_FEATURES`.
    uint cpuFeatures;

    /// Maximum number of commands to be queued.
    ///
    /// If this parameter is zero the queue size will be determined automatically.
    ///
    /// TODO: To be documented, has no effect at the moment.
    uint commandQueueLimit;

    /// Maximum number of saved states.
    ///
    /// \note Zero value tells the rendering engine to use the default saved state limit, which currently defaults
    /// to 4096 states. This option allows to even increase or decrease the limit, depending on the use case.
    uint savedStateLimit;

    /// Pixel origin.
    ///
    /// Pixel origin is an offset in pixel units that can be used as an origin for fetchers and effects that use a pixel
    /// X/Y coordinate in the calculation. One example of using pixel origin is dithering, where it's used to shift the
    /// dithering matrix.
    vec2i pixelOrigin;

    /// Reserved for future use, must be zero.
    uint[1] reserved;

    /// Resets the BLContextCreateInfo
    pragma(inline, true)
    void reset() { 
        this = BLContextCreateInfo.init;
    }
}

/// Holds an arbitrary 128-bit value (cookie) that can be used to match other cookies. Blend2D uses cookies in places
/// where it allows to "lock" some state that can only be unlocked by a matching cookie. Please don't confuse cookies
/// with a security of any kind, it's just an arbitrary data that must match to proceed with a certain operation.
///
/// Cookies can be used with \ref BLContext::save() and \ref BLContext::restore() operations.
struct BLContextCookie {
nothrow @nogc:
    ulong[2] data;

    /// Gets whether the BLContextCookie is empty
    bool empty() { return data[0] == 0 && data[1] == 0; }

    /// Resets the BLContextCookie to 0
    void reset() { reset(0, 0); }

    /// Resets the BLContextCookie to a specified 128 bit value
    void reset(ulong data0Init, ulong data1Init) {
        data[0] = data0Init;
        data[1] = data1Init;
    }

    /// Allows comparing cookies
    bool opEquals(inout(BLContextCookie) other) inout {
        return other.data[0] == data[0] && other.data[1] == data[1];
    }
}

/// Rendering context hints.
struct BLContextHints {
nothrow @nogc:
    union {
        struct {
            ubyte renderingQuality;
            ubyte gradientQuality;
            ubyte patternQuality;
        }

    }

    /// Resets the BLContextHints
    pragma(inline, true)
    void reset() {
        this = BLContextHints.init;
    }
}

/// Rendering context [C API].
struct BLContext {
    mixin BLExtends!BLObject;

private:
    const(void)* vtable;
    const(void)* state;
    uint contextType;

public:

    /**
        Resets the context
    */
    void reset() {
        blContextReset(&this);
    }

    /**
        Gets the type of this context
    */
    BLContextType getType() {
        return blContextGetType(&this);
    }

    /**
        Gets the size of the target image
    */
    BLSize getTargetSize() {
        BLSize size;
        blContextGetTargetSize(&this, &size);
        return size;
    }

    /**
        Gets the target image
    */
    BLImage* getTargetImage() {
        return blContextGetTargetImage(&this);
    }

    /**
        Takes ownership over the target image for rendering
    */
    BLResult begin(BLImage* image, const(BLContextCreateInfo)* cci = null) {
        return blContextBegin(&this, image, cci);
    }

    /**
        Ends rendering to the current target texture and reverts to default state.
    */
    BLResult end() {
        return blContextEnd(&this);
    }

    /**
        Flushes rendering operations.
    */
    BLResult flush(BLContextFlushFlags flags = BLContextFlushFlags.BL_CONTEXT_FLUSH_SYNC) {
        return blContextFlush(&this, flags);
    }

    /**
        Saves the state of the context
    */
    BLResult save() {
        return blContextSave(&this, null);
    }

    /**
        Saves the state of the context to a context cookie
    */
    BLContextCookie* save() {
        BLContextCookie cookie;
        blContextSave(&this, &cookie);
        return cookie;
    }

    /**
        Restores the state of the context
    */
    BLResult restore(const(BLContextCookie)* cookie = null) {
        return blContextRestore(&this, cookie);
    }
}

version(B2D_Static) {
nothrow @nogc extern(C):
    BLResult blContextInit(BLContext* self);
    BLResult blContextInitMove(BLContext* self, BLContext* other);
    BLResult blContextInitWeak(BLContext* self, const(BLContext)* other);
    BLResult blContextInitAs(BLContext* self, BLImage* image, const(BLContextCreateInfo)* cci);
    BLResult blContextDestroy(BLContext* self);

    BLResult blContextReset(BLContext* self);

    BLResult blContextAssignMove(BLContext* self, BLContext* other);
    BLResult blContextAssignWeak(BLContext* self, const(BLContext)* other);

    BLContextType blContextGetType(const(BLContext)* self) pure;
    BLResult blContextGetTargetSize(const(BLContext)* self, BLSize* targetSizeOut);
    BLImage* blContextGetTargetImage(const(BLContext)* self);

    BLResult blContextBegin(BLContext* self, BLImage* image, const(BLContextCreateInfo)* cci);
    BLResult blContextEnd(BLContext* self);

    BLResult blContextFlush(BLContext* self, BLContextFlushFlags flags);

    BLResult blContextSave(BLContext* self, BLContextCookie* cookie);
    BLResult blContextRestore(BLContext* self, const(BLContextCookie)* cookie);

    BLResult blContextGetMetaTransform(const(BLContext)* self, BLMatrix2D* transformOut);
    BLResult blContextGetUserTransform(const(BLContext)* self, BLMatrix2D* transformOut);
    BLResult blContextGetFinalTransform(const(BLContext)* self, BLMatrix2D* transformOut);
    BLResult blContextUserToMeta(BLContext* self);
    BLResult blContextApplyTransformOp(BLContext* self, BLTransformOp opType, const(void)* opData);

    uint blContextGetHint(const(BLContext)* self, BLContextHint hintType);
    BLResult blContextSetHint(BLContext* self, BLContextHint hintType, uint value);
    BLResult blContextGetHints(const(BLContext)* self, BLContextHints* hintsOut);
    BLResult blContextSetHints(BLContext* self, const BLContextHints* hints);

    BLResult blContextSetFlattenMode(BLContext* self, BLFlattenMode mode);
    BLResult blContextSetFlattenTolerance(BLContext* self, double tolerance);
    BLResult blContextSetApproximationOptions(BLContext* self, const BLApproximationOptions* options);

    BLResult blContextGetFillStyle(const(BLContext)* self, BLVar* styleOut);
    BLResult blContextGetTransformedFillStyle(const(BLContext)* self, BLVar* styleOut);
    BLResult blContextSetFillStyle(BLContext* self, const(BLUnknown)* style);
    BLResult blContextSetFillStyleWithMode(BLContext* self, const(BLUnknown)* style, BLContextStyleTransformMode transformMode);
    BLResult blContextSetFillStyleRgba(BLContext* self, const BLRgba* rgba);
    BLResult blContextSetFillStyleRgba32(BLContext* self, uint rgba32);
    BLResult blContextSetFillStyleRgba64(BLContext* self, ulong rgba64);
    BLResult blContextDisableFillStyle(BLContext* self);
    double blContextGetFillAlpha(const(BLContext)* self);
    BLResult blContextSetFillAlpha(BLContext* self, double alpha);

    BLResult blContextGetStrokeStyle(const(BLContext)* self, BLVar* styleOut);
    BLResult blContextGetTransformedStrokeStyle(const(BLContext)* self, BLVar* styleOut);
    BLResult blContextSetStrokeStyle(BLContext* self, const(BLUnknown)* style);
    BLResult blContextSetStrokeStyleWithMode(BLContext* self, const(BLUnknown)* style, BLContextStyleTransformMode transformMode);
    BLResult blContextSetStrokeStyleRgba(BLContext* self, const BLRgba* rgba);
    BLResult blContextSetStrokeStyleRgba32(BLContext* self, uint rgba32);
    BLResult blContextSetStrokeStyleRgba64(BLContext* self, ulong rgba64);
    BLResult blContextDisableStrokeStyle(BLContext* self);
    double blContextGetStrokeAlpha(const(BLContext)* self);
    BLResult blContextSetStrokeAlpha(BLContext* self, double alpha);

    BLResult blContextSwapStyles(BLContext* self, BLContextStyleSwapMode mode);

    double blContextGetGlobalAlpha(const(BLContext)* self);
    BLResult blContextSetGlobalAlpha(BLContext* self, double alpha);

    BLCompOp blContextGetCompOp(const(BLContext)* self);
    BLResult blContextSetCompOp(BLContext* self, BLCompOp compOp);

    BLFillRule blContextGetFillRule(const(BLContext)* self);
    BLResult blContextSetFillRule(BLContext* self, BLFillRule fillRule);

    double blContextGetStrokeWidth(const(BLContext)* self);
    BLResult blContextSetStrokeWidth(BLContext* self, double width);

    double blContextGetStrokeMiterLimit(const(BLContext)* self);
    BLResult blContextSetStrokeMiterLimit(BLContext* self, double miterLimit);

    BLStrokeCap blContextGetStrokeCap(const(BLContext)* self, BLStrokeCapPosition position);
    BLResult blContextSetStrokeCap(BLContext* self, BLStrokeCapPosition position, BLStrokeCap strokeCap);
    BLResult blContextSetStrokeCaps(BLContext* self, BLStrokeCap strokeCap);

    BLStrokeJoin blContextGetStrokeJoin(const(BLContext)* self);
    BLResult blContextSetStrokeJoin(BLContext* self, BLStrokeJoin strokeJoin);

    BLStrokeTransformOrder blContextGetStrokeTransformOrder(const(BLContext)* self);
    BLResult blContextSetStrokeTransformOrder(BLContext* self, BLStrokeTransformOrder transformOrder);

    double blContextGetStrokeDashOffset(const(BLContext)* self);
    BLResult blContextSetStrokeDashOffset(BLContext* self, double dashOffset);

    BLResult blContextGetStrokeDashArray(const(BLContext)* self, BLArray* dashArrayOut);
    BLResult blContextSetStrokeDashArray(BLContext* self, const BLArray* dashArray);

    BLResult blContextGetStrokeOptions(const(BLContext)* self, BLStrokeOptions* options);
    BLResult blContextSetStrokeOptions(BLContext* self, const BLStrokeOptions* options);

    BLResult blContextClipToRectI(BLContext* self, const(BLRectI)* rect);
    BLResult blContextClipToRectD(BLContext* self, const(BLRect)* rect);
    BLResult blContextRestoreClipping(BLContext* self);

    BLResult blContextClearAll(BLContext* self);
    BLResult blContextClearRectI(BLContext* self, const(BLRectI)* rect);
    BLResult blContextClearRectD(BLContext* self, const(BLRect)* rect);

    BLResult blContextFillAll(BLContext* self);
    BLResult blContextFillAllRgba32(BLContext* self, uint rgba32);
    BLResult blContextFillAllRgba64(BLContext* self, ulong rgba64);
    BLResult blContextFillAllExt(BLContext* self, const(BLUnknown)* style);

    BLResult blContextFillRectI(BLContext* self, const(BLRectI)* rect);
    BLResult blContextFillRectIRgba32(BLContext* self, const(BLRectI)* rect, uint rgba32);
    BLResult blContextFillRectIRgba64(BLContext* self, const(BLRectI)* rect, ulong rgba64);
    BLResult blContextFillRectIExt(BLContext* self, const(BLRectI)* rect, const(BLUnknown)* style);

    BLResult blContextFillRectD(BLContext* self, const(BLRect)* rect);
    BLResult blContextFillRectDRgba32(BLContext* self, const(BLRect)* rect, uint rgba32);
    BLResult blContextFillRectDRgba64(BLContext* self, const(BLRect)* rect, ulong rgba64);
    BLResult blContextFillRectDExt(BLContext* self, const(BLRect)* rect, const(BLUnknown)* style);

    BLResult blContextFillPathD(BLContext* self, const(BLPoint)* origin, const BLPath* path);
    BLResult blContextFillPathDRgba32(BLContext* self, const(BLPoint)* origin, const BLPath* path, uint rgba32);
    BLResult blContextFillPathDRgba64(BLContext* self, const(BLPoint)* origin, const BLPath* path, ulong rgba64);
    BLResult blContextFillPathDExt(BLContext* self, const(BLPoint)* origin, const BLPath* path, const(BLUnknown)* style);

    BLResult blContextFillGeometry(BLContext* self, BLGeometryType type, const(void)* data);
    BLResult blContextFillGeometryRgba32(BLContext* self, BLGeometryType type, const(void)* data, uint rgba32);
    BLResult blContextFillGeometryRgba64(BLContext* self, BLGeometryType type, const(void)* data, ulong rgba64);
    BLResult blContextFillGeometryExt(BLContext* self, BLGeometryType type, const(void)* data, const(BLUnknown)* style);

    BLResult blContextFillUtf8TextI(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size);
    BLResult blContextFillUtf8TextIRgba32(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, uint rgba32);
    BLResult blContextFillUtf8TextIRgba64(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, ulong rgba64);
    BLResult blContextFillUtf8TextIExt(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextFillUtf8TextD(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size);
    BLResult blContextFillUtf8TextDRgba32(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, uint rgba32);
    BLResult blContextFillUtf8TextDRgba64(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, ulong rgba64);
    BLResult blContextFillUtf8TextDExt(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextFillUtf16TextI(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size);
    BLResult blContextFillUtf16TextIRgba32(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, uint rgba32);
    BLResult blContextFillUtf16TextIRgba64(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, ulong rgba64);
    BLResult blContextFillUtf16TextIExt(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextFillUtf16TextD(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size);
    BLResult blContextFillUtf16TextDRgba32(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, uint rgba32);
    BLResult blContextFillUtf16TextDRgba64(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, ulong rgba64);
    BLResult blContextFillUtf16TextDExt(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextFillUtf32TextI(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size);
    BLResult blContextFillUtf32TextIRgba32(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, uint rgba32);
    BLResult blContextFillUtf32TextIRgba64(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, ulong rgba64);
    BLResult blContextFillUtf32TextIExt(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextFillUtf32TextD(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size);
    BLResult blContextFillUtf32TextDRgba32(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, uint rgba32);
    BLResult blContextFillUtf32TextDRgba64(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, ulong rgba64);
    BLResult blContextFillUtf32TextDExt(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextFillGlyphRunI(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun);
    BLResult blContextFillGlyphRunIRgba32(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, uint rgba32);
    BLResult blContextFillGlyphRunIRgba64(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, ulong rgba64);
    BLResult blContextFillGlyphRunIExt(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, const(BLUnknown)* style);

    BLResult blContextFillGlyphRunD(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun);
    BLResult blContextFillGlyphRunDRgba32(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, uint rgba32);
    BLResult blContextFillGlyphRunDRgba64(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, ulong rgba64);
    BLResult blContextFillGlyphRunDExt(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, const(BLUnknown)* style);

    BLResult blContextFillMaskI(BLContext* self, const(vec2i)* origin, const(BLImage)* mask, const(BLRectI)* maskArea);
    BLResult blContextFillMaskIRgba32(BLContext* self, const(vec2i)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, uint rgba32);
    BLResult blContextFillMaskIRgba64(BLContext* self, const(vec2i)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, ulong rgba64);
    BLResult blContextFillMaskIExt(BLContext* self, const(vec2i)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, const(BLUnknown)* style);

    BLResult blContextFillMaskD(BLContext* self, const(BLPoint)* origin, const(BLImage)* mask, const(BLRectI)* maskArea);
    BLResult blContextFillMaskDRgba32(BLContext* self, const(BLPoint)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, uint rgba32);
    BLResult blContextFillMaskDRgba64(BLContext* self, const(BLPoint)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, ulong rgba64);
    BLResult blContextFillMaskDExt(BLContext* self, const(BLPoint)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, const(BLUnknown)* style);

    BLResult blContextStrokeRectI(BLContext* self, const(BLRectI)* rect);
    BLResult blContextStrokeRectIRgba32(BLContext* self, const(BLRectI)* rect, uint rgba32);
    BLResult blContextStrokeRectIRgba64(BLContext* self, const(BLRectI)* rect, ulong rgba64);
    BLResult blContextStrokeRectIExt(BLContext* self, const(BLRectI)* rect, const(BLUnknown)* style);

    BLResult blContextStrokeRectD(BLContext* self, const(BLRect)* rect);
    BLResult blContextStrokeRectDRgba32(BLContext* self, const(BLRect)* rect, uint rgba32);
    BLResult blContextStrokeRectDRgba64(BLContext* self, const(BLRect)* rect, ulong rgba64);
    BLResult blContextStrokeRectDExt(BLContext* self, const(BLRect)* rect, const(BLUnknown)* style);

    BLResult blContextStrokePathD(BLContext* self, const(BLPoint)* origin, const BLPath* path);
    BLResult blContextStrokePathDRgba32(BLContext* self, const(BLPoint)* origin, const BLPath* path, uint rgba32);
    BLResult blContextStrokePathDRgba64(BLContext* self, const(BLPoint)* origin, const BLPath* path, ulong rgba64);
    BLResult blContextStrokePathDExt(BLContext* self, const(BLPoint)* origin, const BLPath* path, const(BLUnknown)* style);

    BLResult blContextStrokeGeometry(BLContext* self, BLGeometryType type, const(void)* data);
    BLResult blContextStrokeGeometryRgba32(BLContext* self, BLGeometryType type, const(void)* data, uint rgba32);
    BLResult blContextStrokeGeometryRgba64(BLContext* self, BLGeometryType type, const(void)* data, ulong rgba64);
    BLResult blContextStrokeGeometryExt(BLContext* self, BLGeometryType type, const(void)* data, const(BLUnknown)* style);

    BLResult blContextStrokeUtf8TextI(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size);
    BLResult blContextStrokeUtf8TextIRgba32(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, uint rgba32);
    BLResult blContextStrokeUtf8TextIRgba64(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, ulong rgba64);
    BLResult blContextStrokeUtf8TextIExt(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextStrokeUtf8TextD(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size);
    BLResult blContextStrokeUtf8TextDRgba32(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, uint rgba32);
    BLResult blContextStrokeUtf8TextDRgba64(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, ulong rgba64);
    BLResult blContextStrokeUtf8TextDExt(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextStrokeUtf16TextI(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size);
    BLResult blContextStrokeUtf16TextIRgba32(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, uint rgba32);
    BLResult blContextStrokeUtf16TextIRgba64(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, ulong rgba64);
    BLResult blContextStrokeUtf16TextIExt(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextStrokeUtf16TextD(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size);
    BLResult blContextStrokeUtf16TextDRgba32(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, uint rgba32);
    BLResult blContextStrokeUtf16TextDRgba64(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, ulong rgba64);
    BLResult blContextStrokeUtf16TextDExt(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextStrokeUtf32TextI(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size);
    BLResult blContextStrokeUtf32TextIRgba32(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, uint rgba32);
    BLResult blContextStrokeUtf32TextIRgba64(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, ulong rgba64);
    BLResult blContextStrokeUtf32TextIExt(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextStrokeUtf32TextD(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size);
    BLResult blContextStrokeUtf32TextDRgba32(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, uint rgba32);
    BLResult blContextStrokeUtf32TextDRgba64(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, ulong rgba64);
    BLResult blContextStrokeUtf32TextDExt(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, const(BLUnknown)* style);

    BLResult blContextStrokeGlyphRunI(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun);
    BLResult blContextStrokeGlyphRunIRgba32(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, uint rgba32);
    BLResult blContextStrokeGlyphRunIRgba64(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, ulong rgba64);
    BLResult blContextStrokeGlyphRunIExt(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, const(BLUnknown)* style);

    BLResult blContextStrokeGlyphRunD(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun);
    BLResult blContextStrokeGlyphRunDRgba32(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, uint rgba32);
    BLResult blContextStrokeGlyphRunDRgba64(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, ulong rgba64);
    BLResult blContextStrokeGlyphRunDExt(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, const(BLUnknown)* style);

    BLResult blContextBlitImageI(BLContext* self, const(vec2i)* origin, const(BLImage)* img, const(BLRectI)* imgArea);
    BLResult blContextBlitImageD(BLContext* self, const(BLPoint)* origin, const(BLImage)* img, const(BLRectI)* imgArea);
    BLResult blContextBlitScaledImageI(BLContext* self, const(BLRectI)* rect, const(BLImage)* img, const(BLRectI)* imgArea);
    BLResult blContextBlitScaledImageD(BLContext* self, const(BLRect)* rect, const(BLImage)* img, const(BLRectI)* imgArea);
} else {
nothrow @nogc extern(C):
    BLResult function(BLContext* self) blContextInit;
    BLResult function(BLContext* self, BLContext* other) blContextInitMove;
    BLResult function(BLContext* self, const(BLContext)* other) blContextInitWeak;
    BLResult function(BLContext* self, BLImage* image, const(BLContextCreateInfo)* cci) blContextInitAs;
    BLResult function(BLContext* self) blContextDestroy;
    BLResult function(BLContext* self) blContextReset;
    BLResult function(BLContext* self, BLContext* other) blContextAssignMove;
    BLResult function(BLContext* self, const(BLContext)* other) blContextAssignWeak;
    BLContextType function(const(BLContext)* self) pure blContextGetType;
    BLResult function(const(BLContext)* self, BLSize* targetSizeOut) blContextGetTargetSize;
    BLImage*function(const(BLContext)* self)  blContextGetTargetImage;
    BLResult function(BLContext* self, BLImage* image, const(BLContextCreateInfo)* cci) blContextBegin;
    BLResult function(BLContext* self) blContextEnd;
    BLResult function(BLContext* self, BLContextFlushFlags flags) blContextFlush;
    BLResult function(BLContext* self, BLContextCookie* cookie) blContextSave;
    BLResult function(BLContext* self, const(BLContextCookie)* cookie) blContextRestore;
    BLResult function(const(BLContext)* self, BLMatrix2D* transformOut) blContextGetMetaTransform;
    BLResult function(const(BLContext)* self, BLMatrix2D* transformOut) blContextGetUserTransform;
    BLResult function(const(BLContext)* self, BLMatrix2D* transformOut) blContextGetFinalTransform;
    BLResult function(BLContext* self) blContextUserToMeta;
    BLResult function(BLContext* self, BLTransformOp opType, const(void)* opData) blContextApplyTransformOp;
    uint function(const(BLContext)* self, BLContextHint hintType) blContextGetHint;
    BLResult function(BLContext* self, BLContextHint hintType, uint value) blContextSetHint;
    BLResult function(const(BLContext)* self, BLContextHints* hintsOut) blContextGetHints;
    BLResult function(BLContext* self, const BLContextHints* hints) blContextSetHints;
    BLResult function(BLContext* self, BLFlattenMode mode) blContextSetFlattenMode;
    BLResult function(BLContext* self, double tolerance) blContextSetFlattenTolerance;
    BLResult function(BLContext* self, const BLApproximationOptions* options) blContextSetApproximationOptions;
    BLResult function(const(BLContext)* self, BLVar* styleOut) blContextGetFillStyle;
    BLResult function(const(BLContext)* self, BLVar* styleOut) blContextGetTransformedFillStyle;
    BLResult function(BLContext* self, const(BLUnknown)* style) blContextSetFillStyle;
    BLResult function(BLContext* self, const(BLUnknown)* style, BLContextStyleTransformMode transformMode) blContextSetFillStyleWithMode;
    BLResult function(BLContext* self, const BLRgba* rgba) blContextSetFillStyleRgba;
    BLResult function(BLContext* self, uint rgba32) blContextSetFillStyleRgba32;
    BLResult function(BLContext* self, ulong rgba64) blContextSetFillStyleRgba64;
    BLResult function(BLContext* self) blContextDisableFillStyle;
    double function(const(BLContext)* self) blContextGetFillAlpha;
    BLResult function(BLContext* self, double alpha) blContextSetFillAlpha;
    BLResult function(const(BLContext)* self, BLVar* styleOut) blContextGetStrokeStyle;
    BLResult function(const(BLContext)* self, BLVar* styleOut) blContextGetTransformedStrokeStyle;
    BLResult function(BLContext* self, const(BLUnknown)* style) blContextSetStrokeStyle;
    BLResult function(BLContext* self, const(BLUnknown)* style, BLContextStyleTransformMode transformMode) blContextSetStrokeStyleWithMode;
    BLResult function(BLContext* self, const BLRgba* rgba) blContextSetStrokeStyleRgba;
    BLResult function(BLContext* self, uint rgba32) blContextSetStrokeStyleRgba32;
    BLResult function(BLContext* self, ulong rgba64) blContextSetStrokeStyleRgba64;
    BLResult function(BLContext* self) blContextDisableStrokeStyle;
    double function(const(BLContext)* self) blContextGetStrokeAlpha;
    BLResult function(BLContext* self, double alpha) blContextSetStrokeAlpha;
    BLResult function(BLContext* self, BLContextStyleSwapMode mode) blContextSwapStyles;
    double function(const(BLContext)* self) blContextGetGlobalAlpha;
    BLResult function(BLContext* self, double alpha) blContextSetGlobalAlpha;
    BLCompOp function(const(BLContext)* self) blContextGetCompOp;
    BLResult function(BLContext* self, BLCompOp compOp) blContextSetCompOp;
    BLFillRule function(const(BLContext)* self) blContextGetFillRule;
    BLResult function(BLContext* self, BLFillRule fillRule) blContextSetFillRule;
    double function(const(BLContext)* self) blContextGetStrokeWidth;
    BLResult function(BLContext* self, double width) blContextSetStrokeWidth;
    double function(const(BLContext)* self) blContextGetStrokeMiterLimit;
    BLResult function(BLContext* self, double miterLimit) blContextSetStrokeMiterLimit;
    BLStrokeCap function(const(BLContext)* self, BLStrokeCapPosition position) blContextGetStrokeCap;
    BLResult function(BLContext* self, BLStrokeCapPosition position, BLStrokeCap strokeCap) blContextSetStrokeCap;
    BLResult function(BLContext* self, BLStrokeCap strokeCap) blContextSetStrokeCaps;
    BLStrokeJoin function(const(BLContext)* self) blContextGetStrokeJoin;
    BLResult function(BLContext* self, BLStrokeJoin strokeJoin) blContextSetStrokeJoin;
    BLStrokeTransformOrder function(const(BLContext)* self) blContextGetStrokeTransformOrder;
    BLResult function(BLContext* self, BLStrokeTransformOrder transformOrder) blContextSetStrokeTransformOrder;
    double function(const(BLContext)* self) blContextGetStrokeDashOffset;
    BLResult function(BLContext* self, double dashOffset) blContextSetStrokeDashOffset;
    BLResult function(const(BLContext)* self, BLArray* dashArrayOut) blContextGetStrokeDashArray;
    BLResult function(BLContext* self, const BLArray* dashArray) blContextSetStrokeDashArray;
    BLResult function(const(BLContext)* self, BLStrokeOptions* options) blContextGetStrokeOptions;
    BLResult function(BLContext* self, const BLStrokeOptions* options) blContextSetStrokeOptions;
    BLResult function(BLContext* self, const(BLRectI)* rect) blContextClipToRectI;
    BLResult function(BLContext* self, const(BLRect)* rect) blContextClipToRectD;
    BLResult function(BLContext* self) blContextRestoreClipping;
    BLResult function(BLContext* self) blContextClearAll;
    BLResult function(BLContext* self, const(BLRectI)* rect) blContextClearRectI;
    BLResult function(BLContext* self, const(BLRect)* rect) blContextClearRectD;
    BLResult function(BLContext* self) blContextFillAll;
    BLResult function(BLContext* self, uint rgba32) blContextFillAllRgba32;
    BLResult function(BLContext* self, ulong rgba64) blContextFillAllRgba64;
    BLResult function(BLContext* self, const(BLUnknown)* style) blContextFillAllExt;
    BLResult function(BLContext* self, const(BLRectI)* rect) blContextFillRectI;
    BLResult function(BLContext* self, const(BLRectI)* rect, uint rgba32) blContextFillRectIRgba32;
    BLResult function(BLContext* self, const(BLRectI)* rect, ulong rgba64) blContextFillRectIRgba64;
    BLResult function(BLContext* self, const(BLRectI)* rect, const(BLUnknown)* style) blContextFillRectIExt;
    BLResult function(BLContext* self, const(BLRect)* rect) blContextFillRectD;
    BLResult function(BLContext* self, const(BLRect)* rect, uint rgba32) blContextFillRectDRgba32;
    BLResult function(BLContext* self, const(BLRect)* rect, ulong rgba64) blContextFillRectDRgba64;
    BLResult function(BLContext* self, const(BLRect)* rect, const(BLUnknown)* style) blContextFillRectDExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const BLPath* path) blContextFillPathD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const BLPath* path, uint rgba32) blContextFillPathDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const BLPath* path, ulong rgba64) blContextFillPathDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const BLPath* path, const(BLUnknown)* style) blContextFillPathDExt;
    BLResult function(BLContext* self, BLGeometryType type, const(void)* data) blContextFillGeometry;
    BLResult function(BLContext* self, BLGeometryType type, const(void)* data, uint rgba32) blContextFillGeometryRgba32;
    BLResult function(BLContext* self, BLGeometryType type, const(void)* data, ulong rgba64) blContextFillGeometryRgba64;
    BLResult function(BLContext* self, BLGeometryType type, const(void)* data, const(BLUnknown)* style) blContextFillGeometryExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size) blContextFillUtf8TextI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, uint rgba32) blContextFillUtf8TextIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, ulong rgba64) blContextFillUtf8TextIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, const(BLUnknown)* style) blContextFillUtf8TextIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size) blContextFillUtf8TextD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, uint rgba32) blContextFillUtf8TextDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, ulong rgba64) blContextFillUtf8TextDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, const(BLUnknown)* style) blContextFillUtf8TextDExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size) blContextFillUtf16TextI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, uint rgba32) blContextFillUtf16TextIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, ulong rgba64) blContextFillUtf16TextIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, const(BLUnknown)* style) blContextFillUtf16TextIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size) blContextFillUtf16TextD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, uint rgba32) blContextFillUtf16TextDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, ulong rgba64) blContextFillUtf16TextDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, const(BLUnknown)* style) blContextFillUtf16TextDExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size) blContextFillUtf32TextI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, uint rgba32) blContextFillUtf32TextIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, ulong rgba64) blContextFillUtf32TextIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, const(BLUnknown)* style) blContextFillUtf32TextIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size) blContextFillUtf32TextD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, uint rgba32) blContextFillUtf32TextDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, ulong rgba64) blContextFillUtf32TextDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, const(BLUnknown)* style) blContextFillUtf32TextDExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun) blContextFillGlyphRunI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, uint rgba32) blContextFillGlyphRunIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, ulong rgba64) blContextFillGlyphRunIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, const(BLUnknown)* style) blContextFillGlyphRunIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun) blContextFillGlyphRunD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, uint rgba32) blContextFillGlyphRunDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, ulong rgba64) blContextFillGlyphRunDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, const(BLUnknown)* style) blContextFillGlyphRunDExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLImage)* mask, const(BLRectI)* maskArea) blContextFillMaskI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, uint rgba32) blContextFillMaskIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, ulong rgba64) blContextFillMaskIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, const(BLUnknown)* style) blContextFillMaskIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLImage)* mask, const(BLRectI)* maskArea) blContextFillMaskD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, uint rgba32) blContextFillMaskDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, ulong rgba64) blContextFillMaskDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLImage)* mask, const(BLRectI)* maskArea, const(BLUnknown)* style) blContextFillMaskDExt;
    BLResult function(BLContext* self, const(BLRectI)* rect) blContextStrokeRectI;
    BLResult function(BLContext* self, const(BLRectI)* rect, uint rgba32) blContextStrokeRectIRgba32;
    BLResult function(BLContext* self, const(BLRectI)* rect, ulong rgba64) blContextStrokeRectIRgba64;
    BLResult function(BLContext* self, const(BLRectI)* rect, const(BLUnknown)* style) blContextStrokeRectIExt;
    BLResult function(BLContext* self, const(BLRect)* rect) blContextStrokeRectD;
    BLResult function(BLContext* self, const(BLRect)* rect, uint rgba32) blContextStrokeRectDRgba32;
    BLResult function(BLContext* self, const(BLRect)* rect, ulong rgba64) blContextStrokeRectDRgba64;
    BLResult function(BLContext* self, const(BLRect)* rect, const(BLUnknown)* style) blContextStrokeRectDExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const BLPath* path) blContextStrokePathD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const BLPath* path, uint rgba32) blContextStrokePathDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const BLPath* path, ulong rgba64) blContextStrokePathDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const BLPath* path, const(BLUnknown)* style) blContextStrokePathDExt;
    BLResult function(BLContext* self, BLGeometryType type, const(void)* data) blContextStrokeGeometry;
    BLResult function(BLContext* self, BLGeometryType type, const(void)* data, uint rgba32) blContextStrokeGeometryRgba32;
    BLResult function(BLContext* self, BLGeometryType type, const(void)* data, ulong rgba64) blContextStrokeGeometryRgba64;
    BLResult function(BLContext* self, BLGeometryType type, const(void)* data, const(BLUnknown)* style) blContextStrokeGeometryExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size) blContextStrokeUtf8TextI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, uint rgba32) blContextStrokeUtf8TextIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, ulong rgba64) blContextStrokeUtf8TextIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(char)* text, size_t size, const(BLUnknown)* style) blContextStrokeUtf8TextIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size) blContextStrokeUtf8TextD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, uint rgba32) blContextStrokeUtf8TextDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, ulong rgba64) blContextStrokeUtf8TextDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(char)* text, size_t size, const(BLUnknown)* style) blContextStrokeUtf8TextDExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size) blContextStrokeUtf16TextI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, uint rgba32) blContextStrokeUtf16TextIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, ulong rgba64) blContextStrokeUtf16TextIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(ushort)* text, size_t size, const(BLUnknown)* style) blContextStrokeUtf16TextIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size) blContextStrokeUtf16TextD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, uint rgba32) blContextStrokeUtf16TextDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, ulong rgba64) blContextStrokeUtf16TextDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(ushort)* text, size_t size, const(BLUnknown)* style) blContextStrokeUtf16TextDExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size) blContextStrokeUtf32TextI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, uint rgba32) blContextStrokeUtf32TextIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, ulong rgba64) blContextStrokeUtf32TextIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(uint)* text, size_t size, const(BLUnknown)* style) blContextStrokeUtf32TextIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size) blContextStrokeUtf32TextD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, uint rgba32) blContextStrokeUtf32TextDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, ulong rgba64) blContextStrokeUtf32TextDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(uint)* text, size_t size, const(BLUnknown)* style) blContextStrokeUtf32TextDExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun) blContextStrokeGlyphRunI;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, uint rgba32) blContextStrokeGlyphRunIRgba32;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, ulong rgba64) blContextStrokeGlyphRunIRgba64;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, const(BLUnknown)* style) blContextStrokeGlyphRunIExt;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun) blContextStrokeGlyphRunD;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, uint rgba32) blContextStrokeGlyphRunDRgba32;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, ulong rgba64) blContextStrokeGlyphRunDRgba64;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLFont)* font, const(BLGlyphRun)* glyphRun, const(BLUnknown)* style) blContextStrokeGlyphRunDExt;
    BLResult function(BLContext* self, const(vec2i)* origin, const(BLImage)* img, const(BLRectI)* imgArea) blContextBlitImageI;
    BLResult function(BLContext* self, const(BLPoint)* origin, const(BLImage)* img, const(BLRectI)* imgArea) blContextBlitImageD;
    BLResult function(BLContext* self, const(BLRectI)* rect, const(BLImage)* img, const(BLRectI)* imgArea) blContextBlitScaledImageI;
    BLResult function(BLContext* self, const(BLRect)* rect, const(BLImage)* img, const(BLRectI)* imgArea) blContextBlitScaledImageD;
}