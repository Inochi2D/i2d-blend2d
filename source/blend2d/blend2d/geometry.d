module blend2d.blend2d.geometry;
import blend2d.blend2d.api;
import blend2d.blend2d.array;
public import inmath;

/// Transformation matrix operation type.
enum BLTransformOp : uint {

    /// Reset matrix to identity (argument ignored, should be nullptr).
    BL_TRANSFORM_OP_RESET = 0,
    /// Assign (copy) the other matrix.
    BL_TRANSFORM_OP_ASSIGN = 1,

    /// Translate the matrix by [x, y].
    BL_TRANSFORM_OP_TRANSLATE = 2,
    /// Scale the matrix by [x, y].
    BL_TRANSFORM_OP_SCALE = 3,
    /// Skew the matrix by [x, y].
    BL_TRANSFORM_OP_SKEW = 4,
    /// Rotate the matrix by the given angle about [0, 0].
    BL_TRANSFORM_OP_ROTATE = 5,
    /// Rotate the matrix by the given angle about [x, y].
    BL_TRANSFORM_OP_ROTATE_PT = 6,
    /// Transform this matrix by other `BLMatrix2D`.
    BL_TRANSFORM_OP_TRANSFORM = 7,

    /// Post-translate the matrix by [x, y].
    BL_TRANSFORM_OP_POST_TRANSLATE = 8,
    /// Post-scale the matrix by [x, y].
    BL_TRANSFORM_OP_POST_SCALE = 9,
    /// Post-skew the matrix by [x, y].
    BL_TRANSFORM_OP_POST_SKEW = 10,
    /// Post-rotate the matrix about [0, 0].
    BL_TRANSFORM_OP_POST_ROTATE = 11,
    /// Post-rotate the matrix about a reference BLPoint.
    BL_TRANSFORM_OP_POST_ROTATE_PT = 12,
    /// Post-transform this matrix by other `BLMatrix2D`.
    BL_TRANSFORM_OP_POST_TRANSFORM = 13,


}

//! Transformation matrix type that can be obtained by calling `BLMatrix2D::type()`.
//!
//! ```
//!  Identity  Transl.  Scale     Swap    Affine
//!   [1  0]   [1  0]   [.  0]   [0  .]   [.  .]
//!   [0  1]   [0  1]   [0  .]   [.  0]   [.  .]
//!   [0  0]   [.  .]   [.  .]   [.  .]   [.  .]
//! ```
enum BLTransformType : uint {

    //! Identity matrix.
    BL_TRANSFORM_TYPE_IDENTITY = 0,
    //! Has translation part (the rest is like identity).
    BL_TRANSFORM_TYPE_TRANSLATE = 1,
    //! Has translation and scaling parts.
    BL_TRANSFORM_TYPE_SCALE = 2,
    //! Has translation and scaling parts, however scaling swaps X/Y.
    BL_TRANSFORM_TYPE_SWAP = 3,
    //! Generic affine matrix.
    BL_TRANSFORM_TYPE_AFFINE = 4,
    //! Invalid/degenerate matrix not useful for transformations.
    BL_TRANSFORM_TYPE_INVALID = 5,
}

/// Direction of a geometry used by geometric primitives and paths.
enum BLGeometryDirection : uint {

    /// No direction specified.
    BL_GEOMETRY_DIRECTION_NONE = 0,
    /// Clockwise direction.
    BL_GEOMETRY_DIRECTION_CW = 1,
    /// Counter-clockwise direction.
    BL_GEOMETRY_DIRECTION_CCW = 2
}

/// Geometry type.
///
/// Geometry describes a shape or path that can be either rendered or added to a BLPath container. Both \ref BLPath
/// and \ref BLContext provide functionality to work with all geometry types. Please note that each type provided
/// here requires to pass a matching struct or class to the function that consumes a `geometryType` and `geometryData`
/// arguments.
enum BLGeometryType : uint {
    
    /// No geometry provided.
    BL_GEOMETRY_TYPE_NONE = 0,
    /// BLBoxI struct.
    BL_GEOMETRY_TYPE_BOXI = 1,
    /// BLBox struct.
    BL_GEOMETRY_TYPE_BOXD = 2,
    /// BLRectI struct.
    BL_GEOMETRY_TYPE_RECTI = 3,
    /// BLRect struct.
    BL_GEOMETRY_TYPE_RECTD = 4,
    /// BLCircle struct.
    BL_GEOMETRY_TYPE_CIRCLE = 5,
    /// BLEllipse struct.
    BL_GEOMETRY_TYPE_ELLIPSE = 6,
    /// BLRoundRect struct.
    BL_GEOMETRY_TYPE_ROUND_RECT = 7,
    /// BLArc struct.
    BL_GEOMETRY_TYPE_ARC = 8,
    /// BLArc struct representing chord.
    BL_GEOMETRY_TYPE_CHORD = 9,
    /// BLArc struct representing pie.
    BL_GEOMETRY_TYPE_PIE = 10,
    /// BLLine struct.
    BL_GEOMETRY_TYPE_LINE = 11,
    /// BLTriangle struct.
    BL_GEOMETRY_TYPE_TRIANGLE = 12,
    /// BLArrayView<BLPointI> representing a polyline.
    BL_GEOMETRY_TYPE_POLYLINEI = 13,
    /// BLArrayView<BLPoint> representing a polyline.
    BL_GEOMETRY_TYPE_POLYLINED = 14,
    /// BLArrayView<BLPointI> representing a polygon.
    BL_GEOMETRY_TYPE_POLYGONI = 15,
    /// BLArrayView<BLPoint> representing a polygon.
    BL_GEOMETRY_TYPE_POLYGOND = 16,
    /// BLArrayView<BLBoxI> struct.
    BL_GEOMETRY_TYPE_ARRAY_VIEW_BOXI = 17,
    /// BLArrayView<BLBox> struct.
    BL_GEOMETRY_TYPE_ARRAY_VIEW_BOXD = 18,
    /// BLArrayView<BLRectI> struct.
    BL_GEOMETRY_TYPE_ARRAY_VIEW_RECTI = 19,
    /// BLArrayView<BLRect> struct.
    BL_GEOMETRY_TYPE_ARRAY_VIEW_RECTD = 20,
    /// BLPath (or BLPathCore).
    BL_GEOMETRY_TYPE_PATH = 21,


}

/// Fill rule.
enum BLFillRule : uint {

    /// Non-zero fill-rule.
    BL_FILL_RULE_NON_ZERO = 0,
    /// Even-odd fill-rule.
    BL_FILL_RULE_EVEN_ODD = 1,


}

/// Hit-test result.
enum BLHitTest : uint {

    /// Fully in.
    BL_HIT_TEST_IN = 0,
    /// Partially in/out.
    BL_HIT_TEST_PART = 1,
    /// Fully out.
    BL_HIT_TEST_OUT = 2,
}

/// Path command.
enum BLPathCmd : uint {

    /// Move-to command (starts a new figure).
    BL_PATH_CMD_MOVE = 0,
    /// On-path command (interpreted as line-to or the end of a curve).
    BL_PATH_CMD_ON = 1,
    /// Quad-to control point.
    BL_PATH_CMD_QUAD = 2,
    /// Conic-to control point
    BL_PATH_CMD_CONIC = 3,
    /// Cubic-to control point (always used as a pair of commands).
    BL_PATH_CMD_CUBIC = 4,
    /// Close path.
    BL_PATH_CMD_CLOSE = 5,

    /// Conic weight.
    ///
    /// \note This is not a point. This is a pair of values from which only the first (x) is used to represent weight
    /// as used by conic curve. The other value (y) is always set to NaN by Blend2D, but can be arbitrary as it has
    /// no meaning.
    BL_PATH_CMD_WEIGHT = 6,


}

/// Path command (never stored in path).
enum BLPathCmdExtra : uint {

    /// Used by `BLPath::setVertexAt` to preserve the current command value.
    BL_PATH_CMD_PRESERVE = 0xFFFFFFFFu
}

/// Path flags.
enum BLPathFlags : uint {
    /// No flags.
    BL_PATH_NO_FLAGS = 0u,
    /// Path is empty (no commands or close commands only).
    BL_PATH_FLAG_EMPTY = 0x00000001u,
    /// Path contains multiple figures.
    BL_PATH_FLAG_MULTIPLE = 0x00000002u,
    /// Path contains one or more quad curves.
    BL_PATH_FLAG_QUADS = 0x00000004u,
    /// Path contains one or more conic curves.
    BL_PATH_FLAG_CONICS = 0x00000008u,
    /// Path contains one or more cubic curves.
    BL_PATH_FLAG_CUBICS = 0x00000010u,
    /// Path is invalid.
    BL_PATH_FLAG_INVALID = 0x40000000u,
    /// Flags are dirty (not reflecting the current status).
    BL_PATH_FLAG_DIRTY = 0x80000000u
}

/// Path reversal mode.
enum BLPathReverseMode : uint {

    /// Reverse each figure and their order as well (default).
    BL_PATH_REVERSE_MODE_COMPLETE = 0,
    /// Reverse each figure separately (keeps their order).
    BL_PATH_REVERSE_MODE_SEPARATE = 1,


}

/// Stroke join type.
enum BLStrokeJoin : uint {

    /// Miter-join possibly clipped at `miterLimit` [default].
    BL_STROKE_JOIN_MITER_CLIP = 0,
    /// Miter-join or bevel-join depending on miterLimit condition.
    BL_STROKE_JOIN_MITER_BEVEL = 1,
    /// Miter-join or round-join depending on miterLimit condition.
    BL_STROKE_JOIN_MITER_ROUND = 2,
    /// Bevel-join.
    BL_STROKE_JOIN_BEVEL = 3,
    /// Round-join.
    BL_STROKE_JOIN_ROUND = 4,


}

enum BLStrokeCapPosition : uint {

    /// Start of the path.
    BL_STROKE_CAP_POSITION_START = 0,
    /// End of the path.
    BL_STROKE_CAP_POSITION_END = 1,


}

/// A presentation attribute defining the shape to be used at the end of open sub-paths.
enum BLStrokeCap : uint {

    /// Butt cap [default].
    BL_STROKE_CAP_BUTT = 0,
    /// Square cap.
    BL_STROKE_CAP_SQUARE = 1,
    /// Round cap.
    BL_STROKE_CAP_ROUND = 2,
    /// Round cap reversed.
    BL_STROKE_CAP_ROUND_REV = 3,
    /// Triangle cap.
    BL_STROKE_CAP_TRIANGLE = 4,
    /// Triangle cap reversed.
    BL_STROKE_CAP_TRIANGLE_REV = 5,


}

/// Stroke transform order.
enum BLStrokeTransformOrder : uint {

    /// Transform after stroke  => `Transform(Stroke(Input))` [default].
    BL_STROKE_TRANSFORM_ORDER_AFTER = 0,
    /// Transform before stroke => `Stroke(Transform(Input))`.
    BL_STROKE_TRANSFORM_ORDER_BEFORE = 1,


}

/// Mode that specifies how curves are approximated to line segments.
enum BLFlattenMode : uint {

    /// Use default mode (decided by Blend2D).
    BL_FLATTEN_MODE_DEFAULT = 0,
    /// Recursive subdivision flattening.
    BL_FLATTEN_MODE_RECURSIVE = 1,


}

/// Mode that specifies how to construct offset curves.
enum BLOffsetMode : uint {

    /// Use default mode (decided by Blend2D).
    BL_OFFSET_MODE_DEFAULT = 0,
    /// Iterative offset construction.
    BL_OFFSET_MODE_ITERATIVE = 1,


}

/// Options used to describe how geometry is approximated.
///
/// This struct cannot be simply zeroed and then passed to functions that accept approximation options.
/// Use `blDefaultApproximationOptions` to setup defaults and then alter values you want to change.
///
/// Example of using `BLApproximationOptions`:
///
/// ```
/// // Initialize with defaults first.
/// BLApproximationOptions approx = blDefaultApproximationOptions;
///
/// // Override values you want to change.
/// approx.simplifyTolerance = 0.02;
///
/// // ... now safely use approximation options in your code ...
/// ```
struct BLApproximationOptions {
  /// Specifies how curves are flattened, see `FlattenMode`.
  ubyte flattenMode;
  /// Specifies how curves are offsetted (used by stroking), see `BLOffsetMode`.
  ubyte offsetMode;
  /// Reserved for future use, must be zero.
  ubyte[6] reservedFlags;

  /// Tolerance used to flatten curves.
  double flattenTolerance;
  /// Tolerance used to approximate cubic curves with quadratic curves.
  double simplifyTolerance;
  /// Curve offsetting parameter, exact meaning depends on `offsetMode`.
  double offsetParameter;
}

/// 2D vector path view provides pointers to vertex and command data along with their size.
struct BLPathView {
nothrow @nogc:
    const(ubyte)* commandData;
    const(BLPoint)* vertexData;
    size_t size;

    /// Resets the BLPathView
    pragma(inline, true)
    void reset() nothrow { this = typeof(this).init; }

    /// Resets the BLPathView
    pragma(inline, true)
    void reset(const(ubyte)* commandDataIn, const(BLPoint)* vertexDataIn, size_t sizeIn) nothrow { 
        commandData = commandDataIn;
        vertexData = vertexDataIn;
        size = sizeIn;
    }
}

// Double size
struct BLSizeI {
    int w;
    int h;
}

// Int size
struct BLSize {
    double w;
    double h;
}

// Double box
struct BLBoxI {
    int x0;
    int y0;
    int x1;
    int y1;
}

// Int box
struct BLBox {
    double x0;
    double y0;
    double x1;
    double y1;
}

// Int rect
alias BLRectI = Rect!int;

// Double rect
alias BLRect = Rect!double;

// Int rect
alias BLPointI = Vector!(int, 2);

// Double rect
alias BLPoint = Vector!(double, 2);

// 2x3 matrix
alias BLMatrix2D = Matrix!(double, 2, 3);


/// Optional callback that can be used to consume a path data.
alias BLPathSinkFunc = extern(C) BLResult function(BLPath* path, const void* info, void* userData) nothrow @nogc;

/// This is a sink that is used by path offsetting. This sink consumes both `a` and `b` offsets of the path. The sink
/// will be called for each figure and is responsible for joining these paths. If the paths are not closed then the
/// sink must insert start cap, then join `b`, and then insert end cap.
///
/// The sink must also clean up the paths as this is not done by the offsetter. The reason is that in case the `a` path
/// is the output path you can just keep it and insert `b` path into it (clearing only `b` path after each call).
alias BLPathStrokeSinkFunc = extern(C) BLResult function(BLPath* a, BLPath* b, BLPath* c, size_t inputStart, size_t inputEnd, void* userData) nothrow @nogc;

/// 2D vector path [C API].
struct BLPath {
    mixin BLExtends!BLObject;
    
    //! Union of either raw path-data or their `view`.
    union {
        struct {

            //! Command data
            ubyte* commandData;
            //! Vertex data.
            BLPoint* vertexData;
            //! Vertex/command count.
            size_t size;
        }

        //! Path data as view.
        BLPathView view;
    }

    //! Path vertex/command capacity.
    size_t capacity;

    //! Path flags related to caching.
    uint flags;
}

/// Stroke options [C API].
struct BLStrokeOptions {
    mixin BLExtends!BLObject;

    union {
        struct {
            ubyte startCap;
            ubyte endCap;
            ubyte join;
            ubyte transformOrder;
            ubyte[4] reserved;

            ulong hints;
        }

        double width;
        double miterLimit;
        double dashOffset;
        BLArray dashArray;
    }
}

version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blPathInit(BLPath* self);
    BLResult blPathInitMove(BLPath* self, BLPath* other);
    BLResult blPathInitWeak(BLPath* self, const(BLPath)* other);
    BLResult blPathDestroy(BLPath* self);
    BLResult blPathReset(BLPath* self);
    size_t blPathGetSize(const(BLPath)* self) pure;
    size_t blPathGetCapacity(const(BLPath)* self) pure;
    const(ubyte)* blPathGetCommandData(const(BLPath)* self) pure;
    const(BLPoint)* blPathGetVertexData(const(BLPath)* self) pure;
    BLResult blPathClear(BLPath* self);
    BLResult blPathShrink(BLPath* self);
    BLResult blPathReserve(BLPath* self, size_t n);
    BLResult blPathModifyOp(BLPath* self, BLModifyOp op, size_t n, ubyte** cmdDataOut, BLPoint** vtxDataOut);
    BLResult blPathAssignMove(BLPath* self, BLPath* other);
    BLResult blPathAssignWeak(BLPath* self, const(BLPath)* other);
    BLResult blPathAssignDeep(BLPath* self, const(BLPath)* other);
    BLResult blPathSetVertexAt(BLPath* self, size_t index, uint cmd, double x, double y);
    BLResult blPathMoveTo(BLPath* self, double x0, double y0);
    BLResult blPathLineTo(BLPath* self, double x1, double y1);
    BLResult blPathPolyTo(BLPath* self, const(BLPoint)* poly, size_t count);
    BLResult blPathQuadTo(BLPath* self, double x1, double y1, double x2, double y2);
    BLResult blPathConicTo(BLPath* self, double x1, double y1, double x2, double y2, double w);
    BLResult blPathCubicTo(BLPath* self, double x1, double y1, double x2, double y2, double x3, double y3);
    BLResult blPathSmoothQuadTo(BLPath* self, double x2, double y2);
    BLResult blPathSmoothCubicTo(BLPath* self, double x2, double y2, double x3, double y3);
    BLResult blPathArcTo(BLPath* self, double x, double y, double rx, double ry, double start, double sweep, bool forceMoveTo);
    BLResult blPathArcQuadrantTo(BLPath* self, double x1, double y1, double x2, double y2);
    BLResult blPathEllipticArcTo(BLPath* self, double rx, double ry, double xAxisRotation, bool largeArcFlag, bool sweepFlag, double x1, double y1);
    BLResult blPathClose(BLPath* self);
    BLResult blPathAddGeometry(BLPath* self, BLGeometryType geometryType, const void* geometryData, const BLMatrix2D* m, BLGeometryDirection dir);
    BLResult blPathAddBoxI(BLPath* self, const(BLBoxI)* box, BLGeometryDirection dir);
    BLResult blPathAddBoxD(BLPath* self, const(BLBox)* box, BLGeometryDirection dir);
    BLResult blPathAddRectI(BLPath* self, const(BLRectI)* rect, BLGeometryDirection dir);
    BLResult blPathAddRectD(BLPath* self, const(BLRect)* rect, BLGeometryDirection dir);
    BLResult blPathAddPath(BLPath* self, const(BLPath)* other, const(BLRange)* range);
    BLResult blPathAddTranslatedPath(BLPath* self, const(BLPath)* other, const(BLRange)* range, const(BLPoint)* p);
    BLResult blPathAddTransformedPath(BLPath* self, const(BLPath)* other, const(BLRange)* range, const BLMatrix2D* m);
    BLResult blPathAddReversedPath(BLPath* self, const(BLPath)* other, const(BLRange)* range, BLPathReverseMode reverseMode);
    BLResult blPathAddStrokedPath(BLPath* self, const(BLPath)* other, const(BLRange)* range, const(BLStrokeOptions)* options, const(BLApproximationOptions)* approx);
    BLResult blPathRemoveRange(BLPath* self, const(BLRange)* range);
    BLResult blPathTranslate(BLPath* self, const(BLRange)* range, const(BLPoint)* p);
    BLResult blPathTransform(BLPath* self, const(BLRange)* range, const BLMatrix2D* m);
    BLResult blPathFitTo(BLPath* self, const(BLRange)* range, const(BLRect)* rect, uint fitFlags);
    bool     blPathEquals(const(BLPath)* a, const(BLPath)* b);
    BLResult blPathGetInfoFlags(const(BLPath)* self, uint* flagsOut);
    BLResult blPathGetControlBox(const(BLPath)* self, BLBox* boxOut);
    BLResult blPathGetBoundingBox(const(BLPath)* self, BLBox* boxOut);
    BLResult blPathGetFigureRange(const(BLPath)* self, size_t index, BLRange* rangeOut);
    BLResult blPathGetLastVertex(const(BLPath)* self, BLPoint* vtxOut);
    BLResult blPathGetClosestVertex(const(BLPath)* self, const(BLPoint)* p, double maxDistance, size_t* indexOut, double* distanceOut);
    BLHitTest blPathHitTest(const(BLPath)* self, const(BLPoint)* p, BLFillRule fillRule);

    BLResult blStrokeOptionsInit(BLStrokeOptions* self);
    BLResult blStrokeOptionsInitMove(BLStrokeOptions* self, BLStrokeOptions* other);
    BLResult blStrokeOptionsInitWeak(BLStrokeOptions* self, const(BLStrokeOptions)* other);
    BLResult blStrokeOptionsDestroy(BLStrokeOptions* self);
    BLResult blStrokeOptionsReset(BLStrokeOptions* self);
    bool blStrokeOptionsEquals(const(BLStrokeOptions)* a, const(BLStrokeOptions)* b);
    BLResult blStrokeOptionsAssignMove(BLStrokeOptions* self, BLStrokeOptions* other);
    BLResult blStrokeOptionsAssignWeak(BLStrokeOptions* self, const(BLStrokeOptions)* other);

    BLResult blPathStrokeToSink(
        const(BLPath)* self,
        const(BLRange)* range,
        const(BLStrokeOptions)* strokeOptions,
        const(BLApproximationOptions)* approximationOptions,
        BLPathCore *a,
        BLPathCore *b,
        BLPathCore *c,
        BLPathStrokeSinkFunc sink, 
        void* userData
    );

} else {
nothrow @nogc extern(C):

    BLResult function(BLPath* self) blPathInit;
    BLResult function(BLPath* self, BLPath* other) blPathInitMove;
    BLResult function(BLPath* self, const(BLPath)* other) blPathInitWeak;
    BLResult function(BLPath* self) blPathDestroy;
    BLResult function(BLPath* self) blPathReset;
    size_t function(const(BLPath)* self) pure blPathGetSize;
    size_t function(const(BLPath)* self) pure blPathGetCapacity;
    const(ubyte)* function(const(BLPath)* self) pure blPathGetCommandData;
    const(BLPoint)* function(const(BLPath)* self) pure blPathGetVertexData;
    BLResult function(BLPath* self) blPathClear;
    BLResult function(BLPath* self) blPathShrink;
    BLResult function(BLPath* self, size_t n) blPathReserve;
    BLResult function(BLPath* self, BLModifyOp op, size_t n, ubyte** cmdDataOut, BLPoint** vtxDataOut) blPathModifyOp;
    BLResult function(BLPath* self, BLPath* other) blPathAssignMove;
    BLResult function(BLPath* self, const(BLPath)* other) blPathAssignWeak;
    BLResult function(BLPath* self, const(BLPath)* other) blPathAssignDeep;
    BLResult function(BLPath* self, size_t index, uint cmd, double x, double y) blPathSetVertexAt;
    BLResult function(BLPath* self, double x0, double y0) blPathMoveTo;
    BLResult function(BLPath* self, double x1, double y1) blPathLineTo;
    BLResult function(BLPath* self, const(BLPoint)* poly, size_t count) blPathPolyTo;
    BLResult function(BLPath* self, double x1, double y1, double x2, double y2) blPathQuadTo;
    BLResult function(BLPath* self, double x1, double y1, double x2, double y2, double w) blPathConicTo;
    BLResult function(BLPath* self, double x1, double y1, double x2, double y2, double x3, double y3) blPathCubicTo;
    BLResult function(BLPath* self, double x2, double y2) blPathSmoothQuadTo;
    BLResult function(BLPath* self, double x2, double y2, double x3, double y3) blPathSmoothCubicTo;
    BLResult function(BLPath* self, double x, double y, double rx, double ry, double start, double sweep, bool forceMoveTo) blPathArcTo;
    BLResult function(BLPath* self, double x1, double y1, double x2, double y2) blPathArcQuadrantTo;
    BLResult function(BLPath* self, double rx, double ry, double xAxisRotation, bool largeArcFlag, bool sweepFlag, double x1, double y1) blPathEllipticArcTo;
    BLResult function(BLPath* self) blPathClose;
    BLResult function(BLPath* self, BLGeometryType geometryType, const void* geometryData, const BLMatrix2D* m, BLGeometryDirection dir) blPathAddGeometry;
    BLResult function(BLPath* self, const(BLBoxI)* box, BLGeometryDirection dir) blPathAddBoxI;
    BLResult function(BLPath* self, const(BLBox)* box, BLGeometryDirection dir) blPathAddBoxD;
    BLResult function(BLPath* self, const(BLRectI)* rect, BLGeometryDirection dir) blPathAddRectI;
    BLResult function(BLPath* self, const(BLRect)* rect, BLGeometryDirection dir) blPathAddRectD;
    BLResult function(BLPath* self, const(BLPath)* other, const(BLRange)* range) blPathAddPath;
    BLResult function(BLPath* self, const(BLPath)* other, const(BLRange)* range, const(BLPoint)* p) blPathAddTranslatedPath;
    BLResult function(BLPath* self, const(BLPath)* other, const(BLRange)* range, const BLMatrix2D* m) blPathAddTransformedPath;
    BLResult function(BLPath* self, const(BLPath)* other, const(BLRange)* range, BLPathReverseMode reverseMode) blPathAddReversedPath;
    BLResult function(BLPath* self, const(BLPath)* other, const(BLRange)* range, const(BLStrokeOptions)* options, const(BLApproximationOptions)* approx) blPathAddStrokedPath;
    BLResult function(BLPath* self, const(BLRange)* range) blPathRemoveRange;
    BLResult function(BLPath* self, const(BLRange)* range, const(BLPoint)* p) blPathTranslate;
    BLResult function(BLPath* self, const(BLRange)* range, const BLMatrix2D* m) blPathTransform;
    BLResult function(BLPath* self, const(BLRange)* range, const(BLRect)* rect, uint fitFlags) blPathFitTo;
    bool     function(const(BLPath)* a, const(BLPath)* b) blPathEquals;
    BLResult function(const(BLPath)* self, uint* flagsOut) blPathGetInfoFlags;
    BLResult function(const(BLPath)* self, BLBox* boxOut) blPathGetControlBox;
    BLResult function(const(BLPath)* self, BLBox* boxOut) blPathGetBoundingBox;
    BLResult function(const(BLPath)* self, size_t index, BLRange* rangeOut) blPathGetFigureRange;
    BLResult function(const(BLPath)* self, BLPoint* vtxOut) blPathGetLastVertex;
    BLResult function(const(BLPath)* self, const(BLPoint)* p, double maxDistance, size_t* indexOut, double* distanceOut) blPathGetClosestVertex;
    BLHitTest function(const(BLPath)* self, const(BLPoint)* p, BLFillRule fillRule) blPathHitTest;
    BLResult function(BLStrokeOptions* self) blStrokeOptionsInit;
    BLResult function(BLStrokeOptions* self, BLStrokeOptions* other) blStrokeOptionsInitMove;
    BLResult function(BLStrokeOptions* self, const(BLStrokeOptions)* other) blStrokeOptionsInitWeak;
    BLResult function(BLStrokeOptions* self) blStrokeOptionsDestroy;
    BLResult function(BLStrokeOptions* self) blStrokeOptionsReset;
    bool function(const(BLStrokeOptions)* a, const(BLStrokeOptions)* b) blStrokeOptionsEquals;
    BLResult function(BLStrokeOptions* self, BLStrokeOptions* other) blStrokeOptionsAssignMove;
    BLResult function(BLStrokeOptions* self, const(BLStrokeOptions)* other) blStrokeOptionsAssignWeak;

    BLResult function(
        const(BLPath)* self,
        const(BLRange)* range,
        const(BLStrokeOptions)* strokeOptions,
        const(BLApproximationOptions)* approximationOptions,
        BLPath* a,
        BLPath* b,
        BLPath* c,
        BLPathStrokeSinkFunc sink, 
        void* userData
    ) blPathStrokeToSink;
}