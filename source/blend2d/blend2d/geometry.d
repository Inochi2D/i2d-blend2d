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
alias BLPathSinkFunc = extern(C) BLResult function(BLPathCore* path, const void* info, void* userData) nothrow @nogc;

/// This is a sink that is used by path offsetting. This sink consumes both `a` and `b` offsets of the path. The sink
/// will be called for each figure and is responsible for joining these paths. If the paths are not closed then the
/// sink must insert start cap, then join `b`, and then insert end cap.
///
/// The sink must also clean up the paths as this is not done by the offsetter. The reason is that in case the `a` path
/// is the output path you can just keep it and insert `b` path into it (clearing only `b` path after each call).
alias BLPathStrokeSinkFunc = extern(C) BLResult function(BLPathCore* a, BLPathCore* b, BLPathCore* c, size_t inputStart, size_t inputEnd, void* userData) nothrow @nogc;

/// 2D vector path [C API].
struct BLPathCore {
    
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
struct BLStrokeOptionsCore {
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
        BLArrayCore dashArray;
    }
}

version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blPathInit(BLPathCore* self);
    BLResult blPathInitMove(BLPathCore* self, BLPathCore* other);
    BLResult blPathInitWeak(BLPathCore* self, const(BLPathCore)* other);
    BLResult blPathDestroy(BLPathCore* self);
    BLResult blPathReset(BLPathCore* self);
    size_t blPathGetSize(const(BLPathCore)* self) pure;
    size_t blPathGetCapacity(const(BLPathCore)* self) pure;
    const(ubyte)* blPathGetCommandData(const(BLPathCore)* self) pure;
    const(BLPoint)* blPathGetVertexData(const(BLPathCore)* self) pure;
    BLResult blPathClear(BLPathCore* self);
    BLResult blPathShrink(BLPathCore* self);
    BLResult blPathReserve(BLPathCore* self, size_t n);
    BLResult blPathModifyOp(BLPathCore* self, BLModifyOp op, size_t n, ubyte** cmdDataOut, BLPoint** vtxDataOut);
    BLResult blPathAssignMove(BLPathCore* self, BLPathCore* other);
    BLResult blPathAssignWeak(BLPathCore* self, const(BLPathCore)* other);
    BLResult blPathAssignDeep(BLPathCore* self, const(BLPathCore)* other);
    BLResult blPathSetVertexAt(BLPathCore* self, size_t index, uint cmd, double x, double y);
    BLResult blPathMoveTo(BLPathCore* self, double x0, double y0);
    BLResult blPathLineTo(BLPathCore* self, double x1, double y1);
    BLResult blPathPolyTo(BLPathCore* self, const(BLPoint)* poly, size_t count);
    BLResult blPathQuadTo(BLPathCore* self, double x1, double y1, double x2, double y2);
    BLResult blPathConicTo(BLPathCore* self, double x1, double y1, double x2, double y2, double w);
    BLResult blPathCubicTo(BLPathCore* self, double x1, double y1, double x2, double y2, double x3, double y3);
    BLResult blPathSmoothQuadTo(BLPathCore* self, double x2, double y2);
    BLResult blPathSmoothCubicTo(BLPathCore* self, double x2, double y2, double x3, double y3);
    BLResult blPathArcTo(BLPathCore* self, double x, double y, double rx, double ry, double start, double sweep, bool forceMoveTo);
    BLResult blPathArcQuadrantTo(BLPathCore* self, double x1, double y1, double x2, double y2);
    BLResult blPathEllipticArcTo(BLPathCore* self, double rx, double ry, double xAxisRotation, bool largeArcFlag, bool sweepFlag, double x1, double y1);
    BLResult blPathClose(BLPathCore* self);
    BLResult blPathAddGeometry(BLPathCore* self, BLGeometryType geometryType, const void* geometryData, const BLMatrix2D* m, BLGeometryDirection dir);
    BLResult blPathAddBoxI(BLPathCore* self, const(BLBoxI)* box, BLGeometryDirection dir);
    BLResult blPathAddBoxD(BLPathCore* self, const(BLBox)* box, BLGeometryDirection dir);
    BLResult blPathAddRectI(BLPathCore* self, const(BLRectI)* rect, BLGeometryDirection dir);
    BLResult blPathAddRectD(BLPathCore* self, const(BLRect)* rect, BLGeometryDirection dir);
    BLResult blPathAddPath(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range);
    BLResult blPathAddTranslatedPath(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range, const(BLPoint)* p);
    BLResult blPathAddTransformedPath(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range, const BLMatrix2D* m);
    BLResult blPathAddReversedPath(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range, BLPathReverseMode reverseMode);
    BLResult blPathAddStrokedPath(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range, const(BLStrokeOptionsCore)* options, const(BLApproximationOptions)* approx);
    BLResult blPathRemoveRange(BLPathCore* self, const(BLRange)* range);
    BLResult blPathTranslate(BLPathCore* self, const(BLRange)* range, const(BLPoint)* p);
    BLResult blPathTransform(BLPathCore* self, const(BLRange)* range, const BLMatrix2D* m);
    BLResult blPathFitTo(BLPathCore* self, const(BLRange)* range, const(BLRect)* rect, uint fitFlags);
    bool     blPathEquals(const(BLPathCore)* a, const(BLPathCore)* b);
    BLResult blPathGetInfoFlags(const(BLPathCore)* self, uint* flagsOut);
    BLResult blPathGetControlBox(const(BLPathCore)* self, BLBox* boxOut);
    BLResult blPathGetBoundingBox(const(BLPathCore)* self, BLBox* boxOut);
    BLResult blPathGetFigureRange(const(BLPathCore)* self, size_t index, BLRange* rangeOut);
    BLResult blPathGetLastVertex(const(BLPathCore)* self, BLPoint* vtxOut);
    BLResult blPathGetClosestVertex(const(BLPathCore)* self, const(BLPoint)* p, double maxDistance, size_t* indexOut, double* distanceOut);
    BLHitTest blPathHitTest(const(BLPathCore)* self, const(BLPoint)* p, BLFillRule fillRule);

    BLResult blStrokeOptionsInit(BLStrokeOptionsCore* self);
    BLResult blStrokeOptionsInitMove(BLStrokeOptionsCore* self, BLStrokeOptionsCore* other);
    BLResult blStrokeOptionsInitWeak(BLStrokeOptionsCore* self, const(BLStrokeOptionsCore)* other);
    BLResult blStrokeOptionsDestroy(BLStrokeOptionsCore* self);
    BLResult blStrokeOptionsReset(BLStrokeOptionsCore* self);
    bool blStrokeOptionsEquals(const(BLStrokeOptionsCore)* a, const(BLStrokeOptionsCore)* b);
    BLResult blStrokeOptionsAssignMove(BLStrokeOptionsCore* self, BLStrokeOptionsCore* other);
    BLResult blStrokeOptionsAssignWeak(BLStrokeOptionsCore* self, const(BLStrokeOptionsCore)* other);

    BLResult blPathStrokeToSink(
        const(BLPathCore)* self,
        const(BLRange)* range,
        const(BLStrokeOptionsCore)* strokeOptions,
        const(BLApproximationOptions)* approximationOptions,
        BLPathCore *a,
        BLPathCore *b,
        BLPathCore *c,
        BLPathStrokeSinkFunc sink, 
        void* userData
    );

} else {
nothrow @nogc extern(C):

    BLResult function(BLPathCore* self) blPathInit;
    BLResult function(BLPathCore* self, BLPathCore* other) blPathInitMove;
    BLResult function(BLPathCore* self, const(BLPathCore)* other) blPathInitWeak;
    BLResult function(BLPathCore* self) blPathDestroy;
    BLResult function(BLPathCore* self) blPathReset;
    size_t function(const(BLPathCore)* self) pure blPathGetSize;
    size_t function(const(BLPathCore)* self) pure blPathGetCapacity;
    const(ubyte)* function(const(BLPathCore)* self) pure blPathGetCommandData;
    const(BLPoint)* function(const(BLPathCore)* self) pure blPathGetVertexData;
    BLResult function(BLPathCore* self) blPathClear;
    BLResult function(BLPathCore* self) blPathShrink;
    BLResult function(BLPathCore* self, size_t n) blPathReserve;
    BLResult function(BLPathCore* self, BLModifyOp op, size_t n, ubyte** cmdDataOut, BLPoint** vtxDataOut) blPathModifyOp;
    BLResult function(BLPathCore* self, BLPathCore* other) blPathAssignMove;
    BLResult function(BLPathCore* self, const(BLPathCore)* other) blPathAssignWeak;
    BLResult function(BLPathCore* self, const(BLPathCore)* other) blPathAssignDeep;
    BLResult function(BLPathCore* self, size_t index, uint cmd, double x, double y) blPathSetVertexAt;
    BLResult function(BLPathCore* self, double x0, double y0) blPathMoveTo;
    BLResult function(BLPathCore* self, double x1, double y1) blPathLineTo;
    BLResult function(BLPathCore* self, const(BLPoint)* poly, size_t count) blPathPolyTo;
    BLResult function(BLPathCore* self, double x1, double y1, double x2, double y2) blPathQuadTo;
    BLResult function(BLPathCore* self, double x1, double y1, double x2, double y2, double w) blPathConicTo;
    BLResult function(BLPathCore* self, double x1, double y1, double x2, double y2, double x3, double y3) blPathCubicTo;
    BLResult function(BLPathCore* self, double x2, double y2) blPathSmoothQuadTo;
    BLResult function(BLPathCore* self, double x2, double y2, double x3, double y3) blPathSmoothCubicTo;
    BLResult function(BLPathCore* self, double x, double y, double rx, double ry, double start, double sweep, bool forceMoveTo) blPathArcTo;
    BLResult function(BLPathCore* self, double x1, double y1, double x2, double y2) blPathArcQuadrantTo;
    BLResult function(BLPathCore* self, double rx, double ry, double xAxisRotation, bool largeArcFlag, bool sweepFlag, double x1, double y1) blPathEllipticArcTo;
    BLResult function(BLPathCore* self) blPathClose;
    BLResult function(BLPathCore* self, BLGeometryType geometryType, const void* geometryData, const BLMatrix2D* m, BLGeometryDirection dir) blPathAddGeometry;
    BLResult function(BLPathCore* self, const(BLBoxI)* box, BLGeometryDirection dir) blPathAddBoxI;
    BLResult function(BLPathCore* self, const(BLBox)* box, BLGeometryDirection dir) blPathAddBoxD;
    BLResult function(BLPathCore* self, const(BLRectI)* rect, BLGeometryDirection dir) blPathAddRectI;
    BLResult function(BLPathCore* self, const(BLRect)* rect, BLGeometryDirection dir) blPathAddRectD;
    BLResult function(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range) blPathAddPath;
    BLResult function(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range, const(BLPoint)* p) blPathAddTranslatedPath;
    BLResult function(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range, const BLMatrix2D* m) blPathAddTransformedPath;
    BLResult function(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range, BLPathReverseMode reverseMode) blPathAddReversedPath;
    BLResult function(BLPathCore* self, const(BLPathCore)* other, const(BLRange)* range, const(BLStrokeOptionsCore)* options, const(BLApproximationOptions)* approx) blPathAddStrokedPath;
    BLResult function(BLPathCore* self, const(BLRange)* range) blPathRemoveRange;
    BLResult function(BLPathCore* self, const(BLRange)* range, const(BLPoint)* p) blPathTranslate;
    BLResult function(BLPathCore* self, const(BLRange)* range, const BLMatrix2D* m) blPathTransform;
    BLResult function(BLPathCore* self, const(BLRange)* range, const(BLRect)* rect, uint fitFlags) blPathFitTo;
    bool     function(const(BLPathCore)* a, const(BLPathCore)* b) blPathEquals;
    BLResult function(const(BLPathCore)* self, uint* flagsOut) blPathGetInfoFlags;
    BLResult function(const(BLPathCore)* self, BLBox* boxOut) blPathGetControlBox;
    BLResult function(const(BLPathCore)* self, BLBox* boxOut) blPathGetBoundingBox;
    BLResult function(const(BLPathCore)* self, size_t index, BLRange* rangeOut) blPathGetFigureRange;
    BLResult function(const(BLPathCore)* self, BLPoint* vtxOut) blPathGetLastVertex;
    BLResult function(const(BLPathCore)* self, const(BLPoint)* p, double maxDistance, size_t* indexOut, double* distanceOut) blPathGetClosestVertex;
    BLHitTest function(const(BLPathCore)* self, const(BLPoint)* p, BLFillRule fillRule) blPathHitTest;
    BLResult function(BLStrokeOptionsCore* self) blStrokeOptionsInit;
    BLResult function(BLStrokeOptionsCore* self, BLStrokeOptionsCore* other) blStrokeOptionsInitMove;
    BLResult function(BLStrokeOptionsCore* self, const(BLStrokeOptionsCore)* other) blStrokeOptionsInitWeak;
    BLResult function(BLStrokeOptionsCore* self) blStrokeOptionsDestroy;
    BLResult function(BLStrokeOptionsCore* self) blStrokeOptionsReset;
    bool function(const(BLStrokeOptionsCore)* a, const(BLStrokeOptionsCore)* b) blStrokeOptionsEquals;
    BLResult function(BLStrokeOptionsCore* self, BLStrokeOptionsCore* other) blStrokeOptionsAssignMove;
    BLResult function(BLStrokeOptionsCore* self, const(BLStrokeOptionsCore)* other) blStrokeOptionsAssignWeak;

    BLResult function(
        const(BLPathCore)* self,
        const(BLRange)* range,
        const(BLStrokeOptionsCore)* strokeOptions,
        const(BLApproximationOptions)* approximationOptions,
        BLPathCore *a,
        BLPathCore *b,
        BLPathCore *c,
        BLPathStrokeSinkFunc sink, 
        void* userData
    ) blPathStrokeToSink;
}