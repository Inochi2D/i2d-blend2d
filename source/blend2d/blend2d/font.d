module blend2d.blend2d.font;
import blend2d.blend2d.api;
import blend2d.blend2d.geometry;
import blend2d.blend2d.glyphs;
import blend2d.blend2d.array;

/// Orientation.
enum BLOrientation : uint {

    /// Horizontal orientation.
    BL_ORIENTATION_HORIZONTAL = 0,
    /// Vertical orientation.
    BL_ORIENTATION_VERTICAL = 1,


}

/// Type of a font or font face, see \ref BLFontFace (or \ref BLFontFaceCore).
enum BLFontFaceType : uint {

    /// None or unknown font type.
    BL_FONT_FACE_TYPE_NONE = 0,
    /// TrueType/OpenType font type (.ttf/.otf files and font collections).
    BL_FONT_FACE_TYPE_OPENTYPE = 1,


}

/// Font stretch.
enum BLFontStretch : uint {

    /// Ultra condensed stretch.
    BL_FONT_STRETCH_ULTRA_CONDENSED = 1,
    /// Extra condensed stretch.
    BL_FONT_STRETCH_EXTRA_CONDENSED = 2,
    /// Condensed stretch.
    BL_FONT_STRETCH_CONDENSED = 3,
    /// Semi condensed stretch.
    BL_FONT_STRETCH_SEMI_CONDENSED = 4,
    /// Normal stretch.
    BL_FONT_STRETCH_NORMAL = 5,
    /// Semi expanded stretch.
    BL_FONT_STRETCH_SEMI_EXPANDED = 6,
    /// Expanded stretch.
    BL_FONT_STRETCH_EXPANDED = 7,
    /// Extra expanded stretch.
    BL_FONT_STRETCH_EXTRA_EXPANDED = 8,
    /// Ultra expanded stretch.
    BL_FONT_STRETCH_ULTRA_EXPANDED = 9,


}

/// Font style.
enum BLFontStyle : uint {

    /// Normal style.
    BL_FONT_STYLE_NORMAL = 0,
    /// Oblique.
    BL_FONT_STYLE_OBLIQUE = 1,
    /// Italic.
    BL_FONT_STYLE_ITALIC = 2,


}

enum BLFontWeight : uint {
    /// Thin weight (100).
    BL_FONT_WEIGHT_THIN = 100,
    /// Extra light weight (200).
    BL_FONT_WEIGHT_EXTRA_LIGHT = 200,
    /// Light weight (300).
    BL_FONT_WEIGHT_LIGHT = 300,
    /// Semi light weight (350).
    BL_FONT_WEIGHT_SEMI_LIGHT = 350,
    /// Normal weight (400).
    BL_FONT_WEIGHT_NORMAL = 400,
    /// Medium weight (500).
    BL_FONT_WEIGHT_MEDIUM = 500,
    /// Semi bold weight (600).
    BL_FONT_WEIGHT_SEMI_BOLD = 600,
    /// Bold weight (700).
    BL_FONT_WEIGHT_BOLD = 700,
    /// Extra bold weight (800).
    BL_FONT_WEIGHT_EXTRA_BOLD = 800,
    /// Black weight (900).
    BL_FONT_WEIGHT_BLACK = 900,
    /// Extra black weight (950).
    BL_FONT_WEIGHT_EXTRA_BLACK = 950
}

/// Font string identifiers used by OpenType 'name' table.
enum BLFontStringId : uint {

    /// Copyright notice.
    BL_FONT_STRING_ID_COPYRIGHT_NOTICE = 0,
    /// Font family name.
    BL_FONT_STRING_ID_FAMILY_NAME = 1,
    /// Font subfamily name.
    BL_FONT_STRING_ID_SUBFAMILY_NAME = 2,
    /// Unique font identifier.
    BL_FONT_STRING_ID_UNIQUE_IDENTIFIER = 3,
    /// Full font name that reflects all family and relevant subfamily descriptors.
    BL_FONT_STRING_ID_FULL_NAME = 4,
    /// Version string. Should begin with the synta `Version <number>.<number>`.
    BL_FONT_STRING_ID_VERSION_STRING = 5,
    /// PostScript name for the font.
    BL_FONT_STRING_ID_POST_SCRIPT_NAME = 6,
    /// Trademark notice/information for this font.
    BL_FONT_STRING_ID_TRADEMARK = 7,
    /// Manufacturer name.
    BL_FONT_STRING_ID_MANUFACTURER_NAME = 8,
    /// Name of the designer of the typeface.
    BL_FONT_STRING_ID_DESIGNER_NAME = 9,
    /// Description of the typeface.
    BL_FONT_STRING_ID_DESCRIPTION = 10,
    /// URL of font vendor.
    BL_FONT_STRING_ID_VENDOR_URL = 11,
    /// URL of typeface designer.
    BL_FONT_STRING_ID_DESIGNER_URL = 12,
    /// Description of how the font may be legally used.
    BL_FONT_STRING_ID_LICENSE_DESCRIPTION = 13,
    /// URL where additional licensing information can be found.
    BL_FONT_STRING_ID_LICENSE_INFO_URL = 14,
    /// Reserved.
    BL_FONT_STRING_ID_RESERVED = 15,
    /// Typographic family name.
    BL_FONT_STRING_ID_TYPOGRAPHIC_FAMILY_NAME = 16,
    /// Typographic subfamily name.
    BL_FONT_STRING_ID_TYPOGRAPHIC_SUBFAMILY_NAME = 17,
    /// Compatible full name (MAC only).
    BL_FONT_STRING_ID_COMPATIBLE_FULL_NAME = 18,
    /// Sample text - font name or any other text from the designer.
    BL_FONT_STRING_ID_SAMPLE_TEXT = 19,
    /// PostScript CID findfont name.
    BL_FONT_STRING_ID_POST_SCRIPT_CID_NAME = 20,
    /// WWS family name.
    BL_FONT_STRING_ID_WWS_FAMILY_NAME = 21,
    /// WWS subfamily name.
    BL_FONT_STRING_ID_WWS_SUBFAMILY_NAME = 22,
    /// Light background palette.
    BL_FONT_STRING_ID_LIGHT_BACKGROUND_PALETTE = 23,
    /// Dark background palette.
    BL_FONT_STRING_ID_DARK_BACKGROUND_PALETTE = 24,
    /// Variations PostScript name prefix.
    BL_FONT_STRING_ID_VARIATIONS_POST_SCRIPT_PREFIX = 25,


    /// Start of custom font string ids.
    BL_FONT_STRING_ID_CUSTOM_START_INDEX = 255
}

/// Bit positions in \ref BLFontUnicodeCoverage structure.
///
/// Each bit represents a range (or multiple ranges) of unicode characters.
enum BLFontUnicodeCoverageIndex : uint {
  BL_FONT_UC_INDEX_BASIC_LATIN,                              ///< [000000-00007F] Basic Latin.
  BL_FONT_UC_INDEX_LATIN1_SUPPLEMENT,                        ///< [000080-0000FF] Latin-1 Supplement.
  BL_FONT_UC_INDEX_LATIN_EXTENDED_A,                         ///< [000100-00017F] Latin Extended-A.
  BL_FONT_UC_INDEX_LATIN_EXTENDED_B,                         ///< [000180-00024F] Latin Extended-B.
  BL_FONT_UC_INDEX_IPA_EXTENSIONS,                           ///< [000250-0002AF] IPA Extensions.
                                                             ///< [001D00-001D7F] Phonetic Extensions.
                                                             ///< [001D80-001DBF] Phonetic Extensions Supplement.
  BL_FONT_UC_INDEX_SPACING_MODIFIER_LETTERS,                 ///< [0002B0-0002FF] Spacing Modifier Letters.
                                                             ///< [00A700-00A71F] Modifier Tone Letters.
                                                             ///< [001DC0-001DFF] Combining Diacritical Marks Supplement.
  BL_FONT_UC_INDEX_COMBINING_DIACRITICAL_MARKS,              ///< [000300-00036F] Combining Diacritical Marks.
  BL_FONT_UC_INDEX_GREEK_AND_COPTIC,                         ///< [000370-0003FF] Greek and Coptic.
  BL_FONT_UC_INDEX_COPTIC,                                   ///< [002C80-002CFF] Coptic.
  BL_FONT_UC_INDEX_CYRILLIC,                                 ///< [000400-0004FF] Cyrillic.
                                                             ///< [000500-00052F] Cyrillic Supplement.
                                                             ///< [002DE0-002DFF] Cyrillic Extended-A.
                                                             ///< [00A640-00A69F] Cyrillic Extended-B.
  BL_FONT_UC_INDEX_ARMENIAN,                                 ///< [000530-00058F] Armenian.
  BL_FONT_UC_INDEX_HEBREW,                                   ///< [000590-0005FF] Hebrew.
  BL_FONT_UC_INDEX_VAI,                                      ///< [00A500-00A63F] Vai.
  BL_FONT_UC_INDEX_ARABIC,                                   ///< [000600-0006FF] Arabic.
                                                             ///< [000750-00077F] Arabic Supplement.
  BL_FONT_UC_INDEX_NKO,                                      ///< [0007C0-0007FF] NKo.
  BL_FONT_UC_INDEX_DEVANAGARI,                               ///< [000900-00097F] Devanagari.
  BL_FONT_UC_INDEX_BENGALI,                                  ///< [000980-0009FF] Bengali.
  BL_FONT_UC_INDEX_GURMUKHI,                                 ///< [000A00-000A7F] Gurmukhi.
  BL_FONT_UC_INDEX_GUJARATI,                                 ///< [000A80-000AFF] Gujarati.
  BL_FONT_UC_INDEX_ORIYA,                                    ///< [000B00-000B7F] Oriya.
  BL_FONT_UC_INDEX_TAMIL,                                    ///< [000B80-000BFF] Tamil.
  BL_FONT_UC_INDEX_TELUGU,                                   ///< [000C00-000C7F] Telugu.
  BL_FONT_UC_INDEX_KANNADA,                                  ///< [000C80-000CFF] Kannada.
  BL_FONT_UC_INDEX_MALAYALAM,                                ///< [000D00-000D7F] Malayalam.
  BL_FONT_UC_INDEX_THAI,                                     ///< [000E00-000E7F] Thai.
  BL_FONT_UC_INDEX_LAO,                                      ///< [000E80-000EFF] Lao.
  BL_FONT_UC_INDEX_GEORGIAN,                                 ///< [0010A0-0010FF] Georgian.
                                                             ///< [002D00-002D2F] Georgian Supplement.
  BL_FONT_UC_INDEX_BALINESE,                                 ///< [001B00-001B7F] Balinese.
  BL_FONT_UC_INDEX_HANGUL_JAMO,                              ///< [001100-0011FF] Hangul Jamo.
  BL_FONT_UC_INDEX_LATIN_EXTENDED_ADDITIONAL,                ///< [001E00-001EFF] Latin Extended Additional.
                                                             ///< [002C60-002C7F] Latin Extended-C.
                                                             ///< [00A720-00A7FF] Latin Extended-D.
  BL_FONT_UC_INDEX_GREEK_EXTENDED,                           ///< [001F00-001FFF] Greek Extended.
  BL_FONT_UC_INDEX_GENERAL_PUNCTUATION,                      ///< [002000-00206F] General Punctuation.
                                                             ///< [002E00-002E7F] Supplemental Punctuation.
  BL_FONT_UC_INDEX_SUPERSCRIPTS_AND_SUBSCRIPTS,              ///< [002070-00209F] Superscripts And Subscripts.
  BL_FONT_UC_INDEX_CURRENCY_SYMBOLS,                         ///< [0020A0-0020CF] Currency Symbols.
  BL_FONT_UC_INDEX_COMBINING_DIACRITICAL_MARKS_FOR_SYMBOLS,  ///< [0020D0-0020FF] Combining Diacritical Marks For Symbols.
  BL_FONT_UC_INDEX_LETTERLIKE_SYMBOLS,                       ///< [002100-00214F] Letterlike Symbols.
  BL_FONT_UC_INDEX_NUMBER_FORMS,                             ///< [002150-00218F] Number Forms.
  BL_FONT_UC_INDEX_ARROWS,                                   ///< [002190-0021FF] Arrows.
                                                             ///< [0027F0-0027FF] Supplemental Arrows-A.
                                                             ///< [002900-00297F] Supplemental Arrows-B.
                                                             ///< [002B00-002BFF] Miscellaneous Symbols and Arrows.
  BL_FONT_UC_INDEX_MATHEMATICAL_OPERATORS,                   ///< [002200-0022FF] Mathematical Operators.
                                                             ///< [002A00-002AFF] Supplemental Mathematical Operators.
                                                             ///< [0027C0-0027EF] Miscellaneous Mathematical Symbols-A.
                                                             ///< [002980-0029FF] Miscellaneous Mathematical Symbols-B.
  BL_FONT_UC_INDEX_MISCELLANEOUS_TECHNICAL,                  ///< [002300-0023FF] Miscellaneous Technical.
  BL_FONT_UC_INDEX_CONTROL_PICTURES,                         ///< [002400-00243F] Control Pictures.
  BL_FONT_UC_INDEX_OPTICAL_CHARACTER_RECOGNITION,            ///< [002440-00245F] Optical Character Recognition.
  BL_FONT_UC_INDEX_ENCLOSED_ALPHANUMERICS,                   ///< [002460-0024FF] Enclosed Alphanumerics.
  BL_FONT_UC_INDEX_BOX_DRAWING,                              ///< [002500-00257F] Box Drawing.
  BL_FONT_UC_INDEX_BLOCK_ELEMENTS,                           ///< [002580-00259F] Block Elements.
  BL_FONT_UC_INDEX_GEOMETRIC_SHAPES,                         ///< [0025A0-0025FF] Geometric Shapes.
  BL_FONT_UC_INDEX_MISCELLANEOUS_SYMBOLS,                    ///< [002600-0026FF] Miscellaneous Symbols.
  BL_FONT_UC_INDEX_DINGBATS,                                 ///< [002700-0027BF] Dingbats.
  BL_FONT_UC_INDEX_CJK_SYMBOLS_AND_PUNCTUATION,              ///< [003000-00303F] CJK Symbols And Punctuation.
  BL_FONT_UC_INDEX_HIRAGANA,                                 ///< [003040-00309F] Hiragana.
  BL_FONT_UC_INDEX_KATAKANA,                                 ///< [0030A0-0030FF] Katakana.
                                                             ///< [0031F0-0031FF] Katakana Phonetic Extensions.
  BL_FONT_UC_INDEX_BOPOMOFO,                                 ///< [003100-00312F] Bopomofo.
                                                             ///< [0031A0-0031BF] Bopomofo Extended.
  BL_FONT_UC_INDEX_HANGUL_COMPATIBILITY_JAMO,                ///< [003130-00318F] Hangul Compatibility Jamo.
  BL_FONT_UC_INDEX_PHAGS_PA,                                 ///< [00A840-00A87F] Phags-pa.
  BL_FONT_UC_INDEX_ENCLOSED_CJK_LETTERS_AND_MONTHS,          ///< [003200-0032FF] Enclosed CJK Letters And Months.
  BL_FONT_UC_INDEX_CJK_COMPATIBILITY,                        ///< [003300-0033FF] CJK Compatibility.
  BL_FONT_UC_INDEX_HANGUL_SYLLABLES,                         ///< [00AC00-00D7AF] Hangul Syllables.
  BL_FONT_UC_INDEX_NON_PLANE,                                ///< [00D800-00DFFF] Non-Plane 0 *.
  BL_FONT_UC_INDEX_PHOENICIAN,                               ///< [010900-01091F] Phoenician.
  BL_FONT_UC_INDEX_CJK_UNIFIED_IDEOGRAPHS,                   ///< [004E00-009FFF] CJK Unified Ideographs.
                                                             ///< [002E80-002EFF] CJK Radicals Supplement.
                                                             ///< [002F00-002FDF] Kangxi Radicals.
                                                             ///< [002FF0-002FFF] Ideographic Description Characters.
                                                             ///< [003400-004DBF] CJK Unified Ideographs Extension A.
                                                             ///< [020000-02A6DF] CJK Unified Ideographs Extension B.
                                                             ///< [003190-00319F] Kanbun.
  BL_FONT_UC_INDEX_PRIVATE_USE_PLANE0,                       ///< [00E000-00F8FF] Private Use (Plane 0).
  BL_FONT_UC_INDEX_CJK_STROKES,                              ///< [0031C0-0031EF] CJK Strokes.
                                                             ///< [00F900-00FAFF] CJK Compatibility Ideographs.
                                                             ///< [02F800-02FA1F] CJK Compatibility Ideographs Supplement.
  BL_FONT_UC_INDEX_ALPHABETIC_PRESENTATION_FORMS,            ///< [00FB00-00FB4F] Alphabetic Presentation Forms.
  BL_FONT_UC_INDEX_ARABIC_PRESENTATION_FORMS_A,              ///< [00FB50-00FDFF] Arabic Presentation Forms-A.
  BL_FONT_UC_INDEX_COMBINING_HALF_MARKS,                     ///< [00FE20-00FE2F] Combining Half Marks.
  BL_FONT_UC_INDEX_VERTICAL_FORMS,                           ///< [00FE10-00FE1F] Vertical Forms.
                                                             ///< [00FE30-00FE4F] CJK Compatibility Forms.
  BL_FONT_UC_INDEX_SMALL_FORM_VARIANTS,                      ///< [00FE50-00FE6F] Small Form Variants.
  BL_FONT_UC_INDEX_ARABIC_PRESENTATION_FORMS_B,              ///< [00FE70-00FEFF] Arabic Presentation Forms-B.
  BL_FONT_UC_INDEX_HALFWIDTH_AND_FULLWIDTH_FORMS,            ///< [00FF00-00FFEF] Halfwidth And Fullwidth Forms.
  BL_FONT_UC_INDEX_SPECIALS,                                 ///< [00FFF0-00FFFF] Specials.
  BL_FONT_UC_INDEX_TIBETAN,                                  ///< [000F00-000FFF] Tibetan.
  BL_FONT_UC_INDEX_SYRIAC,                                   ///< [000700-00074F] Syriac.
  BL_FONT_UC_INDEX_THAANA,                                   ///< [000780-0007BF] Thaana.
  BL_FONT_UC_INDEX_SINHALA,                                  ///< [000D80-000DFF] Sinhala.
  BL_FONT_UC_INDEX_MYANMAR,                                  ///< [001000-00109F] Myanmar.
  BL_FONT_UC_INDEX_ETHIOPIC,                                 ///< [001200-00137F] Ethiopic.
                                                             ///< [001380-00139F] Ethiopic Supplement.
                                                             ///< [002D80-002DDF] Ethiopic Extended.
  BL_FONT_UC_INDEX_CHEROKEE,                                 ///< [0013A0-0013FF] Cherokee.
  BL_FONT_UC_INDEX_UNIFIED_CANADIAN_ABORIGINAL_SYLLABICS,    ///< [001400-00167F] Unified Canadian Aboriginal Syllabics.
  BL_FONT_UC_INDEX_OGHAM,                                    ///< [001680-00169F] Ogham.
  BL_FONT_UC_INDEX_RUNIC,                                    ///< [0016A0-0016FF] Runic.
  BL_FONT_UC_INDEX_KHMER,                                    ///< [001780-0017FF] Khmer.
                                                             ///< [0019E0-0019FF] Khmer Symbols.
  BL_FONT_UC_INDEX_MONGOLIAN,                                ///< [001800-0018AF] Mongolian.
  BL_FONT_UC_INDEX_BRAILLE_PATTERNS,                         ///< [002800-0028FF] Braille Patterns.
  BL_FONT_UC_INDEX_YI_SYLLABLES_AND_RADICALS,                ///< [00A000-00A48F] Yi Syllables.
                                                             ///< [00A490-00A4CF] Yi Radicals.
  BL_FONT_UC_INDEX_TAGALOG_HANUNOO_BUHID_TAGBANWA,           ///< [001700-00171F] Tagalog.
                                                             ///< [001720-00173F] Hanunoo.
                                                             ///< [001740-00175F] Buhid.
                                                             ///< [001760-00177F] Tagbanwa.
  BL_FONT_UC_INDEX_OLD_ITALIC,                               ///< [010300-01032F] Old Italic.
  BL_FONT_UC_INDEX_GOTHIC,                                   ///< [010330-01034F] Gothic.
  BL_FONT_UC_INDEX_DESERET,                                  ///< [010400-01044F] Deseret.
  BL_FONT_UC_INDEX_MUSICAL_SYMBOLS,                          ///< [01D000-01D0FF] Byzantine Musical Symbols.
                                                             ///< [01D100-01D1FF] Musical Symbols.
                                                             ///< [01D200-01D24F] Ancient Greek Musical Notation.
  BL_FONT_UC_INDEX_MATHEMATICAL_ALPHANUMERIC_SYMBOLS,        ///< [01D400-01D7FF] Mathematical Alphanumeric Symbols.
  BL_FONT_UC_INDEX_PRIVATE_USE_PLANE_15_16,                  ///< [0F0000-0FFFFD] Private Use (Plane 15).
                                                             ///< [100000-10FFFD] Private Use (Plane 16).
  BL_FONT_UC_INDEX_VARIATION_SELECTORS,                      ///< [00FE00-00FE0F] Variation Selectors.
                                                             ///< [0E0100-0E01EF] Variation Selectors Supplement.
  BL_FONT_UC_INDEX_TAGS,                                     ///< [0E0000-0E007F] Tags.
  BL_FONT_UC_INDEX_LIMBU,                                    ///< [001900-00194F] Limbu.
  BL_FONT_UC_INDEX_TAI_LE,                                   ///< [001950-00197F] Tai Le.
  BL_FONT_UC_INDEX_NEW_TAI_LUE,                              ///< [001980-0019DF] New Tai Lue.
  BL_FONT_UC_INDEX_BUGINESE,                                 ///< [001A00-001A1F] Buginese.
  BL_FONT_UC_INDEX_GLAGOLITIC,                               ///< [002C00-002C5F] Glagolitic.
  BL_FONT_UC_INDEX_TIFINAGH,                                 ///< [002D30-002D7F] Tifinagh.
  BL_FONT_UC_INDEX_YIJING_HEXAGRAM_SYMBOLS,                  ///< [004DC0-004DFF] Yijing Hexagram Symbols.
  BL_FONT_UC_INDEX_SYLOTI_NAGRI,                             ///< [00A800-00A82F] Syloti Nagri.
  BL_FONT_UC_INDEX_LINEAR_B_SYLLABARY_AND_IDEOGRAMS,         ///< [010000-01007F] Linear B Syllabary.
                                                             ///< [010080-0100FF] Linear B Ideograms.
                                                             ///< [010100-01013F] Aegean Numbers.
  BL_FONT_UC_INDEX_ANCIENT_GREEK_NUMBERS,                    ///< [010140-01018F] Ancient Greek Numbers.
  BL_FONT_UC_INDEX_UGARITIC,                                 ///< [010380-01039F] Ugaritic.
  BL_FONT_UC_INDEX_OLD_PERSIAN,                              ///< [0103A0-0103DF] Old Persian.
  BL_FONT_UC_INDEX_SHAVIAN,                                  ///< [010450-01047F] Shavian.
  BL_FONT_UC_INDEX_OSMANYA,                                  ///< [010480-0104AF] Osmanya.
  BL_FONT_UC_INDEX_CYPRIOT_SYLLABARY,                        ///< [010800-01083F] Cypriot Syllabary.
  BL_FONT_UC_INDEX_KHAROSHTHI,                               ///< [010A00-010A5F] Kharoshthi.
  BL_FONT_UC_INDEX_TAI_XUAN_JING_SYMBOLS,                    ///< [01D300-01D35F] Tai Xuan Jing Symbols.
  BL_FONT_UC_INDEX_CUNEIFORM,                                ///< [012000-0123FF] Cuneiform.
                                                             ///< [012400-01247F] Cuneiform Numbers and Punctuation.
  BL_FONT_UC_INDEX_COUNTING_ROD_NUMERALS,                    ///< [01D360-01D37F] Counting Rod Numerals.
  BL_FONT_UC_INDEX_SUNDANESE,                                ///< [001B80-001BBF] Sundanese.
  BL_FONT_UC_INDEX_LEPCHA,                                   ///< [001C00-001C4F] Lepcha.
  BL_FONT_UC_INDEX_OL_CHIKI,                                 ///< [001C50-001C7F] Ol Chiki.
  BL_FONT_UC_INDEX_SAURASHTRA,                               ///< [00A880-00A8DF] Saurashtra.
  BL_FONT_UC_INDEX_KAYAH_LI,                                 ///< [00A900-00A92F] Kayah Li.
  BL_FONT_UC_INDEX_REJANG,                                   ///< [00A930-00A95F] Rejang.
  BL_FONT_UC_INDEX_CHAM,                                     ///< [00AA00-00AA5F] Cham.
  BL_FONT_UC_INDEX_ANCIENT_SYMBOLS,                          ///< [010190-0101CF] Ancient Symbols.
  BL_FONT_UC_INDEX_PHAISTOS_DISC,                            ///< [0101D0-0101FF] Phaistos Disc.
  BL_FONT_UC_INDEX_CARIAN_LYCIAN_LYDIAN,                     ///< [0102A0-0102DF] Carian.
                                                             ///< [010280-01029F] Lycian.
                                                             ///< [010920-01093F] Lydian.
  BL_FONT_UC_INDEX_DOMINO_AND_MAHJONG_TILES,                 ///< [01F030-01F09F] Domino Tiles.
                                                             ///< [01F000-01F02F] Mahjong Tiles.
  BL_FONT_UC_INDEX_INTERNAL_USAGE_123,                       ///< Reserved for internal usage (123).
  BL_FONT_UC_INDEX_INTERNAL_USAGE_124,                       ///< Reserved for internal usage (124).
  BL_FONT_UC_INDEX_INTERNAL_USAGE_125,                       ///< Reserved for internal usage (125).
  BL_FONT_UC_INDEX_INTERNAL_USAGE_126,                       ///< Reserved for internal usage (126).
  BL_FONT_UC_INDEX_INTERNAL_USAGE_127,                       ///< Reserved for internal usage (127).


}

/// Text direction.
enum BLTextDirection : uint {

  /// Left-to-right direction.
  BL_TEXT_DIRECTION_LTR = 0,
  /// Right-to-left direction.
  BL_TEXT_DIRECTION_RTL = 1,


}

/// Glyph id - a 32-bit unsigned integer.
alias BLGlyphId = uint;

/// Contains additional information associated with a glyph used by `BLGlyphBuffer`.
struct BLGlyphInfo {
nothrow @nogc:

    uint cluster;
    uint reserved;

    pragma(inline, true)
    void reset() nothrow { this = BLGlyphInfo.init; }
}

/// Glyph placement.
///
/// Provides information about__ glyph offset (x/y) and advance (x/y).
struct BLGlyphPlacement {
nothrow @nogc:

    BLPointI placement;
    BLPointI advance;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}


/// Character to glyph mapping state.
struct BLGlyphMappingState {
nothrow @nogc:

    /// Number of glyphs or glyph-items on out__put.
    size_t glyphCount;
    /// Index of the first undefined glyph (SIZE_MAX if none).
    size_t undefinedFirst;
    /// Undefined glyph count (chars that have no mapping).
    size_t undefinedCount;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}

/// Information passed to a `BLPathSinkFunc` sink by `BLFont::getGlyphOutlines()`.
struct BLGlyphOutlineSinkInfo {
  size_t glyphIndex;
  size_t contourCount;
}

/// Font unicode coverage.
///
/// Unicode coverage describes which unicode characters are provided by a font. Blend2D accesses this information by
/// reading "OS/2" table, if available.
struct BLFontUnicodeCoverage {
nothrow @nogc:
    uint[4] data;


    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }

    pragma(inline, true)
    bool empty() const nothrow {
        return (data[0] | data[1] | data[2] | data[3]) == 0;
    }

    pragma(inline, true)
    bool hasBit(uint index) const nothrow {
        return ((data[index / 32] >> (index % 32)) & 0x1) != 0;
    }

    pragma(inline, true)
    void setBit(uint index) nothrow {
        data[index / 32] |= uint(1) << (index % 32);
    }

    pragma(inline, true)
    void clearBit(uint index) nothrow {
        data[index / 32] &= ~(uint(1) << (index % 32));
    }

    // pragma(inline, true)
    // bool opEquals(ref inout(BLFontUnicodeCoverage) other) inout nothrow {
    // return cast(bool)(  cast(uint)data[0] == cast(uint)other.data[0] &&
    //                     cast(uint)data[1] == cast(uint)other.data[1] &&
    //                     cast(uint)data[2] == cast(uint)other.data[2] &&
    //                     cast(uint)data[3] == cast(uint)other.data[3]);
    // }
}

/// Font PANOSE classification.
struct BLFontPanose {
nothrow @nogc:
    union {
        ubyte[10] data;
        ubyte familyKind;
        
        BLFontPanoseText text;
        BLFontPanoseScript script;
        BLFontPanoseDecorative decorative;
        BLFontPanoseSymbol symbol;

        struct BLFontPanoseText {
            ubyte familyKind;
            ubyte serifStyle;
            ubyte weight;
            ubyte proportion;
            ubyte contrast;
            ubyte strokeVariation;
            ubyte armStyle;
            ubyte letterform;
            ubyte midline;
            ubyte xHeight;
        }

        struct BLFontPanoseScript {
            ubyte familyKind;
            ubyte toolKind;
            ubyte weight;
            ubyte spacing;
            ubyte aspectRatio;
            ubyte contrast;
            ubyte topology;
            ubyte form;
            ubyte finials;
            ubyte xAscent;
        }

        struct BLFontPanoseDecorative {
            ubyte familyKind;
            ubyte decorativeClass;
            ubyte weight;
            ubyte aspect;
            ubyte contrast;
            ubyte serifVariant;
            ubyte treatment;
            ubyte lining;
            ubyte topology;
            ubyte characterRange;
        }

        struct BLFontPanoseSymbol {
            ubyte familyKind;
            ubyte symbolKind;
            ubyte weight;
            ubyte spacing;
            ubyte aspectRatioAndContrast;
            ubyte aspectRatio94;
            ubyte aspectRatio119;
            ubyte aspectRatio157;
            ubyte aspectRatio163;
            ubyte aspectRatio211;
        }
    }

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }

    pragma(inline, true)
    bool empty() const nothrow {
        return (data[0] | data[1] | data[2] | data[3] | data[4] |
            data[5] | data[6] | data[7] | data[8] | data[9] ) == 0;
    }
}

/// 2x2 transformation matrix used by `BLFont`. It's similar to `BLMatrix2D`, however, it doesn't provide a
/// translation part as it's assumed to be zero.
struct BLFontMatrix {
nothrow @nogc:
    union {
        double[4] m;
        struct {
            double m00;
            double m01;
            double m10;
            double m11;
        }
    }

    pragma(inline, true)
    void reset() nothrow {
        m00 = 1.0;
        m01 = 0.0;
        m10 = 0.0;
        m11 = 1.0;
    }

    pragma(inline, true)
    void reset(double m00Value, double m01Value, double m10Value, double m11Value) nothrow {
        m00 = m00Value;
        m01 = m01Value;
        m10 = m10Value;
        m11 = m11Value;
    }
}

/// Scaled `BLFontDesignMetrics` based on font size and other properties.
struct BLFontMetrics {
nothrow @nogc:
    /// Font size.
    float size;

    union {
        struct {

            /// Font ascent (horizontal orientation).
            float ascent;
            /// Font ascent (vertical orientation).
            float vAscent;
            /// Font descent (horizontal orientation).
            float descent;
            /// Font descent (vertical orientation).
            float vDescent;
        }

        struct {
            float[2] ascentByOrientation;
            float[2] descentByOrientation;
        }
    }

    /// Line gap.
    float lineGap;
    /// Distance between the baseline and the mean line of lower-case letters.
    float xHeight;
    /// Maximum height of a capital letter above the baseline.
    float capHeight;

    /// Minimum x, reported by the font.
    float xMin;
    /// Minimum y, reported by the font.
    float yMin;
    /// Maximum x, reported by the font.
    float xMax;
    /// Maximum y, reported by the font.
    float yMax;

    /// Text underline position.
    float underlinePosition;
    /// Text underline thickness.
    float underlineThickness;
    /// Text strikethrough position.
    float strikethroughPosition;
    /// Text strikethrough thickness.
    float strikethroughThickness;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}

/// Design metrics of a font.
///
/// Design metrics is information that `BLFontFace` collected directly from the font data. It means that all
/// fields are measured in font design units.
///
/// When a new `BLFont` instance is created a scaled metrics `BLFontMetrics` is automatically calculated from
/// `BLFontDesignMetrics` including other members like transformation, etc...
struct BLFontDesignMetrics {
nothrow @nogc:
    /// Units per EM square.
    int unitsPerEm;
    /// Lowest readable size in pixels.
    int lowestPPEM;
    /// Line gap.
    int lineGap;
    /// Distance between the baseline and the mean line of lower-case letters.
    int xHeight;
    /// Maximum height of a capital letter above the baseline.
    int capHeight;

    union {
        struct {
            /// Ascent (horizontal layout__).
            int ascent;
            /// Ascent (vertical layout__).
            int vAscent;
            /// Descent (horizontal layout__).
            int descent;
            /// Descent (vertical layout__).
            int vDescent;
            /// Minimum leading-side bearing (horizontal layout__).
            int hMinLSB;
            /// Minimum leading-side bearing (vertical layout__).
            int vMinLSB;
            /// Minimum trailing-side bearing (horizontal layout__).
            int hMinTSB;
            /// Minimum trailing-side bearing (vertical layout__).
            int vMinTSB;
            /// Maximum advance (horizontal layout__).
            int hMaxAdvance;
            /// Maximum advance (vertical layout__).
            int vMaxAdvance;
        };

        struct {
            /// Horizontal & vertical ascents.
            int[2] ascentByOrientation;
            /// Horizontal & vertical descents.
            int[2] descentByOrientation;
            /// Minimum leading-side bearing (horizontal and vertical).
            int[2] minLSBByOrientation;
            /// Minimum trailing-side bearing (horizontal and vertical)..
            int[2] minTSBByOrientation;
            /// Maximum advance width (horizontal) and height (vertical).
            int[2] maxAdvanceByOrientation;
        }
    }

    /// Aggregated bounding box of all glyphs in the font.
    ///
    /// \note This value is reported by the font data so it's not granted to be true.
    BLBoxI glyphBoundingBox;

    /// Text underline position.
    int underlinePosition;
    /// Text underline thickness.
    int underlineThickness;
    /// Text strikethrough position.
    int strikethroughPosition;
    /// Text strikethrough thickness.
    int strikethroughThickness;


    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}

/// Text metrics.
struct BLTextMetrics {
nothrow @nogc:
    BLPoint advance;
    BLPoint leadingBearing;
    BLPoint trailingBearing;
    BLBox boundingBox;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}

/// Flags used by \ref BLFontFace (or \ref BLFontFaceCore)
enum BLFontFaceFlags : uint {

    /// No flags.
    BL_FONT_FACE_NO_FLAGS = 0u,
    /// Font uses typographic family and subfamily names.
    BL_FONT_FACE_FLAG_TYPOGRAPHIC_NAMES = 0x00000001u,
    /// Font uses typographic metrics.
    BL_FONT_FACE_FLAG_TYPOGRAPHIC_METRICS = 0x00000002u,
    /// Character to glyph mapping is available.
    BL_FONT_FACE_FLAG_CHAR_TO_GLYPH_MAPPING = 0x00000004u,
    /// Horizontal glyph metrics (advances, side bearings) is available.
    BL_FONT_FACE_FLAG_HORIZONTAL_METIRCS = 0x00000010u,
    /// Vertical glyph metrics (advances, side bearings) is available.
    BL_FONT_FACE_FLAG_VERTICAL_METRICS = 0x00000020u,
    /// Legacy horizontal kerning feature ('kern' table with horizontal kerning data).
    BL_FONT_FACE_FLAG_HORIZONTAL_KERNING = 0x00000040u,
    /// Legacy vertical kerning feature ('kern' table with vertical kerning data).
    BL_FONT_FACE_FLAG_VERTICAL_KERNING = 0x00000080u,
    /// OpenType features (GDEF, GPOS, GSUB) are available.
    BL_FONT_FACE_FLAG_OPENTYPE_FEATURES = 0x00000100u,
    /// Panose classification is available.
    BL_FONT_FACE_FLAG_PANOSE_DATA = 0x00000200u,
    /// Unicode coverage information is available.
    BL_FONT_FACE_FLAG_UNICODE_COVERAGE = 0x00000400u,
    /// Baseline for font at `y` equals 0.
    BL_FONT_FACE_FLAG_BASELINE_Y_EQUALS_0 = 0x00001000u,
    /// Left sidebearing point at `x == 0` (TT only).
    BL_FONT_FACE_FLAG_LSB_POINT_X_EQUALS_0 = 0x00002000u,
    /// Unicode variation sequences feature is available.
    BL_FONT_FACE_FLAG_VARIATION_SEQUENCES = 0x10000000u,
    /// OpenType Font Variations feature is available.
    BL_FONT_FACE_FLAG_OPENTYPE_VARIATIONS = 0x20000000u,
    /// This is a symbol font.
    BL_FONT_FACE_FLAG_SYMBOL_FONT = 0x40000000u,
    /// This is a last resort font.
    BL_FONT_FACE_FLAG_LAST_RESORT_FONT = 0x80000000u
}

/// Diagnostic flags offered by \ref BLFontFace (or \ref BLFontFaceCore).
enum BLFontFaceDiagFlags : uint {
    /// No flags.
    BL_FONT_FACE_DIAG_NO_FLAGS = 0u,
    /// Wrong data in 'name' table.
    BL_FONT_FACE_DIAG_WRONG_NAME_DATA = 0x00000001u,
    /// Fixed data read from 'name' table and possibly fixed font family/subfamily name.
    BL_FONT_FACE_DIAG_FIXED_NAME_DATA = 0x00000002u,

    /// Wrong data in 'kern' table [kerning disabled].
    BL_FONT_FACE_DIAG_WRONG_KERN_DATA = 0x00000004u,
    /// Fixed data read from 'kern' table so it can be used.
    BL_FONT_FACE_DIAG_FIXED_KERN_DATA = 0x00000008u,

    /// Wrong data in 'cmap' table.
    BL_FONT_FACE_DIAG_WRONG_CMAP_DATA = 0x00000010u,
    /// Wrong format in 'cmap' (sub)table.
    BL_FONT_FACE_DIAG_WRONG_CMAP_FORMAT = 0x00000020u
}

/// Format of an out_line stored in a font.
enum BLFontOutlineType : uint {

  /// None.
  BL_FONT_OUTLINE_TYPE_NONE = 0,
  /// Truetype out_lines.
  BL_FONT_OUTLINE_TYPE_TRUETYPE = 1,
  /// OpenType (CFF) out_lines.
  BL_FONT_OUTLINE_TYPE_CFF = 2,
  /// OpenType (CFF2) out_lines with font variations support.
  BL_FONT_OUTLINE_TYPE_CFF2 = 3,


}
/// Information of \ref BLFontFace.
struct BLFontFaceInfo {
nothrow @nogc:

    /// Font face type, see \ref BLFontFaceType.
    ubyte faceType;
    /// Type of out_lines used by the font face, see \ref BLFontOutlineType.
    ubyte out_lineType;
    /// Reserved fields.
    ubyte[2] reserved8;
    /// Number of glyphs provided by this font face.
    uint glyphCount;

    /// Revision (read from 'head' table, represented as 16.16 fixed point).
    uint revision;

    /// Face face index in a TTF/OTF collection or zero if not part of a collection.
    uint faceIndex;
    /// Font face flags, see \ref BLFontFaceFlags
    uint faceFlags;

    /// Font face diagnostic flags, see \ref BLFontFaceDiagFlags.
    uint diagFlags;

    /// Reserved for future use, set to zero.
    uint[2] reserved;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}

/// Properties that can be used to query \ref BLFont and \ref BLFontFace.
///
/// \sa BLFontManager.
struct BLFontQueryProperties {
nothrow @nogc:

    /// Font style.
    uint style;
    /// Font weight.
    uint weight;
    /// Font stretch.
    uint stretch;

    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }
}

/// Font [C API].
struct BLFont {
    mixin BLExtends!BLObject;
}

/// Font Data [C API].
struct BLFontData {
    mixin BLExtends!BLObject;
}

/// Font face [C API].
struct BLFontFace {
    mixin BLExtends!BLObject;
}

/// Font manager [C API].
struct BLFontManager {
    mixin BLExtends!BLObject;
}

/// Font feature settings [C API].
struct BLFontFeatureSettings {
    mixin BLExtends!BLObject;
}

/// Font variation settings [C API].
struct BLFontVariationSettings {
    mixin BLExtends!BLObject;
}


version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blFontInit(BLFont* self);
    BLResult blFontInitMove(BLFont* self, BLFont* other);
    BLResult blFontInitWeak(BLFont* self, const BLFont* other);
    BLResult blFontDestroy(BLFont* self);
    BLResult blFontReset(BLFont* self);
    BLResult blFontAssignMove(BLFont* self, BLFont* other);
    BLResult blFontAssignWeak(BLFont* self, const BLFont* other);
    bool blFontEquals(const BLFont* a, const BLFont* b);
    BLResult blFontCreateFromFace(BLFont* self, const(BLFontFace)* face, float size);
    BLResult blFontCreateFromFaceWithSettings(BLFont* self, const(BLFontFace)* face, float size, const BLFontFeatureSettings* featureSettings, const BLFontVariationSettings* variationSettings);
    BLResult blFontGetFace(const BLFont* self, BLFontFace* out__);
    float blFontGetSize(const BLFont* self);
    BLResult blFontSetSize(BLFont* self, float size);
    BLResult blFontGetMetrics(const BLFont* self, BLFontMetrics* out__);
    BLResult blFontGetMatrix(const BLFont* self, BLFontMatrix* out__);
    BLResult blFontGetDesignMetrics(const BLFont* self, BLFontDesignMetrics* out__);
    BLResult blFontGetFeatureSettings(const BLFont* self, BLFontFeatureSettings* out__);
    BLResult blFontSetFeatureSettings(BLFont* self, const BLFontFeatureSettings* featureSettings);
    BLResult blFontResetFeatureSettings(BLFont* self);
    BLResult blFontGetVariationSettings(const BLFont* self, BLFontVariationSettings* out__);
    BLResult blFontSetVariationSettings(BLFont* self, const BLFontVariationSettings* variationSettings);
    BLResult blFontResetVariationSettings(BLFont* self);
    BLResult blFontShape(const BLFont* self, BLGlyphBuffer* gb);
    BLResult blFontMapTextToGlyphs(const BLFont* self, BLGlyphBuffer* gb, BLGlyphMappingState* stateOut);
    BLResult blFontPositionGlyphs(const BLFont* self, BLGlyphBuffer* gb);
    BLResult blFontApplyKerning(const BLFont* self, BLGlyphBuffer* gb);
    BLResult blFontApplyGSub(const BLFont* self, BLGlyphBuffer* gb, const BLBitArray* lookups);
    BLResult blFontApplyGPos(const BLFont* self, BLGlyphBuffer* gb, const BLBitArray* lookups);
    BLResult blFontGetTextMetrics(const BLFont* self, BLGlyphBuffer* gb, BLTextMetrics* out__);
    BLResult blFontGetGlyphBounds(const BLFont* self, const uint* glyphData, ptrdiff_t glyphAdvance, BLBoxI* out__, size_t count);
    BLResult blFontGetGlyphAdvances(const BLFont* self, const uint* glyphData, ptrdiff_t glyphAdvance, BLGlyphPlacement* out__, size_t count);
    BLResult blFontGetGlyphOutlines(const BLFont* self, BLGlyphId glyphId, const BLMatrix2D* userTransform, BLPath* out__, BLPathSinkFunc sink, void* userData);
    BLResult blFontGetGlyphRunOutlines(const BLFont* self, const BLGlyphRun* glyphRun, const BLMatrix2D* userTransform, BLPath* out__, BLPathSinkFunc sink, void* userData);

    BLResult blFontFaceInit(BLFontFace* self);
    BLResult blFontFaceInitMove(BLFontFace* self, BLFontFace* other);
    BLResult blFontFaceInitWeak(BLFontFace* self, const(BLFontFace)* other);
    BLResult blFontFaceDestroy(BLFontFace* self);
    BLResult blFontFaceReset(BLFontFace* self);
    BLResult blFontFaceAssignMove(BLFontFace* self, BLFontFace* other);
    BLResult blFontFaceAssignWeak(BLFontFace* self, const(BLFontFace)* other);
    bool blFontFaceEquals(const(BLFontFace)* a, const(BLFontFace)* b);
    BLResult blFontFaceCreateFromFile(BLFontFace* self, const(char)* fileName, BLFileReadFlags readFlags);
    BLResult blFontFaceCreateFromData(BLFontFace* self, const BLFontData* fontData, uint faceIndex);
    BLResult blFontFaceGetFullName(const(BLFontFace)* self, BLString* out_);
    BLResult blFontFaceGetFamilyName(const(BLFontFace)* self, BLString* out_);
    BLResult blFontFaceGetSubfamilyName(const(BLFontFace)* self, BLString* out_);
    BLResult blFontFaceGetPostScriptName(const(BLFontFace)* self, BLString* out_);
    BLResult blFontFaceGetFaceInfo(const(BLFontFace)* self, BLFontFaceInfo* out_);
    BLResult blFontFaceGetDesignMetrics(const(BLFontFace)* self, BLFontDesignMetrics* out_);
    BLResult blFontFaceGetUnicodeCoverage(const(BLFontFace)* self, BLFontUnicodeCoverage* out_);
    BLResult blFontFaceGetCharacterCoverage(const(BLFontFace)* self, BLBitSet* out_);
    bool blFontFaceHasScriptTag(const(BLFontFace)* self, BLTag scriptTag);
    bool blFontFaceHasFeatureTag(const(BLFontFace)* self, BLTag featureTag);
    bool blFontFaceHasVariationTag(const(BLFontFace)* self, BLTag variationTag);
    BLResult blFontFaceGetScriptTags(const(BLFontFace)* self, BLArray* out_);
    BLResult blFontFaceGetFeatureTags(const(BLFontFace)* self, BLArray* out_);
    BLResult blFontFaceGetVariationTags(const(BLFontFace)* self, BLArray* out_);

    BLResult  blFontManagerInit(BLFontManager* self);
    BLResult  blFontManagerInitMove(BLFontManager* self, BLFontManager* other);
    BLResult  blFontManagerInitWeak(BLFontManager* self, const(BLFontManager)* other);
    BLResult  blFontManagerInitNew(BLFontManager* self);
    BLResult  blFontManagerDestroy(BLFontManager* self);
    BLResult  blFontManagerReset(BLFontManager* self);
    BLResult  blFontManagerAssignMove(BLFontManager* self, BLFontManager* other);
    BLResult  blFontManagerAssignWeak(BLFontManager* self, const(BLFontManager)* other);
    BLResult  blFontManagerCreate(BLFontManager* self);
    size_t  blFontManagerGetFaceCount(const(BLFontManager)* self);
    size_t  blFontManagerGetFamilyCount(const(BLFontManager)* self);
    bool  blFontManagerHasFace(const(BLFontManager)* self, const(BLFontFace)* face);
    BLResult  blFontManagerAddFace(BLFontManager* self, const(BLFontFace)* face);
    BLResult  blFontManagerQueryFace(const(BLFontManager)* self, const(char)* name, size_t nameSize, const(BLFontQueryProperties)* properties, BLFontFace* out_);
    BLResult  blFontManagerQueryFacesByFamilyName(const(BLFontManager)* self, const(char)* name, size_t nameSize, BLArray* out_);
    bool  blFontManagerEquals(const(BLFontManager)* a, const(BLFontManager)* b);


} else {
nothrow @nogc extern(C):

    BLResult function(BLFont* self) blFontInit;
    BLResult function(BLFont* self, BLFont* other) blFontInitMove;
    BLResult function(BLFont* self, const BLFont* other) blFontInitWeak;
    BLResult function(BLFont* self) blFontDestroy;
    BLResult function(BLFont* self) blFontReset;
    BLResult function(BLFont* self, BLFont* other) blFontAssignMove;
    BLResult function(BLFont* self, const BLFont* other) blFontAssignWeak;
    bool function(const BLFont* a, const BLFont* b) blFontEquals;
    BLResult function(BLFont* self, const(BLFontFace)* face, float size) blFontCreateFromFace;
    BLResult function(BLFont* self, const(BLFontFace)* face, float size, const BLFontFeatureSettings* featureSettings, const BLFontVariationSettings* variationSettings) blFontCreateFromFaceWithSettings;
    BLResult function(const BLFont* self, BLFontFace* out__) blFontGetFace;
    float function(const BLFont* self) blFontGetSize;
    BLResult function(BLFont* self, float size) blFontSetSize;
    BLResult function(const BLFont* self, BLFontMetrics* out__) blFontGetMetrics;
    BLResult function(const BLFont* self, BLFontMatrix* out__) blFontGetMatrix;
    BLResult function(const BLFont* self, BLFontDesignMetrics* out__) blFontGetDesignMetrics;
    BLResult function(const BLFont* self, BLFontFeatureSettings* out__) blFontGetFeatureSettings;
    BLResult function(BLFont* self, const BLFontFeatureSettings* featureSettings) blFontSetFeatureSettings;
    BLResult function(BLFont* self) blFontResetFeatureSettings;
    BLResult function(const BLFont* self, BLFontVariationSettings* out__) blFontGetVariationSettings;
    BLResult function(BLFont* self, const BLFontVariationSettings* variationSettings) blFontSetVariationSettings;
    BLResult function(BLFont* self) blFontResetVariationSettings;
    BLResult function(const BLFont* self, BLGlyphBuffer* gb) blFontShape;
    BLResult function(const BLFont* self, BLGlyphBuffer* gb, BLGlyphMappingState* stateOut) blFontMapTextToGlyphs;
    BLResult function(const BLFont* self, BLGlyphBuffer* gb) blFontPositionGlyphs;
    BLResult function(const BLFont* self, BLGlyphBuffer* gb) blFontApplyKerning;
    BLResult function(const BLFont* self, BLGlyphBuffer* gb, const BLBitArray* lookups) blFontApplyGSub;
    BLResult function(const BLFont* self, BLGlyphBuffer* gb, const BLBitArray* lookups) blFontApplyGPos;
    BLResult function(const BLFont* self, BLGlyphBuffer* gb, BLTextMetrics* out__) blFontGetTextMetrics;
    BLResult function(const BLFont* self, const uint* glyphData, ptrdiff_t glyphAdvance, BLBoxI* out__, size_t count) blFontGetGlyphBounds;
    BLResult function(const BLFont* self, const uint* glyphData, ptrdiff_t glyphAdvance, BLGlyphPlacement* out__, size_t count) blFontGetGlyphAdvances;
    BLResult function(const BLFont* self, BLGlyphId glyphId, const BLMatrix2D* userTransform, BLPath* out__, BLPathSinkFunc sink, void* userData) blFontGetGlyphOutlines;
    BLResult function(const BLFont* self, const BLGlyphRun* glyphRun, const BLMatrix2D* userTransform, BLPath* out__, BLPathSinkFunc sink, void* userData) blFontGetGlyphRunOutlines;
    BLResult function(BLFontFace* self) blFontFaceInit;
    BLResult function(BLFontFace* self, BLFontFace* other) blFontFaceInitMove;
    BLResult function(BLFontFace* self, const(BLFontFace)* other) blFontFaceInitWeak;
    BLResult function(BLFontFace* self) blFontFaceDestroy;
    BLResult function(BLFontFace* self) blFontFaceReset;
    BLResult function(BLFontFace* self, BLFontFace* other) blFontFaceAssignMove;
    BLResult function(BLFontFace* self, const(BLFontFace)* other) blFontFaceAssignWeak;
    bool function(const(BLFontFace)* a, const(BLFontFace)* b) blFontFaceEquals;
    BLResult function(BLFontFace* self, const(char)* fileName, BLFileReadFlags readFlags) blFontFaceCreateFromFile;
    BLResult function(BLFontFace* self, const BLFontData* fontData, uint faceIndex) blFontFaceCreateFromData;
    BLResult function(const(BLFontFace)* self, BLString* out_) blFontFaceGetFullName;
    BLResult function(const(BLFontFace)* self, BLString* out_) blFontFaceGetFamilyName;
    BLResult function(const(BLFontFace)* self, BLString* out_) blFontFaceGetSubfamilyName;
    BLResult function(const(BLFontFace)* self, BLString* out_) blFontFaceGetPostScriptName;
    BLResult function(const(BLFontFace)* self, BLFontFaceInfo* out_) blFontFaceGetFaceInfo;
    BLResult function(const(BLFontFace)* self, BLFontDesignMetrics* out_) blFontFaceGetDesignMetrics;
    BLResult function(const(BLFontFace)* self, BLFontUnicodeCoverage* out_) blFontFaceGetUnicodeCoverage;
    bool function(const(BLFontFace)* self, BLTag scriptTag) blFontFaceHasScriptTag;
    bool function(const(BLFontFace)* self, BLTag featureTag) blFontFaceHasFeatureTag;
    bool function(const(BLFontFace)* self, BLTag variationTag) blFontFaceHasVariationTag;
    BLResult function(const(BLFontFace)* self, BLArray* out_) blFontFaceGetScriptTags;
    BLResult function(const(BLFontFace)* self, BLArray* out_) blFontFaceGetFeatureTags;
    BLResult function(const(BLFontFace)* self, BLArray* out_) blFontFaceGetVariationTags;
    BLResult  function(BLFontManager* self) blFontManagerInit;
    BLResult  function(BLFontManager* self, BLFontManager* other) blFontManagerInitMove;
    BLResult  function(BLFontManager* self, const(BLFontManager)* other) blFontManagerInitWeak;
    BLResult  function(BLFontManager* self) blFontManagerInitNew;
    BLResult  function(BLFontManager* self) blFontManagerDestroy;
    BLResult  function(BLFontManager* self) blFontManagerReset;
    BLResult  function(BLFontManager* self, BLFontManager* other) blFontManagerAssignMove;
    BLResult  function(BLFontManager* self, const(BLFontManager)* other) blFontManagerAssignWeak;
    BLResult  function(BLFontManager* self) blFontManagerCreate;
    size_t  function(const(BLFontManager)* self) blFontManagerGetFaceCount;
    size_t  function(const(BLFontManager)* self) blFontManagerGetFamilyCount;
    bool  function(const(BLFontManager)* self, const(BLFontFace)* face) blFontManagerHasFace;
    BLResult  function(BLFontManager* self, const(BLFontFace)* face) blFontManagerAddFace;
    BLResult  function(const(BLFontManager)* self, const(char)* name, size_t nameSize, const(BLFontQueryProperties)* properties, BLFontFace* out_) blFontManagerQueryFace;
    BLResult  function(const(BLFontManager)* self, const(char)* name, size_t nameSize, BLArray* out_) blFontManagerQueryFacesByFamilyName;
    bool  function(const(BLFontManager)* a, const(BLFontManager)* b) blFontManagerEquals;

}