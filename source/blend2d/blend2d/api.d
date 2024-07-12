module blend2d.blend2d.api;
import core.vararg;

/// \ingroup blend2d_api_globals
///
/// Result code used by most Blend2D functions (32-bit unsigned integer).
///
/// The `BLResult` enumeration contains Blend2D result codes that contain Blend2D specific set of errors and
/// an extended set of errors that can come from WIN32 or POSIX APIs. Since the success result code is zero it's
/// recommended to use the following check to determine whether a call failed or not:
///
/// ```
/// BLResult result = doSomething();
/// if (result != BLResult.BL_SUCCESS) {
///   // `doSomething()` failed...
/// }
/// ```
enum BLResult {

    BL_SUCCESS = 0,                         /// Successful result code.
    BL_ERROR_START_INDEX = 0x00010000u,

    BL_ERROR_OUT_OF_MEMORY = 0x00010000u,   /// Out of memory                 [ENOMEM].
    BL_ERROR_INVALID_VALUE,                 /// Invalid value/argument        [EINVAL].
    BL_ERROR_INVALID_STATE,                 /// Invalid state                 [EFAULT].
    BL_ERROR_INVALID_HANDLE,                /// Invalid handle or file.       [EBADF].
    BL_ERROR_INVALID_CONVERSION,            /// Invalid conversion.
    BL_ERROR_OVERFLOW,                      /// Overflow or value too large   [EOVERFLOW].
    BL_ERROR_NOT_INITIALIZED,               /// Object not initialized.
    BL_ERROR_NOT_IMPLEMENTED,               /// Not implemented               [ENOSYS].
    BL_ERROR_NOT_PERMITTED,                 /// Operation not permitted       [EPERM].

    BL_ERROR_IO,                            /// IO error                      [EIO].
    BL_ERROR_BUSY,                          /// Device or resource busy       [EBUSY].
    BL_ERROR_INTERRUPTED,                   /// Operation interrupted         [EINTR].
    BL_ERROR_TRY_AGAIN,                     /// Try again                     [EAGAIN].
    BL_ERROR_TIMED_OUT,                     /// Timed out_                     [ETIMEDOUT].
    BL_ERROR_BROKEN_PIPE,                   /// Broken pipe                   [EPIPE].
    BL_ERROR_INVALID_SEEK,                  /// File is not seekable          [ESPIPE].
    BL_ERROR_SYMLINK_LOOP,                  /// Too many levels of symlinks   [ELOOP].
    BL_ERROR_FILE_TOO_LARGE,                /// File is too large             [EFBIG].
    BL_ERROR_ALREADY_EXISTS,                /// File/directory already exists [EEXIST].
    BL_ERROR_ACCESS_DENIED,                 /// Access denied                 [EACCES].
    BL_ERROR_MEDIA_CHANGED,                 /// Media changed                 [Windows::ERROR_MEDIA_CHANGED].
    BL_ERROR_READ_ONLY_FS,                  /// The file/FS is read-only      [EROFS].
    BL_ERROR_NO_DEVICE,                     /// Device doesn't exist          [ENXIO].
    BL_ERROR_NO_ENTRY,                      /// Not found, no entry (fs)      [ENOENT].
    BL_ERROR_NO_MEDIA,                      /// No media in drive/device      [ENOMEDIUM].
    BL_ERROR_NO_MORE_DATA,                  /// No more data / end of file    [ENODATA].
    BL_ERROR_NO_MORE_FILES,                 /// No more files                 [ENMFILE].
    BL_ERROR_NO_SPACE_LEFT,                 /// No space left on device       [ENOSPC].
    BL_ERROR_NOT_EMPTY,                     /// Directory is not empty        [ENOTEMPTY].
    BL_ERROR_NOT_FILE,                      /// Not a file                    [EISDIR].
    BL_ERROR_NOT_DIRECTORY,                 /// Not a directory               [ENOTDIR].
    BL_ERROR_NOT_SAME_DEVICE,               /// Not same device               [EXDEV].
    BL_ERROR_NOT_BLOCK_DEVICE,              /// Not a block device            [ENOTBLK].

    BL_ERROR_INVALID_FILE_NAME,             /// File/path name is invalid     [n/a].
    BL_ERROR_FILE_NAME_TOO_LONG,            /// File/path name is too long    [ENAMETOOLONG].

    BL_ERROR_TOO_MANY_OPEN_FILES,           /// Too many open files           [EMFILE].
    BL_ERROR_TOO_MANY_OPEN_FILES_BY_OS,     /// Too many open files by OS     [ENFILE].
    BL_ERROR_TOO_MANY_LINKS,                /// Too many symbolic links on FS [EMLINK].
    BL_ERROR_TOO_MANY_THREADS,              /// Too many threads              [EAGAIN].
    BL_ERROR_THREAD_POOL_EXHAUSTED,         /// Thread pool is exhausted and couldn't acquire the requested thread count.

    BL_ERROR_FILE_EMPTY,                    /// File is empty (not specific to any OS error).
    BL_ERROR_OPEN_FAILED,                   /// File open failed              [Windows::ERROR_OPEN_FAILED].
    BL_ERROR_NOT_ROOT_DEVICE,               /// Not a root device/directory   [Windows::ERROR_DIR_NOT_ROOT].

    BL_ERROR_UNKNOWN_SYSTEM_ERROR,          /// Unknown system error that failed to translate to Blend2D result code.

    BL_ERROR_INVALID_ALIGNMENT,             /// Invalid data alignment.
    BL_ERROR_INVALID_SIGNATURE,             /// Invalid data signature or header.
    BL_ERROR_INVALID_DATA,                  /// Invalid or corrupted data.
    BL_ERROR_INVALID_STRING,                /// Invalid string (invalid data of either UTF8, UTF16, or UTF32).
    BL_ERROR_INVALID_KEY,                   /// Invalid key or property.
    BL_ERROR_DATA_TRUNCATED,                /// Truncated data (more data required than memory/stream provides).
    BL_ERROR_DATA_TOO_LARGE,                /// Input data too large to be processed.
    BL_ERROR_DECOMPRESSION_FAILED,          /// Decompression failed due to invalid data (RLE, Huffman, etc).

    BL_ERROR_INVALID_GEOMETRY,              /// Invalid geometry (invalid path data or shape).
    BL_ERROR_NO_MATCHING_VERTEX,            /// Returned when there is no matching vertex in path data.

    BL_ERROR_INVALID_CREATE_FLAGS,          /// Invalid create flags (BLContext).
    BL_ERROR_NO_MATCHING_COOKIE,            /// No matching cookie (BLContext).
    BL_ERROR_NO_STATES_TO_RESTORE,          /// No states to restore (BLContext).
    BL_ERROR_TOO_MANY_SAVED_STATES,         /// Cannot save state as the number of saved states reached the limit (BLContext).

    BL_ERROR_IMAGE_TOO_LARGE,               /// The size of the image is too large.
    BL_ERROR_IMAGE_NO_MATCHING_CODEC,       /// Image codec for a required format doesn't exist.
    BL_ERROR_IMAGE_UNKNOWN_FILE_FORMAT,     /// Unknown or invalid file format that cannot be read.
    BL_ERROR_IMAGE_DECODER_NOT_PROVIDED,    /// Image codec doesn't support reading the file format.
    BL_ERROR_IMAGE_ENCODER_NOT_PROVIDED,    /// Image codec doesn't support writing the file format.

    BL_ERROR_PNG_MULTIPLE_IHDR,             /// Multiple IHDR chunks are not allowed (PNG).
    BL_ERROR_PNG_INVALID_IDAT,              /// Invalid IDAT chunk (PNG).
    BL_ERROR_PNG_INVALID_IEND,              /// Invalid IEND chunk (PNG).
    BL_ERROR_PNG_INVALID_PLTE,              /// Invalid PLTE chunk (PNG).
    BL_ERROR_PNG_INVALID_TRNS,              /// Invalid tRNS chunk (PNG).
    BL_ERROR_PNG_INVALID_FILTER,            /// Invalid filter type (PNG).

    BL_ERROR_JPEG_UNSUPPORTED_FEATURE,      /// Unsupported feature (JPEG).
    BL_ERROR_JPEG_INVALID_SOS,              /// Invalid SOS marker or header (JPEG).
    BL_ERROR_JPEG_INVALID_SOF,              /// Invalid SOF marker (JPEG).
    BL_ERROR_JPEG_MULTIPLE_SOF,             /// Multiple SOF markers (JPEG).
    BL_ERROR_JPEG_UNSUPPORTED_SOF,          /// Unsupported SOF marker (JPEG).

    BL_ERROR_FONT_NOT_INITIALIZED,          /// Font doesn't have any data as it's not initialized.
    BL_ERROR_FONT_NO_MATCH,                 /// Font or font face was not matched (BLFontManager).
    BL_ERROR_FONT_NO_CHARACTER_MAPPING,     /// Font has no character to glyph mapping data.
    BL_ERROR_FONT_MISSING_IMPORTANT_TABLE,  /// Font has missing an important table.
    BL_ERROR_FONT_FEATURE_NOT_AVAILABLE,    /// Font feature is not available.
    BL_ERROR_FONT_CFF_INVALID_DATA,         /// Font has an invalid CFF data.
    BL_ERROR_FONT_PROGRAM_TERMINATED,       /// Font program terminated because the execution reached the limit.
    BL_ERROR_GLYPH_SUBSTITUTION_TOO_LARGE,  /// Glyph substitution requires too much space and was terminated.

    BL_ERROR_INVALID_GLYPH                  /// Invalid glyph identifier.
}

/// \ingroup blend2d_api_globals
///
/// Byte order.
enum BLByteOrder : uint {

    /// Little endian byte-order.
    BL_BYTE_ORDER_LE = 0,
    
    /// Big endian byte-order.
    BL_BYTE_ORDER_BE = 1,
}

/// \ingroup blend2d_api_globals
///
/// Data access flags.
enum BLDataAccessFlags : uint {

    /// No data access flags.
    BL_DATA_ACCESS_NO_FLAGS = 0x00u,
    /// Read access.
    BL_DATA_ACCESS_READ = 0x01u,
    /// Write access.
    BL_DATA_ACCESS_WRITE = 0x02u,
    /// Read and write access.
    BL_DATA_ACCESS_RW = 0x03u
}

/// \ingroup blend2d_api_globals
///
/// Data source type.
enum BLDataSourceType : uint {

    /// No data source.
    BL_DATA_SOURCE_TYPE_NONE = 0,
    /// Memory data source.
    BL_DATA_SOURCE_TYPE_MEMORY = 1,
    /// File data source.
    BL_DATA_SOURCE_TYPE_FILE = 2,
    /// Custom data source.
    BL_DATA_SOURCE_TYPE_CUSTOM = 3,

    /// Maximum value `BLDataSourceType`.
    BL_DATA_SOURCE_TYPE_MAX_VALUE = 3
}

/// \ingroup blend2d_api_globals
///
/// Modification operation applied to Blend2D containers.
enum BLModifyOp : uint {

    /// Assign operation, which reserves space only to fit the requested input.
    BL_MODIFY_OP_ASSIGN_FIT = 0,
    /// Assign operation, which takes into consideration successive appends.
    BL_MODIFY_OP_ASSIGN_GROW = 1,
    /// Append operation, which reserves space only to fit the current and appended content.
    BL_MODIFY_OP_APPEND_FIT = 2,
    /// Append operation, which takes into consideration successive appends.
    BL_MODIFY_OP_APPEND_GROW = 3,

    /// Maximum value of `BLModifyOp`.
    BL_MODIFY_OP_MAX_VALUE = 3
}

/// \ingroup blend2d_api_globals
///
/// Boolean operator.
enum BLBooleanOp : uint {

    /// Result = B.
    BL_BOOLEAN_OP_COPY = 0,
    /// Result = A & B.
    BL_BOOLEAN_OP_AND = 1,
    /// Result = A | B.
    BL_BOOLEAN_OP_OR = 2,
    /// Result = A ^ B.
    BL_BOOLEAN_OP_XOR = 3,
    /// Result = A & ~B.
    BL_BOOLEAN_OP_AND_NOT = 4,
    /// Result = ~A & B.
    BL_BOOLEAN_OP_NOT_AND = 5,

    /// Maximum value of `BLBooleanOp`.
    BL_BOOLEAN_OP_MAX_VALUE = 5
}

/// \ingroup blend2d_api_styling
///
/// Extend mode.
enum BLExtendMode : uint {

    /// Pad extend [default].
    BL_EXTEND_MODE_PAD = 0,
    /// Repeat extend.
    BL_EXTEND_MODE_REPEAT = 1,
    /// Reflect extend.
    BL_EXTEND_MODE_REFLECT = 2,

    /// Alias to `BL_EXTEND_MODE_PAD`.
    BL_EXTEND_MODE_PAD_X_PAD_Y = 0,
    /// Pad X and repeat Y.
    BL_EXTEND_MODE_PAD_X_REPEAT_Y = 3,
    /// Pad X and reflect Y.
    BL_EXTEND_MODE_PAD_X_REFLECT_Y = 4,

    /// Alias to `BL_EXTEND_MODE_REPEAT`.
    BL_EXTEND_MODE_REPEAT_X_REPEAT_Y = 1,
    /// Repeat X and pad Y.
    BL_EXTEND_MODE_REPEAT_X_PAD_Y = 5,
    /// Repeat X and reflect Y.
    BL_EXTEND_MODE_REPEAT_X_REFLECT_Y = 6,

    /// Alias to `BL_EXTEND_MODE_REFLECT`.
    BL_EXTEND_MODE_REFLECT_X_REFLECT_Y = 2,
    /// Reflect X and pad Y.
    BL_EXTEND_MODE_REFLECT_X_PAD_Y = 7,
    /// Reflect X and repeat Y.
    BL_EXTEND_MODE_REFLECT_X_REPEAT_Y = 8,

    /// Count of simple extend modes (that use the same value for X and Y).
    BL_EXTEND_MODE_SIMPLE_MAX_VALUE = 2,
    /// Count of complex extend modes (that can use independent values for X and Y).
    BL_EXTEND_MODE_COMPLEX_MAX_VALUE = 8,

    /// Maximum value of `BLExtendMode`.
    BL_EXTEND_MODE_MAX_VALUE
}

/// \ingroup blend2d_api_text
///
/// Text encoding.
enum BLTextEncoding : uint {

    /// UTF-8 encoding.
    BL_TEXT_ENCODING_UTF8 = 0,
    /// UTF-16 encoding (native endian).
    BL_TEXT_ENCODING_UTF16 = 1,
    /// UTF-32 encoding (native endian).
    BL_TEXT_ENCODING_UTF32 = 2,
    /// LATIN1 encoding (one byte per character).
    BL_TEXT_ENCODING_LATIN1 = 3,

    /// Maximum value of `BLTextEncoding`.
    BL_TEXT_ENCODING_MAX_VALUE = 3
}

/// Object type identifier.
enum BLObjectType : uint {
  /// Object represents a RGBA value stored as four 32-bit floating point components (can be used as Style).
  BL_OBJECT_TYPE_RGBA = 0,
  /// Object represents a RGBA32 value stored as 32-bit integer in `0xAARRGGBB` form.
  BL_OBJECT_TYPE_RGBA32 = 1,
  /// Object represents a RGBA64 value stored as 64-bit integer in `0xAAAARRRRGGGGBBBB` form.
  BL_OBJECT_TYPE_RGBA64 = 2,
  /// Object is `Null` (can be used as style).
  BL_OBJECT_TYPE_NULL = 3,
  /// Object is `BLPattern` (can be used as style).
  BL_OBJECT_TYPE_PATTERN = 4,
  /// Object is `BLGradient` (can be used as style).
  BL_OBJECT_TYPE_GRADIENT = 5,

  /// Object is `BLImage`.
  BL_OBJECT_TYPE_IMAGE = 9,
  /// Object is `BLPath`.
  BL_OBJECT_TYPE_PATH = 10,

  /// Object is `BLFont`.
  BL_OBJECT_TYPE_FONT = 16,
  /// Object is `BLFontFeatureSettings`.
  BL_OBJECT_TYPE_FONT_FEATURE_SETTINGS = 17,
  /// Object is `BLFontVariationSettings`.
  BL_OBJECT_TYPE_FONT_VARIATION_SETTINGS = 18,

  /// Object is `BLBitArray`.
  BL_OBJECT_TYPE_BIT_ARRAY = 25,
  /// Object is `BLBitSet`.
  BL_OBJECT_TYPE_BIT_SET = 26,

  /// Object represents a boolean value.
  BL_OBJECT_TYPE_BOOL = 28,
  /// Object represents a 64-bit signed integer value.
  BL_OBJECT_TYPE_INT64 = 29,
  /// Object represents a 64-bit unsigned integer value.
  BL_OBJECT_TYPE_UINT64 = 30,
  /// Object represents a 64-bit floating point value.
  BL_OBJECT_TYPE_DOUBLE = 31,
  /// Object is `BLString`.
  BL_OBJECT_TYPE_STRING = 32,

  /// Object is `BLArray<T>` where `T` is a `BLObject` compatible type.
  BL_OBJECT_TYPE_ARRAY_OBJECT = 33,
  /// Object is `BLArray<T>` where `T` matches 8-bit signed integral type.
  BL_OBJECT_TYPE_ARRAY_INT8 = 34,
  /// Object is `BLArray<T>` where `T` matches 8-bit unsigned integral type.
  BL_OBJECT_TYPE_ARRAY_UINT8 = 35,
  /// Object is `BLArray<T>` where `T` matches 16-bit signed integral type.
  BL_OBJECT_TYPE_ARRAY_INT16 = 36,
  /// Object is `BLArray<T>` where `T` matches 16-bit unsigned integral type.
  BL_OBJECT_TYPE_ARRAY_UINT16 = 37,
  /// Object is `BLArray<T>` where `T` matches 32-bit signed integral type.
  BL_OBJECT_TYPE_ARRAY_INT32 = 38,
  /// Object is `BLArray<T>` where `T` matches 32-bit unsigned integral type.
  BL_OBJECT_TYPE_ARRAY_UINT32 = 39,
  /// Object is `BLArray<T>` where `T` matches 64-bit signed integral type.
  BL_OBJECT_TYPE_ARRAY_INT64 = 40,
  /// Object is `BLArray<T>` where `T` matches 64-bit unsigned integral type.
  BL_OBJECT_TYPE_ARRAY_UINT64 = 41,
  /// Object is `BLArray<T>` where `T` matches 32-bit floating point type.
  BL_OBJECT_TYPE_ARRAY_FLOAT32 = 42,
  /// Object is `BLArray<T>` where `T` matches 64-bit floating point type.
  BL_OBJECT_TYPE_ARRAY_FLOAT64 = 43,
  /// Object is `BLArray<T>` where `T` is a struct of size 1.
  BL_OBJECT_TYPE_ARRAY_STRUCT_1 = 44,
  /// Object is `BLArray<T>` where `T` is a struct of size 2.
  BL_OBJECT_TYPE_ARRAY_STRUCT_2 = 45,
  /// Object is `BLArray<T>` where `T` is a struct of size 3.
  BL_OBJECT_TYPE_ARRAY_STRUCT_3 = 46,
  /// Object is `BLArray<T>` where `T` is a struct of size 4.
  BL_OBJECT_TYPE_ARRAY_STRUCT_4 = 47,
  /// Object is `BLArray<T>` where `T` is a struct of size 6.
  BL_OBJECT_TYPE_ARRAY_STRUCT_6 = 48,
  /// Object is `BLArray<T>` where `T` is a struct of size 8.
  BL_OBJECT_TYPE_ARRAY_STRUCT_8 = 49,
  /// Object is `BLArray<T>` where `T` is a struct of size 10.
  BL_OBJECT_TYPE_ARRAY_STRUCT_10 = 50,
  /// Object is `BLArray<T>` where `T` is a struct of size 12.
  BL_OBJECT_TYPE_ARRAY_STRUCT_12 = 51,
  /// Object is `BLArray<T>` where `T` is a struct of size 16.
  BL_OBJECT_TYPE_ARRAY_STRUCT_16 = 52,
  /// Object is `BLArray<T>` where `T` is a struct of size 20.
  BL_OBJECT_TYPE_ARRAY_STRUCT_20 = 53,
  /// Object is `BLArray<T>` where `T` is a struct of size 24.
  BL_OBJECT_TYPE_ARRAY_STRUCT_24 = 54,
  /// Object is `BLArray<T>` where `T` is a struct of size 32.
  BL_OBJECT_TYPE_ARRAY_STRUCT_32 = 55,

  /// Object is `BLContext`.
  BL_OBJECT_TYPE_CONTEXT = 100,

  /// Object is `BLImageCodec`.
  BL_OBJECT_TYPE_IMAGE_CODEC = 101,
  /// Object is `BLImageDecoder`.
  BL_OBJECT_TYPE_IMAGE_DECODER = 102,
  /// Object is `BLImageEncoder`.
  BL_OBJECT_TYPE_IMAGE_ENCODER = 103,

  /// Object is `BLFontFace`.
  BL_OBJECT_TYPE_FONT_FACE = 104,
  /// Object is `BLFontData`.
  BL_OBJECT_TYPE_FONT_DATA = 105,
  /// Object is `BLFontManager`.
  BL_OBJECT_TYPE_FONT_MANAGER = 106,

  /// Minimum object type of an array object.
  BL_OBJECT_TYPE_MIN_ARRAY = 33,
  /// Maximum object type of an array object.
  BL_OBJECT_TYPE_MAX_ARRAY = 55,

  /// Minimum object type identifier that can be used as a style.
  BL_OBJECT_TYPE_MIN_STYLE = 0,
  /// Maximum object type identifier that can be used as a style.
  BL_OBJECT_TYPE_MAX_STYLE = 5,

  /// Minimum object type of an object with virtual function table.
  BL_OBJECT_TYPE_MIN_VIRTUAL = 100,
  /// Maximum object type of an object with virtual function table.
  BL_OBJECT_TYPE_MAX_VIRTUAL = 127,

  /// Maximum possible value of an object type, including identifiers reserved for the future.
  BL_OBJECT_TYPE_MAX_VALUE = 127
}

//! File read flags used by `BLFileSystem::readFile()`.
enum BLFileReadFlags : uint {
    
    //! No flags.
    BL_FILE_READ_NO_FLAGS = 0u,

    //! Use memory mapping to read the content of the file.
    //!
    //! The destination buffer `BLArray<>` would be configured to use the memory mapped buffer instead of allocating its
    //! own.
    BL_FILE_READ_MMAP_ENABLED = 0x00000001u,

    //! Avoid memory mapping of small files.
    //!
    //! The size of small file is determined by Blend2D, however, you should expect it to be 16kB or 64kB depending on
    //! host operating system.
    BL_FILE_READ_MMAP_AVOID_SMALL = 0x00000002u,

    //! Do not fallback to regular read if memory mapping fails. It's worth noting that memory mapping would fail for
    //! files stored on filesystem that is not local (like a mounted network filesystem, etc...).
    BL_FILE_READ_MMAP_NO_FALLBACK = 0x00000008u

}

/// \ingroup blend2d_api_globals
///
/// Tag is a 32-bit integer consisting of 4 characters in the following format:
///
/// ```
/// tag = ((a << 24) | (b << 16) | (c << 8) | d)
/// ```
///
/// Tags are used extensively by OpenType fonts and other binary formats like PNG. In most cases TAGs should only
/// contain ASCII letters, digits, and spaces.
///
/// Blend2D uses `BLTag` in public and internal APIs to distinguish between a regular `uint` and tag.
alias BLTag = uint;

/// \ingroup blend2d_api_globals
///
/// Unique identifier that can be used for caching purposes.
///
/// Some objects such as \ref BLImage and \ref BLFontFace have assigned an unique identifier that can be used to
/// identify such objects for caching purposes. This identifier is never zero, so zero can be safely used as
/// "uncached".
///
/// \note Unique identifier is per-process. It's implemented as an increasing global or thread-local counter in
/// a way that identifiers would not collide.
alias BLUniqueId = ulong;

/// \ingroup blend2d_api_globals
///
/// BLUnknown is `void` - it's used in places that accept pointer to `BLVarCore` or any `BLObjectCore` compatible
/// object.
alias BLUnknown = void;

/// Byte string [C API].
struct BLStringCore;

/// Variant [C API].
struct BLVarCore;


/// 32-bit RGBA color (8-bit per component) stored as `0xAARRGGBB`.
struct BLRgba32 {

    /// Packed 32-bit RGBA value.
    uint value;
}

/// 64-bit RGBA color (16-bit per component) stored as `0xAAAARRRRGGGGBBBB`.
struct BLRgba64 {

    /// Packed 64-bit RGBA value.
    ulong value;
}

/// 128-bit RGBA color stored as 4 32-bit floating point values in [RGBA] order.
struct BLRgba {

    /// Red component.
    float r;
    /// Green component.
    float g;
    /// Blur component.
    float b;
    /// Alpha component.
    float a;
}

struct BLRange {
  size_t start;
  size_t end;
}

alias BLDestroyExternalDataFunc = extern(C) void function(void* impl, void* externalData, void* userData) nothrow @nogc;

//! Blend2D runtime limits.
//!
//! \note These constants are used across Blend2D, but they are not designed to be ABI stable. New versions of Blend2D
//! can increase certain limits without notice. Use runtime to query the limits dynamically, see `BLRuntimeBuildInfo`.
enum BLRuntimeLimits {
  //! Maximum width and height of an image.
  BL_RUNTIME_MAX_IMAGE_SIZE = 65535,
  //! Maximum number of threads for asynchronous operations (including rendering).
  BL_RUNTIME_MAX_THREAD_COUNT = 32
}

//! Type of runtime information that can be queried through \ref blRuntimeQueryInfo().
enum BLRuntimeInfoType : uint {
  //! Blend2D build information.
  BL_RUNTIME_INFO_TYPE_BUILD = 0,
  //! System information (includes CPU architecture, features, core count, etc...).
  BL_RUNTIME_INFO_TYPE_SYSTEM = 1,
  //! Resources information (includes Blend2D memory consumption)
  BL_RUNTIME_INFO_TYPE_RESOURCE = 2,

  //! Count of runtime information types.
  BL_RUNTIME_INFO_TYPE_MAX_VALUE = 2
}

//! Blend2D runtime build type.
enum BLRuntimeBuildType : uint {
  //! Describes a Blend2D debug build.
  BL_RUNTIME_BUILD_TYPE_DEBUG = 0,
  //! Describes a Blend2D release build.
  BL_RUNTIME_BUILD_TYPE_RELEASE = 1
}

//! CPU architecture that can be queried by `BLRuntime::querySystemInfo()`.
enum BLRuntimeCpuArch : uint {
  //! Unknown architecture.
  BL_RUNTIME_CPU_ARCH_UNKNOWN = 0,
  //! 32-bit or 64-bit X86 architecture.
  BL_RUNTIME_CPU_ARCH_X86 = 1,
  //! 32-bit or 64-bit ARM architecture.
  BL_RUNTIME_CPU_ARCH_ARM = 2,
  //! 32-bit or 64-bit MIPS architecture.
  BL_RUNTIME_CPU_ARCH_MIPS = 3

}

//! CPU features Blend2D supports.
enum BLRuntimeCpuFeatures : uint {
  BL_RUNTIME_CPU_FEATURE_X86_SSE2 = 0x00000001u,
  BL_RUNTIME_CPU_FEATURE_X86_SSE3 = 0x00000002u,
  BL_RUNTIME_CPU_FEATURE_X86_SSSE3 = 0x00000004u,
  BL_RUNTIME_CPU_FEATURE_X86_SSE4_1 = 0x00000008u,
  BL_RUNTIME_CPU_FEATURE_X86_SSE4_2 = 0x00000010u,
  BL_RUNTIME_CPU_FEATURE_X86_AVX = 0x00000020u,
  BL_RUNTIME_CPU_FEATURE_X86_AVX2 = 0x00000040u,
  BL_RUNTIME_CPU_FEATURE_X86_AVX512 = 0x00000080u
}

//! Runtime cleanup flags that can be used through `BLRuntime::cleanup()`.
enum BLRuntimeCleanupFlags : uint {
  //! No flags.
  BL_RUNTIME_CLEANUP_NO_FLAGS = 0u,
  //! Cleanup object memory pool.
  BL_RUNTIME_CLEANUP_OBJECT_POOL = 0x00000001u,
  //! Cleanup zeroed memory pool.
  BL_RUNTIME_CLEANUP_ZEROED_POOL = 0x00000002u,
  //! Cleanup thread pool (would join unused threads).
  BL_RUNTIME_CLEANUP_THREAD_POOL = 0x00000010u,

  //! Cleanup everything.
  BL_RUNTIME_CLEANUP_EVERYTHING = 0xFFFFFFFFu
}

//! \}

//! \name Runtime - Structs
//! \{

//! Blend2D build information.
struct BLRuntimeBuildInfo {
    //! Major version number.
    uint majorVersion;
    //! Minor version number.
    uint minorVersion;
    //! Patch version number.
    uint patchVersion;

    //! Blend2D build type, see `BLRuntimeBuildType`.
    uint buildType;

    //! Baseline CPU features, see `BLRuntimeCpuFeatures`.
    //!
    //! These features describe CPU features that were detected at compile-time. Baseline features are used to compile
    //! all source files so they represent the minimum feature-set the target CPU must support to run Blend2D.
    //!
    //! Official Blend2D builds set baseline at SSE2 on X86 target and NEON on ARM target. Custom builds can set use
    //! a different baseline, which can be read through `BLRuntimeBuildInfo`.
    uint baselineCpuFeatures;

    //! Supported CPU features, see `BLRuntimeCpuFeatures`.
    //!
    //! These features do not represent the features that the host CPU must support, instead, they represent all features
    //! that Blend2D can take advantage of in C++ code that uses instruction intrinsics. For example if AVX2 is part of
    //! `supportedCpuFeatures` it means that Blend2D can take advantage of it if there is a specialized code-path.
    uint supportedCpuFeatures;

    //! Maximum size of an image (both width and height).
    uint maxImageSize;

    //! Maximum number of threads for asynchronous operations, including rendering.
    uint maxThreadCount;

    //! Reserved, must be zero.
    uint[2] reserved;

    //! Identification of the C++ compiler used to build Blend2D.
    char[32] compilerInfo;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
};

//! System information queried by the runtime.
struct BLRuntimeSystemInfo {
    //! Host CPU architecture, see `BLRuntimeCpuArch`.
    uint cpuArch;
    //! Host CPU features, see `BLRuntimeCpuFeatures`.
    uint cpuFeatures;
    //! Number of cores of the host CPU/CPUs.
    uint coreCount;
    //! Number of threads of the host CPU/CPUs.
    uint threadCount;
    //! Minimum stack size of a worker thread used by Blend2D.
    uint threadStackSize;
    //! Removed field.
    uint removed;
    //! Allocation granularity of virtual memory (includes thread's stack).
    uint allocationGranularity;
    //! Reserved for future use.
    uint[5] reserved;
    //! Host CPU vendor string such "AMD", "APPLE", "INTEL", "SAMSUNG", etc...
    char[16] cpuVendor;
    //! Host CPU brand string or empty string if not detected properly.
    char[64] cpuBrand;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
};

//! Provides information about resources allocated by Blend2D.
struct BLRuntimeResourceInfo {
    //! Virtual memory used at this time.
    size_t vmUsed;
    //! Virtual memory reserved (allocated internally).
    size_t vmReserved;
    //! Overhead required to manage virtual memory allocations.
    size_t vmOverhead;
    //! Number of blocks of virtual memory allocated.
    size_t vmBlockCount;

    //! Zeroed memory used at this time.
    size_t zmUsed;
    //! Zeroed memory reserved (allocated internally).
    size_t zmReserved;
    //! Overhead required to manage zeroed memory allocations.
    size_t zmOverhead;
    //! Number of blocks of zeroed memory allocated.
    size_t zmBlockCount;

    //! Count of dynamic pipelines created and cached.
    size_t dynamicPipelineCount;

    //! Reserved for future use.
    size_t[7] reserved;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}

version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blStringInit(BLStringCore* self);
    BLResult blStringInitMove(BLStringCore* self, BLStringCore* other);
    BLResult blStringInitWeak(BLStringCore* self, const(BLStringCore)* other);
    BLResult blStringInitWithData(BLStringCore* self, const(char)* str, size_t size);
    BLResult blStringDestroy(BLStringCore* self);
    BLResult blStringReset(BLStringCore* self);
    const(char)* blStringGetData(const(BLStringCore)* self) pure;
    size_t blStringGetSize(const(BLStringCore)* self) pure;
    size_t blStringGetCapacity(const(BLStringCore)* self) pure;
    BLResult blStringClear(BLStringCore* self);
    BLResult blStringShrink(BLStringCore* self);
    BLResult blStringReserve(BLStringCore* self, size_t n);
    BLResult blStringResize(BLStringCore* self, size_t n, char fill);
    BLResult blStringMakeMutable(BLStringCore* self, char** dataOut);
    BLResult blStringModifyOp(BLStringCore* self, BLModifyOp op, size_t n, char** dataOut);
    BLResult blStringInsertOp(BLStringCore* self, size_t index, size_t n, char** dataOut);
    BLResult blStringAssignMove(BLStringCore* self, BLStringCore* other);
    BLResult blStringAssignWeak(BLStringCore* self, const(BLStringCore)* other);
    BLResult blStringAssignDeep(BLStringCore* self, const(BLStringCore)* other);
    BLResult blStringAssignData(BLStringCore* self, const(char)* str, size_t n);
    BLResult blStringApplyOpChar(BLStringCore* self, BLModifyOp op, char c, size_t n);
    BLResult blStringApplyOpData(BLStringCore* self, BLModifyOp op, const(char)* str, size_t n);
    BLResult blStringApplyOpString(BLStringCore* self, BLModifyOp op, const(BLStringCore)* other);
    BLResult blStringApplyOpFormat(BLStringCore* self, BLModifyOp op, const(char)* fmt, ...);
    BLResult blStringApplyOpFormatV(BLStringCore* self, BLModifyOp op, const(char)* fmt, va_list ap);
    BLResult blStringInsertChar(BLStringCore* self, size_t index, char c, size_t n);
    BLResult blStringInsertData(BLStringCore* self, size_t index, const(char)* str, size_t n);
    BLResult blStringInsertString(BLStringCore* self, size_t index, const(BLStringCore)* other);
    BLResult blStringRemoveIndex(BLStringCore* self, size_t index);
    BLResult blStringRemoveRange(BLStringCore* self, size_t rStart, size_t rEnd);
    bool blStringEquals(const(BLStringCore)* a, const(BLStringCore)* b) pure;
    bool blStringEqualsData(const(BLStringCore)* self, const(char)* str, size_t n) pure;
    int blStringCompare(const(BLStringCore)* a, const(BLStringCore)* b) pure;
    int blStringCompareData(const(BLStringCore)* self, const(char)* str, size_t n) pure;

    BLResult blVarInitType(BLUnknown* self, BLObjectType type);
    BLResult blVarInitNull(BLUnknown* self);
    BLResult blVarInitBool(BLUnknown* self, bool value);
    BLResult blVarInitInt32(BLUnknown* self, int value);
    BLResult blVarInitInt64(BLUnknown* self, long value);
    BLResult blVarInitUInt32(BLUnknown* self, uint value);
    BLResult blVarInitUInt64(BLUnknown* self, ulong value);
    BLResult blVarInitDouble(BLUnknown* self, double value);
    BLResult blVarInitRgba(BLUnknown* self, const(BLRgba)* rgba);
    BLResult blVarInitRgba32(BLUnknown* self, uint rgba32);
    BLResult blVarInitRgba64(BLUnknown* self, ulong rgba64);
    BLResult blVarInitMove(BLUnknown* self, BLUnknown* other);
    BLResult blVarInitWeak(BLUnknown* self, const(BLUnknown)* other);
    BLResult blVarDestroy(BLUnknown* self);
    BLResult blVarReset(BLUnknown* self);

    BLResult blVarAssignNull(BLUnknown* self);
    BLResult blVarAssignBool(BLUnknown* self, bool value);
    BLResult blVarAssignInt32(BLUnknown* self, int value);
    BLResult blVarAssignInt64(BLUnknown* self, long value);
    BLResult blVarAssignUInt32(BLUnknown* self, uint value);
    BLResult blVarAssignUInt64(BLUnknown* self, ulong value);
    BLResult blVarAssignDouble(BLUnknown* self, double value);
    BLResult blVarAssignRgba(BLUnknown* self, const(BLRgba)* rgba);
    BLResult blVarAssignRgba32(BLUnknown* self, uint rgba32);
    BLResult blVarAssignRgba64(BLUnknown* self, ulong rgba64);
    BLResult blVarAssignMove(BLUnknown* self, BLUnknown* other);
    BLResult blVarAssignWeak(BLUnknown* self, const(BLUnknown)* other);

    BLObjectType blVarGetType(const(BLUnknown)* self) pure;

    BLResult blVarToBool(const(BLUnknown)* self, bool* out_);
    BLResult blVarToInt32(const(BLUnknown)* self, int* out_);
    BLResult blVarToInt64(const(BLUnknown)* self, long* out_);
    BLResult blVarToUInt32(const(BLUnknown)* self, uint* out_);
    BLResult blVarToUInt64(const(BLUnknown)* self, ulong* out_);
    BLResult blVarToDouble(const(BLUnknown)* self, double* out_);
    BLResult blVarToRgba(const(BLUnknown)* self, BLRgba* out_);
    BLResult blVarToRgba32(const(BLUnknown)* self, uint* out_);
    BLResult blVarToRgba64(const(BLUnknown)* self, ulong* out_);

    bool blVarEquals(const(BLUnknown)* a, const(BLUnknown)* b) pure;
    bool blVarEqualsNull(const(BLUnknown)* self) pure;
    bool blVarEqualsBool(const(BLUnknown)* self, bool value) pure;
    bool blVarEqualsInt64(const(BLUnknown)* self, long value) pure;
    bool blVarEqualsUInt64(const(BLUnknown)* self, ulong value) pure;
    bool blVarEqualsDouble(const(BLUnknown)* self, double value) pure;
    bool blVarEqualsRgba(const(BLUnknown)* self, const(BLRgba)* rgba) pure;
    bool blVarEqualsRgba32(const(BLUnknown)* self, uint rgba32) pure;
    bool blVarEqualsRgba64(const(BLUnknown)* self, ulong rgba64) pure;

    bool blVarStrictEquals(const(BLUnknown)* a, const(BLUnknown)* b) pure;

    BLResult blRuntimeInit();
    BLResult blRuntimeShutdown();
    BLResult blRuntimeCleanup(BLRuntimeCleanupFlags cleanupFlags);
    BLResult blRuntimeQueryInfo(BLRuntimeInfoType infoType, void* infoOut);
    BLResult blRuntimeMessageOut(const char* msg);
    BLResult blRuntimeMessageFmt(const char* fmt, ...);
    BLResult blRuntimeMessageVFmt(const char* fmt, va_list ap);


} else {
nothrow @nogc extern(C):

    BLResult function(BLStringCore* self) blStringInit;
    BLResult function(BLStringCore* self, BLStringCore* other) blStringInitMove;
    BLResult function(BLStringCore* self, const(BLStringCore)* other) blStringInitWeak;
    BLResult function(BLStringCore* self, const(char)* str, size_t size) blStringInitWithData;
    BLResult function(BLStringCore* self) blStringDestroy;
    BLResult function(BLStringCore* self) blStringReset;
    const(char)* function(const(BLStringCore)* self) pure blStringGetData;
    size_t function(const(BLStringCore)* self) pure blStringGetSize;
    size_t function(const(BLStringCore)* self) pure blStringGetCapacity;
    BLResult function(BLStringCore* self) blStringClear;
    BLResult function(BLStringCore* self) blStringShrink;
    BLResult function(BLStringCore* self, size_t n) blStringReserve;
    BLResult function(BLStringCore* self, size_t n, char fill) blStringResize;
    BLResult function(BLStringCore* self, char** dataOut) blStringMakeMutable;
    BLResult function(BLStringCore* self, BLModifyOp op, size_t n, char** dataOut) blStringModifyOp;
    BLResult function(BLStringCore* self, size_t index, size_t n, char** dataOut) blStringInsertOp;
    BLResult function(BLStringCore* self, BLStringCore* other) blStringAssignMove;
    BLResult function(BLStringCore* self, const(BLStringCore)* other) blStringAssignWeak;
    BLResult function(BLStringCore* self, const(BLStringCore)* other) blStringAssignDeep;
    BLResult function(BLStringCore* self, const(char)* str, size_t n) blStringAssignData;
    BLResult function(BLStringCore* self, BLModifyOp op, char c, size_t n) blStringApplyOpChar;
    BLResult function(BLStringCore* self, BLModifyOp op, const(char)* str, size_t n) blStringApplyOpData;
    BLResult function(BLStringCore* self, BLModifyOp op, const(BLStringCore)* other) blStringApplyOpString;
    BLResult function(BLStringCore* self, BLModifyOp op, const(char)* fmt, ...) blStringApplyOpFormat;
    BLResult function(BLStringCore* self, BLModifyOp op, const(char)* fmt, va_list ap) blStringApplyOpFormatV;
    BLResult function(BLStringCore* self, size_t index, char c, size_t n) blStringInsertChar;
    BLResult function(BLStringCore* self, size_t index, const(char)* str, size_t n) blStringInsertData;
    BLResult function(BLStringCore* self, size_t index, const(BLStringCore)* other) blStringInsertString;
    BLResult function(BLStringCore* self, size_t index) blStringRemoveIndex;
    BLResult function(BLStringCore* self, size_t rStart, size_t rEnd) blStringRemoveRange;
    bool function(const(BLStringCore)* a, const(BLStringCore)* b) pure blStringEquals;
    bool function(const(BLStringCore)* self, const(char)* str, size_t n) pure blStringEqualsData;
    int function(const(BLStringCore)* a, const(BLStringCore)* b) pure blStringCompare;
    int function(const(BLStringCore)* self, const(char)* str, size_t n) pure blStringCompareData;
    BLResult function(BLUnknown* self, BLObjectType type) blVarInitType;
    BLResult function(BLUnknown* self) blVarInitNull;
    BLResult function(BLUnknown* self, bool value) blVarInitBool;
    BLResult function(BLUnknown* self, int value) blVarInitInt32;
    BLResult function(BLUnknown* self, long value) blVarInitInt64;
    BLResult function(BLUnknown* self, uint value) blVarInitUInt32;
    BLResult function(BLUnknown* self, ulong value) blVarInitUInt64;
    BLResult function(BLUnknown* self, double value) blVarInitDouble;
    BLResult function(BLUnknown* self, const(BLRgba)* rgba) blVarInitRgba;
    BLResult function(BLUnknown* self, uint rgba32) blVarInitRgba32;
    BLResult function(BLUnknown* self, ulong rgba64) blVarInitRgba64;
    BLResult function(BLUnknown* self, BLUnknown* other) blVarInitMove;
    BLResult function(BLUnknown* self, const(BLUnknown)* other) blVarInitWeak;
    BLResult function(BLUnknown* self) blVarDestroy;
    BLResult function(BLUnknown* self) blVarReset;
    BLResult function(BLUnknown* self) blVarAssignNull;
    BLResult function(BLUnknown* self, bool value) blVarAssignBool;
    BLResult function(BLUnknown* self, int value) blVarAssignInt32;
    BLResult function(BLUnknown* self, long value) blVarAssignInt64;
    BLResult function(BLUnknown* self, uint value) blVarAssignUInt32;
    BLResult function(BLUnknown* self, ulong value) blVarAssignUInt64;
    BLResult function(BLUnknown* self, double value) blVarAssignDouble;
    BLResult function(BLUnknown* self, const(BLRgba)* rgba) blVarAssignRgba;
    BLResult function(BLUnknown* self, uint rgba32) blVarAssignRgba32;
    BLResult function(BLUnknown* self, ulong rgba64) blVarAssignRgba64;
    BLResult function(BLUnknown* self, BLUnknown* other) blVarAssignMove;
    BLResult function(BLUnknown* self, const(BLUnknown)* other) blVarAssignWeak;
    BLObjectType function(const(BLUnknown)* self) pure blVarGetType;
    BLResult function(const(BLUnknown)* self, bool* out_) blVarToBool;
    BLResult function(const(BLUnknown)* self, int* out_) blVarToInt32;
    BLResult function(const(BLUnknown)* self, long* out_) blVarToInt64;
    BLResult function(const(BLUnknown)* self, uint* out_) blVarToUInt32;
    BLResult function(const(BLUnknown)* self, ulong* out_) blVarToUInt64;
    BLResult function(const(BLUnknown)* self, double* out_) blVarToDouble;
    BLResult function(const(BLUnknown)* self, BLRgba* out_) blVarToRgba;
    BLResult function(const(BLUnknown)* self, uint* out_) blVarToRgba32;
    BLResult function(const(BLUnknown)* self, ulong* out_) blVarToRgba64;
    bool function(const(BLUnknown)* a, const(BLUnknown)* b) pure blVarEquals;
    bool function(const(BLUnknown)* self) pure blVarEqualsNull;
    bool function(const(BLUnknown)* self, bool value) pure blVarEqualsBool;
    bool function(const(BLUnknown)* self, long value) pure blVarEqualsInt64;
    bool function(const(BLUnknown)* self, ulong value) pure blVarEqualsUInt64;
    bool function(const(BLUnknown)* self, double value) pure blVarEqualsDouble;
    bool function(const(BLUnknown)* self, const(BLRgba)* rgba) pure blVarEqualsRgba;
    bool function(const(BLUnknown)* self, uint rgba32) pure blVarEqualsRgba32;
    bool function(const(BLUnknown)* self, ulong rgba64) pure blVarEqualsRgba64;
    bool function(const(BLUnknown)* a, const(BLUnknown)* b) pure blVarStrictEquals;

    BLResult function() blRuntimeInit;
    BLResult function() blRuntimeShutdown;
    BLResult function(BLRuntimeCleanupFlags cleanupFlags) blRuntimeCleanup;
    BLResult function(BLRuntimeInfoType infoType, void* infoOut) blRuntimeQueryInfo;
    BLResult function(const char* msg) blRuntimeMessageOut;
    BLResult function(const char* fmt, ...) blRuntimeMessageFmt;
    BLResult function(const char* fmt, va_list ap) blRuntimeMessageVFmt;
}