module blend2d.blend2d.image;
import blend2d.blend2d.geometry;
import blend2d.blend2d.api;
import blend2d.blend2d.array;

/// Pixel format.
///
/// Compatibility Table
/// -------------------
///
/// ```
/// +---------------------+---------------------+-----------------------------+
/// | Blend2D Format      | Cairo Format        | QImage::Format              |
/// +---------------------+---------------------+-----------------------------+
/// | BL_FORMAT_PRGB32    | CAIRO_FORMAT_ARGB32 | Format_ARGB32_Premultiplied |
/// | BL_FORMAT_XRGB32    | CAIRO_FORMAT_RGB24  | Format_RGB32                |
/// | BL_FORMAT_A8        | CAIRO_FORMAT_A8     | n/a                         |
/// +---------------------+---------------------+-----------------------------+
/// ```
enum BLFormat : uint {

    /// None or invalid pixel format.
    BL_FORMAT_NONE = 0,
    /// 32-bit premultiplied ARGB pixel format (8-bit components).
    BL_FORMAT_PRGB32 = 1,
    /// 32-bit (X)RGB pixel format (8-bit components, alpha ignored).
    BL_FORMAT_XRGB32 = 2,
    /// 8-bit alpha-only pixel format.
    BL_FORMAT_A8 = 3,


}

/// Pixel format flags.
enum BLFormatFlags : uint {

    /// No flags.
    BL_FORMAT_NO_FLAGS = 0u,
    /// Pixel format provides RGB components.
    BL_FORMAT_FLAG_RGB = 0x00000001u,
    /// Pixel format provides only alpha component.
    BL_FORMAT_FLAG_ALPHA = 0x00000002u,
    /// A combination of `BL_FORMAT_FLAG_RGB | BL_FORMAT_FLAG_ALPHA`.
    BL_FORMAT_FLAG_RGBA = 0x00000003u,
    /// Pixel format provides LUM component (and not RGB components).
    BL_FORMAT_FLAG_LUM = 0x00000004u,
    /// A combination of `BL_FORMAT_FLAG_LUM | BL_FORMAT_FLAG_ALPHA`.
    BL_FORMAT_FLAG_LUMA = 0x00000006u,
    /// Indexed pixel format the requires a palette (I/O only).
    BL_FORMAT_FLAG_INDEXED = 0x00000010u,
    /// RGB components are premultiplied by alpha component.
    BL_FORMAT_FLAG_PREMULTIPLIED = 0x00000100u,
    /// Pixel format doesn't use native byte-order (I/O only).
    BL_FORMAT_FLAG_BYTE_SWAP = 0x00000200u,

    // The following flags are only informative. They are part of `blFormatInfo[]`, but don't have to be passed to
    // `BLPixelConverter` as they will always be calculated automatically.

    /// Pixel components are byte aligned (all 8bpp).
    BL_FORMAT_FLAG_BYTE_ALIGNED = 0x00010000u,

    /// Pixel has some undefined bits that represent no information.
    ///
    /// For example a 32-bit XRGB pixel has 8 undefined bits that are usually set to all ones so the format can be
    /// interpreted as premultiplied RGB as well. There are other formats like 16_0555 where the bit has no information
    /// and is usually set to zero. Blend2D doesn't rely on the content of such bits.
    BL_FORMAT_FLAG_UNDEFINED_BITS = 0x00020000u
}


/// Image codec feature bits.
enum BLImageCodecFeatures : uint {

    /// No features.
    BL_IMAGE_CODEC_NO_FEATURES = 0u,
    /// Image codec supports reading images (can create BLImageDecoder).
    BL_IMAGE_CODEC_FEATURE_READ = 0x00000001u,
    /// Image codec supports writing images (can create BLImageEncoder).
    BL_IMAGE_CODEC_FEATURE_WRITE = 0x00000002u,
    /// Image codec supports lossless compression.
    BL_IMAGE_CODEC_FEATURE_LOSSLESS = 0x00000004u,
    /// Image codec supports loosy compression.
    BL_IMAGE_CODEC_FEATURE_LOSSY = 0x00000008u,
    /// Image codec supports writing multiple frames (GIF).
    BL_IMAGE_CODEC_FEATURE_MULTI_FRAME = 0x00000010u,
    /// Image codec supports IPTC metadata.
    BL_IMAGE_CODEC_FEATURE_IPTC = 0x10000000u,
    /// Image codec supports EXIF metadata.
    BL_IMAGE_CODEC_FEATURE_EXIF = 0x20000000u,
    /// Image codec supports XMP metadata.
    BL_IMAGE_CODEC_FEATURE_XMP = 0x40000000u
}

/// Image codec [C API].
struct BLImageCodec {
    mixin BLExtends!BLObject;
}

/// Flags used by `BLImageInfo`.
enum BLImageInfoFlags : uint {

    /// No flags.
    BL_IMAGE_INFO_FLAG_NO_FLAGS = 0u,

    /// Progressive mode.
    BL_IMAGE_INFO_FLAG_PROGRESSIVE = 0x00000001u
}

/// Filter type used by `BLImage::scale()`.
enum BLImageScaleFilter : uint {

    /// No filter or uninitialized.
    BL_IMAGE_SCALE_FILTER_NONE = 0,
    /// Nearest neighbor filter (radius 1.0).
    BL_IMAGE_SCALE_FILTER_NEAREST = 1,
    /// Bilinear filter (radius 1.0).
    BL_IMAGE_SCALE_FILTER_BILINEAR = 2,
    /// Bicubic filter (radius 2.0).
    BL_IMAGE_SCALE_FILTER_BICUBIC = 3,
    /// Lanczos filter (radius 2.0).
    BL_IMAGE_SCALE_FILTER_LANCZOS = 4,


}

/// Data that describes a raster image. Used by `BLImage`.
struct BLImageData {
nothrow @nogc:
    void* pixelData;
    ptrdiff_t stride;
    BLSizeI size;
    uint format;
    uint flags;

    /// Resets the BLImageData
    pragma(inline, true)
    void reset() nothrow { this = BLImageData.init; }
}

/// Image information provided by image codecs.
struct BLImageInfo {
nothrow @nogc:
    /// Image size.
    BLSizeI size;
    /// Pixel density per one meter, can contain fractions.
    BLSize density;

    /// Image flags.
    uint flags;
    /// Image depth.
    ushort depth;
    /// Number of planes.
    ushort planeCount;
    /// Number of frames (0 = unknown/unspecified).
    ulong frameCount;

    /// Image format (as understood by codec).
    ubyte[16] format;
    /// Image compression (as understood by codec).
    ubyte[16] compression;

    /// Resets the BLImageInfo
    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}

/// Image [C API].
struct BLImage {
    mixin BLExtends!BLObject;

    //! Pixel data.
    void* pixelData;
    //! Image stride.
    ptrdiff_t stride;
    //! Image size.
    BLSizeI size;
    //! Image format.
    ubyte format;
    //! Image flags.
    ubyte flags;
    //! Image depth (in bits).
    ushort depth;
    //! Reserved for future use, must be zero.
    ubyte[4] reserved;
}

struct BLImageDecoder {
    mixin BLExtends!BLObject;
}
    
struct BLImageEncoder {
    mixin BLExtends!BLObject;
}

version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blImageCodecInit(BLImageCodec* self);
    BLResult blImageCodecInitMove(BLImageCodec* self, BLImageCodec* other);
    BLResult blImageCodecInitWeak(BLImageCodec* self, const(BLImageCodec)* other);
    BLResult blImageCodecInitByName(BLImageCodec* self, const(char)* name, size_t size, const BLArray* codecs);
    BLResult blImageCodecDestroy(BLImageCodec* self);
    BLResult blImageCodecReset(BLImageCodec* self);
    BLResult blImageCodecAssignMove(BLImageCodec* self, BLImageCodec* other);
    BLResult blImageCodecAssignWeak(BLImageCodec* self, const(BLImageCodec)* other);
    BLResult blImageCodecFindByName(BLImageCodec* self, const(char)* name, size_t size, const BLArray* codecs);
    BLResult blImageCodecFindByExtension(BLImageCodec* self, const(char)* name, size_t size, const BLArray* codecs);
    BLResult blImageCodecFindByData(BLImageCodec* self, const(void)* data, size_t size, const BLArray* codecs);
    uint     blImageCodecInspectData(const(BLImageCodec)* self, const(void)* data, size_t size);
    BLResult blImageCodecCreateDecoder(const(BLImageCodec)* self, BLImageDecoder* dst);
    BLResult blImageCodecCreateEncoder(const(BLImageCodec)* self, BLImageEncoder* dst);

    BLResult blImageCodecArrayInitBuiltInCodecs(BLArray* self);
    BLResult blImageCodecArrayAssignBuiltInCodecs(BLArray* self);
    BLResult blImageCodecAddToBuiltIn(const(BLImageCodec)* codec);
    BLResult blImageCodecRemoveFromBuiltIn(const(BLImageCodec)* codec);

    BLResult blImageInit(BLImage* self);
    BLResult blImageInitMove(BLImage* self, BLImage* other);
    BLResult blImageInitWeak(BLImage* self, const(BLImage)* other);
    BLResult blImageInitAs(BLImage* self, int w, int h, BLFormat format);
    BLResult blImageInitAsFromData(BLImage* self, int w, int h, BLFormat format, void* pixelData, ptrdiff_t stride, BLDataAccessFlags accessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData);
    BLResult blImageDestroy(BLImage* self);
    BLResult blImageReset(BLImage* self);
    BLResult blImageAssignMove(BLImage* self, BLImage* other);
    BLResult blImageAssignWeak(BLImage* self, const(BLImage)* other);
    BLResult blImageAssignDeep(BLImage* self, const(BLImage)* other);
    BLResult blImageCreate(BLImage* self, int w, int h, BLFormat format);
    BLResult blImageCreateFromData(BLImage* self, int w, int h, BLFormat format, void* pixelData, ptrdiff_t stride, BLDataAccessFlags accessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData);
    BLResult blImageGetData(const(BLImage)* self, BLImageData* dataOut);
    BLResult blImageMakeMutable(BLImage* self, BLImageData* dataOut);
    BLResult blImageConvert(BLImage* self, BLFormat format);
    bool     blImageEquals(const(BLImage)* a, const(BLImage)* b);
    BLResult blImageScale(BLImage* dst, const(BLImage)* src, const(BLSizeI)* size, BLImageScaleFilter filter);
    BLResult blImageReadFromFile(BLImage* self, const(char)* fileName, const(BLArray)* codecs);
    BLResult blImageReadFromData(BLImage* self, const(void)* data, size_t size, const(BLArray)* codecs);
    BLResult blImageWriteToFile(const(BLImage)* self, const(char)* fileName, const(BLImageCodec)* codec);
    BLResult blImageWriteToData(const(BLImage)* self, BLArray* dst, const(BLImageCodec)* codec);
} else {
nothrow @nogc extern(C):

    BLResult function(BLImageCodec* self) blImageCodecInit;
    BLResult function(BLImageCodec* self, BLImageCodec* other) blImageCodecInitMove;
    BLResult function(BLImageCodec* self, const(BLImageCodec)* other) blImageCodecInitWeak;
    BLResult function(BLImageCodec* self, const(char)* name, size_t size, const BLArray* codecs) blImageCodecInitByName;
    BLResult function(BLImageCodec* self) blImageCodecDestroy;
    BLResult function(BLImageCodec* self) blImageCodecReset;
    BLResult function(BLImageCodec* self, BLImageCodec* other) blImageCodecAssignMove;
    BLResult function(BLImageCodec* self, const(BLImageCodec)* other) blImageCodecAssignWeak;
    BLResult function(BLImageCodec* self, const(char)* name, size_t size, const BLArray* codecs) blImageCodecFindByName;
    BLResult function(BLImageCodec* self, const(char)* name, size_t size, const BLArray* codecs) blImageCodecFindByExtension;
    BLResult function(BLImageCodec* self, const(void)* data, size_t size, const BLArray* codecs) blImageCodecFindByData;
    uint     function(const(BLImageCodec)* self, const(void)* data, size_t size) blImageCodecInspectData;
    BLResult function(const(BLImageCodec)* self, BLImageDecoder* dst) blImageCodecCreateDecoder;
    BLResult function(const(BLImageCodec)* self, BLImageEncoder* dst) blImageCodecCreateEncoder;
    BLResult function(BLArray* self) blImageCodecArrayInitBuiltInCodecs;
    BLResult function(BLArray* self) blImageCodecArrayAssignBuiltInCodecs;
    BLResult function(const(BLImageCodec)* codec) blImageCodecAddToBuiltIn;
    BLResult function(const(BLImageCodec)* codec) blImageCodecRemoveFromBuiltIn;
    BLResult function(BLImage* self) blImageInit;
    BLResult function(BLImage* self, BLImage* other) blImageInitMove;
    BLResult function(BLImage* self, const(BLImage)* other) blImageInitWeak;
    BLResult function(BLImage* self, int w, int h, BLFormat format) blImageInitAs;
    BLResult function(BLImage* self, int w, int h, BLFormat format, void* pixelData, ptrdiff_t stride, BLDataAccessFlags accessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData) blImageInitAsFromData;
    BLResult function(BLImage* self) blImageDestroy;
    BLResult function(BLImage* self) blImageReset;
    BLResult function(BLImage* self, BLImage* other) blImageAssignMove;
    BLResult function(BLImage* self, const(BLImage)* other) blImageAssignWeak;
    BLResult function(BLImage* self, const(BLImage)* other) blImageAssignDeep;
    BLResult function(BLImage* self, int w, int h, BLFormat format) blImageCreate;
    BLResult function(BLImage* self, int w, int h, BLFormat format, void* pixelData, ptrdiff_t stride, BLDataAccessFlags accessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData) blImageCreateFromData;
    BLResult function(const(BLImage)* self, BLImageData* dataOut) blImageGetData;
    BLResult function(BLImage* self, BLImageData* dataOut) blImageMakeMutable;
    BLResult function(BLImage* self, BLFormat format) blImageConvert;
    bool     function(const(BLImage)* a, const(BLImage)* b) blImageEquals;
    BLResult function(BLImage* dst, const(BLImage)* src, const(BLSizeI)* size, BLImageScaleFilter filter) blImageScale;
    BLResult function(BLImage* self, const(char)* fileName, const(BLArray)* codecs) blImageReadFromFile;
    BLResult function(BLImage* self, const(void)* data, size_t size, const(BLArray)* codecs) blImageReadFromData;
    BLResult function(const(BLImage)* self, const(char)* fileName, const(BLImageCodec)* codec) blImageWriteToFile;
    BLResult function(const(BLImage)* self, BLArray* dst, const(BLImageCodec)* codec) blImageWriteToData;
}