module blend2d.blend2d.glyphs;
import blend2d.blend2d.font;
import blend2d.blend2d.api;

/// Flags used by \ref BLGlyphRun.
enum BLGlyphRunFlags : uint {

    /// No flags.
    BL_GLYPH_RUN_NO_FLAGS = 0u,
    /// Glyph-run contains UCS-4 string and not glyphs (glyph-buffer only).
    BL_GLYPH_RUN_FLAG_UCS4_CONTENT = 0x10000000u,
    /// Glyph-run was created from text that was not a valid unicode.
    BL_GLYPH_RUN_FLAG_INVALID_TEXT = 0x20000000u,
    /// Not the whole text was mapped to glyphs (contains undefined glyphs).
    BL_GLYPH_RUN_FLAG_UNDEFINED_GLYPHS = 0x40000000u,
    /// Encountered invalid font data during text / glyph processing.
    BL_GLYPH_RUN_FLAG_INVALID_FONT_DATA = 0x80000000u
}

enum BLGlyphPlacementType : uint {
    /// No placement (custom handling by \ref BLPathSinkFunc).
    BL_GLYPH_PLACEMENT_TYPE_NONE = 0,
    /// Each glyph has a BLGlyphPlacement (advance + offset).
    BL_GLYPH_PLACEMENT_TYPE_ADVANCE_OFFSET = 1,
    /// Each glyph has a BLPoint offset in design-space units.
    BL_GLYPH_PLACEMENT_TYPE_DESIGN_UNITS = 2,
    /// Each glyph has a BLPoint offset in user-space units.
    BL_GLYPH_PLACEMENT_TYPE_USER_UNITS = 3,
    /// Each glyph has a BLPoint offset in absolute units.
    BL_GLYPH_PLACEMENT_TYPE_ABSOLUTE_UNITS = 4,


}


/// BLGlyphRun describes a set of consecutive glyphs and their placements.
///
/// BLGlyphRun should only be used to pass glyph IDs and their placements to the rendering context. The purpose of
/// BLGlyphRun is to allow rendering glyphs, which could be shaped by various shaping engines (Blend2D, Harfbuzz, etc).
///
/// BLGlyphRun allows to render glyphs that are stored as uint[] array or part of a bigger structure (for example
/// `hb_glyph_info_t` used by HarfBuzz). Glyph placements at the moment use Blend2D's \ref BLGlyphPlacement or \ref
/// BLPoint, but it's possible to extend the data type in the future.
///
/// See `BLGlyphRunPlacement` for placement modes provided by Blend2D.
struct BLGlyphRun {

    /// Glyph id data (abstract, incremented by `glyphAdvance`).
    void* glyphData;
    /// Glyph placement data (abstract, incremented by `placementAdvance`).
    void* placementData;
    /// Size of the glyph-run in glyph units.
    size_t size;
    /// Reserved for future use, muse be zero.
    ubyte reserved;
    /// Type of placement, see \ref BLGlyphPlacementType.
    ubyte placementType;
    /// Advance of `glyphData` array.
    byte glyphAdvance;
    /// Advance of `placementData` array.
    byte placementAdvance;
    /// Glyph-run flags.
    uint flags;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }

    pragma(inline, true)
    bool empty() const nothrow { return size == 0; }

    pragma(inline, true)
    T* glyphDataAs(T)() const nothrow { return cast(T*)glyphData; }

    pragma(inline, true)
    T* placementDataAs(T)() const nothrow { return cast(T*)(placementData); }

    pragma(inline, true)
    void setGlyphData(const uint* glyphData) nothrow { setGlyphData(glyphData, cast(ptrdiff_t)uint.sizeof); }

    pragma(inline, true)
    void setGlyphData(const(void)* data, ptrdiff_t advance) nothrow {
        this.glyphData = cast(void*)data;
        this.glyphAdvance = cast(byte)advance;
    }

    pragma(inline, true)
    void resetGlyphIdData() nothrow {
        this.glyphData = null;
        this.glyphAdvance = 0;
    }

    pragma(inline, true)
    void setPlacementData(T)(const(T)* data) nothrow {
        setPlacementData(data, T.sizeof);
    }

    pragma(inline, true)
    void setPlacementData(const(void)* data, ptrdiff_t advance) nothrow {
        this.placementData = cast(void*)(data);
        this.placementAdvance = cast(byte)advance;
    }

    pragma(inline, true)
    void resetPlacementData() nothrow {
        this.placementData = null;
        this.placementAdvance = 0;
    }

}

struct BLGlyphBuffer {
    mixin BLExtends!BLObject;
}

version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blGlyphBufferInit(BLGlyphBuffer* self);
    BLResult blGlyphBufferInitMove(BLGlyphBuffer* self, BLGlyphBuffer* other);
    BLResult blGlyphBufferDestroy(BLGlyphBuffer* self);
    BLResult blGlyphBufferReset(BLGlyphBuffer* self);
    BLResult blGlyphBufferClear(BLGlyphBuffer* self);
    size_t blGlyphBufferGetSize(const(BLGlyphBuffer)* self) pure;
    uint blGlyphBufferGetFlags(const(BLGlyphBuffer)* self) pure;
    const(BLGlyphRun)* blGlyphBufferGetGlyphRun(const(BLGlyphBuffer)* self) pure;
    const(uint)* blGlyphBufferGetContent(const(BLGlyphBuffer)* self) pure;
    const(BLGlyphInfo)* blGlyphBufferGetInfoData(const(BLGlyphBuffer)* self) pure;
    const(BLGlyphPlacement)* blGlyphBufferGetPlacementData(const(BLGlyphBuffer)* self) pure;
    BLResult blGlyphBufferSetText(BLGlyphBuffer* self, const(void)* textData, size_t size, BLTextEncoding encoding);
    BLResult blGlyphBufferSetGlyphs(BLGlyphBuffer* self, const(uint)* glyphData, size_t size);
    BLResult blGlyphBufferSetGlyphsFromStruct(BLGlyphBuffer* self, const(void)* glyphData, size_t size, size_t glyphIdSize, ptrdiff_t glyphIdAdvance);
} else {
nothrow @nogc extern(C):

    BLResult function(BLGlyphBuffer* self) blGlyphBufferInit;
    BLResult function(BLGlyphBuffer* self, BLGlyphBuffer* other) blGlyphBufferInitMove;
    BLResult function(BLGlyphBuffer* self) blGlyphBufferDestroy;
    BLResult function(BLGlyphBuffer* self) blGlyphBufferReset;
    BLResult function(BLGlyphBuffer* self) blGlyphBufferClear;
    size_t function(const(BLGlyphBuffer)* self) pure blGlyphBufferGetSize;
    uint function(const(BLGlyphBuffer)* self) pure blGlyphBufferGetFlags;
    const(BLGlyphRun)* function(const(BLGlyphBuffer)* self) pure blGlyphBufferGetGlyphRun;
    const(uint)* function(const(BLGlyphBuffer)* self) pure blGlyphBufferGetContent;
    const(BLGlyphInfo)* function(const(BLGlyphBuffer)* self) pure blGlyphBufferGetInfoData;
    const(BLGlyphPlacement)* function(const(BLGlyphBuffer)* self) pure blGlyphBufferGetPlacementData;
    BLResult function(BLGlyphBuffer* self, const(void)* textData, size_t size, BLTextEncoding encoding) blGlyphBufferSetText;
    BLResult function(BLGlyphBuffer* self, const(uint)* glyphData, size_t size) blGlyphBufferSetGlyphs;
    BLResult function(BLGlyphBuffer* self, const(void)* glyphData, size_t size, size_t glyphIdSize, ptrdiff_t glyphIdAdvance) blGlyphBufferSetGlyphsFromStruct;
}