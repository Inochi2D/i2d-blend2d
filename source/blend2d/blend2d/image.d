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

    // Maximum value of `BLFormat`.
    BL_FORMAT_MAX_VALUE = 3
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
struct BLImageCodecCore;

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

    /// Maximum value of `BLImageScaleFilter`.
    BL_IMAGE_SCALE_FILTER_MAX_VALUE = 4
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
struct BLImageCore;

struct BLImageDecoderCore;
struct BLImageEncoderCore;

version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blImageCodecInit(BLImageCodecCore* self);
    BLResult blImageCodecInitMove(BLImageCodecCore* self, BLImageCodecCore* other);
    BLResult blImageCodecInitWeak(BLImageCodecCore* self, const(BLImageCodecCore)* other);
    BLResult blImageCodecInitByName(BLImageCodecCore* self, const(char)* name, size_t size, const BLArrayCore* codecs);
    BLResult blImageCodecDestroy(BLImageCodecCore* self);
    BLResult blImageCodecReset(BLImageCodecCore* self);
    BLResult blImageCodecAssignMove(BLImageCodecCore* self, BLImageCodecCore* other);
    BLResult blImageCodecAssignWeak(BLImageCodecCore* self, const(BLImageCodecCore)* other);
    BLResult blImageCodecFindByName(BLImageCodecCore* self, const(char)* name, size_t size, const BLArrayCore* codecs);
    BLResult blImageCodecFindByExtension(BLImageCodecCore* self, const(char)* name, size_t size, const BLArrayCore* codecs);
    BLResult blImageCodecFindByData(BLImageCodecCore* self, const(void)* data, size_t size, const BLArrayCore* codecs);
    uint     blImageCodecInspectData(const(BLImageCodecCore)* self, const(void)* data, size_t size);
    BLResult blImageCodecCreateDecoder(const(BLImageCodecCore)* self, BLImageDecoderCore* dst);
    BLResult blImageCodecCreateEncoder(const(BLImageCodecCore)* self, BLImageEncoderCore* dst);

    BLResult blImageCodecArrayInitBuiltInCodecs(BLArrayCore* self);
    BLResult blImageCodecArrayAssignBuiltInCodecs(BLArrayCore* self);
    BLResult blImageCodecAddToBuiltIn(const(BLImageCodecCore)* codec);
    BLResult blImageCodecRemoveFromBuiltIn(const(BLImageCodecCore)* codec);

    BLResult blImageInit(BLImageCore* self);
    BLResult blImageInitMove(BLImageCore* self, BLImageCore* other);
    BLResult blImageInitWeak(BLImageCore* self, const(BLImageCore)* other);
    BLResult blImageInitAs(BLImageCore* self, int w, int h, BLFormat format);
    BLResult blImageInitAsFromData(BLImageCore* self, int w, int h, BLFormat format, void* pixelData, ptrdiff_t stride, BLDataAccessFlags accessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData);
    BLResult blImageDestroy(BLImageCore* self);
    BLResult blImageReset(BLImageCore* self);
    BLResult blImageAssignMove(BLImageCore* self, BLImageCore* other);
    BLResult blImageAssignWeak(BLImageCore* self, const(BLImageCore)* other);
    BLResult blImageAssignDeep(BLImageCore* self, const(BLImageCore)* other);
    BLResult blImageCreate(BLImageCore* self, int w, int h, BLFormat format);
    BLResult blImageCreateFromData(BLImageCore* self, int w, int h, BLFormat format, void* pixelData, ptrdiff_t stride, BLDataAccessFlags accessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData);
    BLResult blImageGetData(const(BLImageCore)* self, BLImageData* dataOut);
    BLResult blImageMakeMutable(BLImageCore* self, BLImageData* dataOut);
    BLResult blImageConvert(BLImageCore* self, BLFormat format);
    bool     blImageEquals(const(BLImageCore)* a, const(BLImageCore)* b);
    BLResult blImageScale(BLImageCore* dst, const(BLImageCore)* src, const(BLSizeI)* size, BLImageScaleFilter filter);
    BLResult blImageReadFromFile(BLImageCore* self, const(char)* fileName, const(BLArrayCore)* codecs);
    BLResult blImageReadFromData(BLImageCore* self, const(void)* data, size_t size, const(BLArrayCore)* codecs);
    BLResult blImageWriteToFile(const(BLImageCore)* self, const(char)* fileName, const(BLImageCodecCore)* codec);
    BLResult blImageWriteToData(const(BLImageCore)* self, BLArrayCore* dst, const(BLImageCodecCore)* codec);
} else {
nothrow @nogc extern(C):

    BLResult function(BLImageCodecCore* self) blImageCodecInit;
    BLResult function(BLImageCodecCore* self, BLImageCodecCore* other) blImageCodecInitMove;
    BLResult function(BLImageCodecCore* self, const(BLImageCodecCore)* other) blImageCodecInitWeak;
    BLResult function(BLImageCodecCore* self, const(char)* name, size_t size, const BLArrayCore* codecs) blImageCodecInitByName;
    BLResult function(BLImageCodecCore* self) blImageCodecDestroy;
    BLResult function(BLImageCodecCore* self) blImageCodecReset;
    BLResult function(BLImageCodecCore* self, BLImageCodecCore* other) blImageCodecAssignMove;
    BLResult function(BLImageCodecCore* self, const(BLImageCodecCore)* other) blImageCodecAssignWeak;
    BLResult function(BLImageCodecCore* self, const(char)* name, size_t size, const BLArrayCore* codecs) blImageCodecFindByName;
    BLResult function(BLImageCodecCore* self, const(char)* name, size_t size, const BLArrayCore* codecs) blImageCodecFindByExtension;
    BLResult function(BLImageCodecCore* self, const(void)* data, size_t size, const BLArrayCore* codecs) blImageCodecFindByData;
    uint     function(const(BLImageCodecCore)* self, const(void)* data, size_t size) blImageCodecInspectData;
    BLResult function(const(BLImageCodecCore)* self, BLImageDecoderCore* dst) blImageCodecCreateDecoder;
    BLResult function(const(BLImageCodecCore)* self, BLImageEncoderCore* dst) blImageCodecCreateEncoder;
    BLResult function(BLArrayCore* self) blImageCodecArrayInitBuiltInCodecs;
    BLResult function(BLArrayCore* self) blImageCodecArrayAssignBuiltInCodecs;
    BLResult function(const(BLImageCodecCore)* codec) blImageCodecAddToBuiltIn;
    BLResult function(const(BLImageCodecCore)* codec) blImageCodecRemoveFromBuiltIn;
    BLResult function(BLImageCore* self) blImageInit;
    BLResult function(BLImageCore* self, BLImageCore* other) blImageInitMove;
    BLResult function(BLImageCore* self, const(BLImageCore)* other) blImageInitWeak;
    BLResult function(BLImageCore* self, int w, int h, BLFormat format) blImageInitAs;
    BLResult function(BLImageCore* self, int w, int h, BLFormat format, void* pixelData, ptrdiff_t stride, BLDataAccessFlags accessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData) blImageInitAsFromData;
    BLResult function(BLImageCore* self) blImageDestroy;
    BLResult function(BLImageCore* self) blImageReset;
    BLResult function(BLImageCore* self, BLImageCore* other) blImageAssignMove;
    BLResult function(BLImageCore* self, const(BLImageCore)* other) blImageAssignWeak;
    BLResult function(BLImageCore* self, const(BLImageCore)* other) blImageAssignDeep;
    BLResult function(BLImageCore* self, int w, int h, BLFormat format) blImageCreate;
    BLResult function(BLImageCore* self, int w, int h, BLFormat format, void* pixelData, ptrdiff_t stride, BLDataAccessFlags accessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData) blImageCreateFromData;
    BLResult function(const(BLImageCore)* self, BLImageData* dataOut) blImageGetData;
    BLResult function(BLImageCore* self, BLImageData* dataOut) blImageMakeMutable;
    BLResult function(BLImageCore* self, BLFormat format) blImageConvert;
    bool     function(const(BLImageCore)* a, const(BLImageCore)* b) blImageEquals;
    BLResult function(BLImageCore* dst, const(BLImageCore)* src, const(BLSizeI)* size, BLImageScaleFilter filter) blImageScale;
    BLResult function(BLImageCore* self, const(char)* fileName, const(BLArrayCore)* codecs) blImageReadFromFile;
    BLResult function(BLImageCore* self, const(void)* data, size_t size, const(BLArrayCore)* codecs) blImageReadFromData;
    BLResult function(const(BLImageCore)* self, const(char)* fileName, const(BLImageCodecCore)* codec) blImageWriteToFile;
    BLResult function(const(BLImageCore)* self, BLArrayCore* dst, const(BLImageCodecCore)* codec) blImageWriteToData;
}