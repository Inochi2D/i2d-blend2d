module blend2d.blend2d.array;
import blend2d.blend2d.api;

/// \name BLArray - C API
///
/// Array functionality is provided by \ref BLArrayCore in C API and wrapped by \ref BLArray<T> template in C++ API.
///
/// C API users must call either generic functions with `Item` suffix or correct specialized functions in case
/// of typed arrays. For example if you create a `BLArray<uint>` in C then you can only modify it through
/// functions that have either `U32` or `Item` suffix. Arrays of signed types are treated as arrays of unsigned
/// types at API level as there is no difference between them from an implementation perspective.
///
/// \{
struct BLArrayCore {

    /// Pointer to array data.
    void* data;
    /// Array size [in items].
    size_t size;
    /// Array capacity [in items].
    size_t capacity;
}

/// BitArray container [C API].
struct BLBitArrayCore;

/// BitSet container [C API].
struct BLBitSetCore;

version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blBitArrayInit(BLBitArrayCore* self);
    BLResult blBitArrayInitMove(BLBitArrayCore* self, BLBitArrayCore* other);
    BLResult blBitArrayInitWeak(BLBitArrayCore* self, const(BLBitArrayCore)* other);
    BLResult blBitArrayDestroy(BLBitArrayCore* self);
    BLResult blBitArrayReset(BLBitArrayCore* self);
    BLResult blBitArrayAssignMove(BLBitArrayCore* self, BLBitArrayCore* other);
    BLResult blBitArrayAssignWeak(BLBitArrayCore* self, const(BLBitArrayCore)* other);
    BLResult blBitArrayAssignWords(BLBitArrayCore* self, const(uint)* wordData, uint wordCount);
    bool blBitArrayIsEmpty(const(BLBitArrayCore)* self);
    uint blBitArrayGetSize(const(BLBitArrayCore)* self);
    uint blBitArrayGetWordCount(const(BLBitArrayCore)* self);
    uint blBitArrayGetCapacity(const(BLBitArrayCore)* self);
    const(uint)* blBitArrayGetData(const(BLBitArrayCore)* self);
    uint blBitArrayGetCardinality(const(BLBitArrayCore)* self);
    uint blBitArrayGetCardinalityInRange(const(BLBitArrayCore)* self, uint startBit, uint endBit);
    bool blBitArrayHasBit(const(BLBitArrayCore)* self, uint bitIndex);
    bool blBitArrayHasBitsInRange(const(BLBitArrayCore)* self, uint startBit, uint endBit);
    bool blBitArraySubsumes(const(BLBitArrayCore)* a, const(BLBitArrayCore)* b);
    bool blBitArrayIntersects(const(BLBitArrayCore)* a, const(BLBitArrayCore)* b);
    bool blBitArrayGetRange(const(BLBitArrayCore)* self, uint* startOut, uint* endOut);
    bool blBitArrayEquals(const(BLBitArrayCore)* a, const(BLBitArrayCore)* b);
    int blBitArrayCompare(const(BLBitArrayCore)* a, const(BLBitArrayCore)* b);
    BLResult blBitArrayClear(BLBitArrayCore* self);
    BLResult blBitArrayResize(BLBitArrayCore* self, uint nBits);
    BLResult blBitArrayReserve(BLBitArrayCore* self, uint nBits);
    BLResult blBitArrayShrink(BLBitArrayCore* self);
    BLResult blBitArraySetBit(BLBitArrayCore* self, uint bitIndex);
    BLResult blBitArrayFillRange(BLBitArrayCore* self, uint startBit, uint endBit);
    BLResult blBitArrayFillWords(BLBitArrayCore* self, uint bitIndex, const(uint)* wordData, uint wordCount);
    BLResult blBitArrayClearBit(BLBitArrayCore* self, uint bitIndex);
    BLResult blBitArrayClearRange(BLBitArrayCore* self, uint startBit, uint endBit);
    BLResult blBitArrayClearWord(BLBitArrayCore* self, uint bitIndex, uint wordValue);
    BLResult blBitArrayClearWords(BLBitArrayCore* self, uint bitIndex, const(uint)* wordData, uint wordCount);
    BLResult blBitArrayReplaceOp(BLBitArrayCore* self, uint nBits, uint** dataOut);
    BLResult blBitArrayReplaceBit(BLBitArrayCore* self, uint bitIndex, bool bitValue);
    BLResult blBitArrayReplaceWord(BLBitArrayCore* self, uint bitIndex, uint wordValue);
    BLResult blBitArrayReplaceWords(BLBitArrayCore* self, uint bitIndex, const(uint)* wordData, uint wordCount);
    BLResult blBitArrayAppendBit(BLBitArrayCore* self, bool bitValue);
    BLResult blBitArrayAppendWord(BLBitArrayCore* self, uint wordValue);
    BLResult blBitArrayAppendWords(BLBitArrayCore* self, const(uint)* wordData, uint wordCount);

    BLResult blArrayInit(BLArrayCore* self, BLObjectType arrayType);
    BLResult blArrayInitMove(BLArrayCore* self, BLArrayCore* other);
    BLResult blArrayInitWeak(BLArrayCore* self, const(BLArrayCore)* other);
    BLResult blArrayDestroy(BLArrayCore* self);

    BLResult blArrayReset(BLArrayCore* self);

    size_t blArrayGetSize(const(BLArrayCore)* self) pure;
    size_t blArrayGetCapacity(const(BLArrayCore)* self) pure;
    size_t blArrayGetItemSize(BLArrayCore* self) pure;
    const(void)* blArrayGetData(const(BLArrayCore)* self) pure;

    BLResult blArrayClear(BLArrayCore* self);
    BLResult blArrayShrink(BLArrayCore* self);
    BLResult blArrayReserve(BLArrayCore* self, size_t n);
    BLResult blArrayResize(BLArrayCore* self, size_t n, const(void)* fill);

    BLResult blArrayMakeMutable(BLArrayCore* self, void** dataOut);
    BLResult blArrayModifyOp(BLArrayCore* self, BLModifyOp op, size_t n, void** dataOut);
    BLResult blArrayInsertOp(BLArrayCore* self, size_t index, size_t n, void** dataOut);

    BLResult blArrayAssignMove(BLArrayCore* self, BLArrayCore* other);
    BLResult blArrayAssignWeak(BLArrayCore* self, const(BLArrayCore)* other);
    BLResult blArrayAssignDeep(BLArrayCore* self, const(BLArrayCore)* other);
    BLResult blArrayAssignData(BLArrayCore* self, const(void)* data, size_t n);
    BLResult blArrayAssignExternalData(BLArrayCore* self, void* data, size_t size, size_t capacity, BLDataAccessFlags dataAccessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData);

    BLResult blArrayAppendU8(BLArrayCore* self, ubyte value);
    BLResult blArrayAppendU16(BLArrayCore* self, ushort value);
    BLResult blArrayAppendU32(BLArrayCore* self, uint value);
    BLResult blArrayAppendU64(BLArrayCore* self, ulong value);
    BLResult blArrayAppendF32(BLArrayCore* self, float value);
    BLResult blArrayAppendF64(BLArrayCore* self, double value);
    BLResult blArrayAppendItem(BLArrayCore* self, const(void)* item);
    BLResult blArrayAppendData(BLArrayCore* self, const(void)* data, size_t n);

    BLResult blArrayInsertU8(BLArrayCore* self, size_t index, ubyte value);
    BLResult blArrayInsertU16(BLArrayCore* self, size_t index, ushort value);
    BLResult blArrayInsertU32(BLArrayCore* self, size_t index, uint value);
    BLResult blArrayInsertU64(BLArrayCore* self, size_t index, ulong value);
    BLResult blArrayInsertF32(BLArrayCore* self, size_t index, float value);
    BLResult blArrayInsertF64(BLArrayCore* self, size_t index, double value);
    BLResult blArrayInsertItem(BLArrayCore* self, size_t index, const(void)* item);
    BLResult blArrayInsertData(BLArrayCore* self, size_t index, const(void)* data, size_t n);

    BLResult blArrayReplaceU8(BLArrayCore* self, size_t index, ubyte value);
    BLResult blArrayReplaceU16(BLArrayCore* self, size_t index, ushort value);
    BLResult blArrayReplaceU32(BLArrayCore* self, size_t index, uint value);
    BLResult blArrayReplaceU64(BLArrayCore* self, size_t index, ulong value);
    BLResult blArrayReplaceF32(BLArrayCore* self, size_t index, float value);
    BLResult blArrayReplaceF64(BLArrayCore* self, size_t index, double value);
    BLResult blArrayReplaceItem(BLArrayCore* self, size_t index, const(void)* item);
    BLResult blArrayReplaceData(BLArrayCore* self, size_t rStart, size_t rEnd, const(void)* data, size_t n);

    BLResult blArrayRemoveIndex(BLArrayCore* self, size_t index);
    BLResult blArrayRemoveRange(BLArrayCore* self, size_t rStart, size_t rEnd);

    bool blArrayEquals(const(BLArrayCore)* a, const(BLArrayCore)* b) pure;

} else {
nothrow @nogc extern(C):

    BLResult function(BLBitArrayCore* self) blBitArrayInit;
    BLResult function(BLBitArrayCore* self, BLBitArrayCore* other) blBitArrayInitMove;
    BLResult function(BLBitArrayCore* self, const(BLBitArrayCore)* other) blBitArrayInitWeak;
    BLResult function(BLBitArrayCore* self) blBitArrayDestroy;
    BLResult function(BLBitArrayCore* self) blBitArrayReset;
    BLResult function(BLBitArrayCore* self, BLBitArrayCore* other) blBitArrayAssignMove;
    BLResult function(BLBitArrayCore* self, const(BLBitArrayCore)* other) blBitArrayAssignWeak;
    BLResult function(BLBitArrayCore* self, const(uint)* wordData, uint wordCount) blBitArrayAssignWords;
    bool function(const(BLBitArrayCore)* self) blBitArrayIsEmpty;
    uint function(const(BLBitArrayCore)* self) blBitArrayGetSize;
    uint function(const(BLBitArrayCore)* self) blBitArrayGetWordCount;
    uint function(const(BLBitArrayCore)* self) blBitArrayGetCapacity;
    const(uint)* function(const(BLBitArrayCore)* self) blBitArrayGetData;
    uint function(const(BLBitArrayCore)* self) blBitArrayGetCardinality;
    uint function(const(BLBitArrayCore)* self, uint startBit, uint endBit) blBitArrayGetCardinalityInRange;
    bool function(const(BLBitArrayCore)* self, uint bitIndex) blBitArrayHasBit;
    bool function(const(BLBitArrayCore)* self, uint startBit, uint endBit) blBitArrayHasBitsInRange;
    bool function(const(BLBitArrayCore)* a, const(BLBitArrayCore)* b) blBitArraySubsumes;
    bool function(const(BLBitArrayCore)* a, const(BLBitArrayCore)* b) blBitArrayIntersects;
    bool function(const(BLBitArrayCore)* self, uint* startOut, uint* endOut) blBitArrayGetRange;
    bool function(const(BLBitArrayCore)* a, const(BLBitArrayCore)* b) blBitArrayEquals;
    int function(const(BLBitArrayCore)* a, const(BLBitArrayCore)* b) blBitArrayCompare;
    BLResult function(BLBitArrayCore* self) blBitArrayClear;
    BLResult function(BLBitArrayCore* self, uint nBits) blBitArrayResize;
    BLResult function(BLBitArrayCore* self, uint nBits) blBitArrayReserve;
    BLResult function(BLBitArrayCore* self) blBitArrayShrink;
    BLResult function(BLBitArrayCore* self, uint bitIndex) blBitArraySetBit;
    BLResult function(BLBitArrayCore* self, uint startBit, uint endBit) blBitArrayFillRange;
    BLResult function(BLBitArrayCore* self, uint bitIndex, const(uint)* wordData, uint wordCount) blBitArrayFillWords;
    BLResult function(BLBitArrayCore* self, uint bitIndex) blBitArrayClearBit;
    BLResult function(BLBitArrayCore* self, uint startBit, uint endBit) blBitArrayClearRange;
    BLResult function(BLBitArrayCore* self, uint bitIndex, uint wordValue) blBitArrayClearWord;
    BLResult function(BLBitArrayCore* self, uint bitIndex, const(uint)* wordData, uint wordCount) blBitArrayClearWords;
    BLResult function(BLBitArrayCore* self, uint nBits, uint** dataOut) blBitArrayReplaceOp;
    BLResult function(BLBitArrayCore* self, uint bitIndex, bool bitValue) blBitArrayReplaceBit;
    BLResult function(BLBitArrayCore* self, uint bitIndex, uint wordValue) blBitArrayReplaceWord;
    BLResult function(BLBitArrayCore* self, uint bitIndex, const(uint)* wordData, uint wordCount) blBitArrayReplaceWords;
    BLResult function(BLBitArrayCore* self, bool bitValue) blBitArrayAppendBit;
    BLResult function(BLBitArrayCore* self, uint wordValue) blBitArrayAppendWord;
    BLResult function(BLBitArrayCore* self, const(uint)* wordData, uint wordCount) blBitArrayAppendWords;
    BLResult function(BLArrayCore* self, BLObjectType arrayType) blArrayInit;
    BLResult function(BLArrayCore* self, BLArrayCore* other) blArrayInitMove;
    BLResult function(BLArrayCore* self, const(BLArrayCore)* other) blArrayInitWeak;
    BLResult function(BLArrayCore* self) blArrayDestroy;
    BLResult function(BLArrayCore* self) blArrayReset;
    size_t function(const(BLArrayCore)* self) pure blArrayGetSize;
    size_t function(const(BLArrayCore)* self) pure blArrayGetCapacity;
    size_t function(BLArrayCore* self) pure blArrayGetItemSize;
    const(void)* function(const(BLArrayCore)* self) pure blArrayGetData;
    BLResult function(BLArrayCore* self) blArrayClear;
    BLResult function(BLArrayCore* self) blArrayShrink;
    BLResult function(BLArrayCore* self, size_t n) blArrayReserve;
    BLResult function(BLArrayCore* self, size_t n, const(void)* fill) blArrayResize;
    BLResult function(BLArrayCore* self, void** dataOut) blArrayMakeMutable;
    BLResult function(BLArrayCore* self, BLModifyOp op, size_t n, void** dataOut) blArrayModifyOp;
    BLResult function(BLArrayCore* self, size_t index, size_t n, void** dataOut) blArrayInsertOp;
    BLResult function(BLArrayCore* self, BLArrayCore* other) blArrayAssignMove;
    BLResult function(BLArrayCore* self, const(BLArrayCore)* other) blArrayAssignWeak;
    BLResult function(BLArrayCore* self, const(BLArrayCore)* other) blArrayAssignDeep;
    BLResult function(BLArrayCore* self, const(void)* data, size_t n) blArrayAssignData;
    BLResult function(BLArrayCore* self, void* data, size_t size, size_t capacity, BLDataAccessFlags dataAccessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData) blArrayAssignExternalData;
    BLResult function(BLArrayCore* self, ubyte value) blArrayAppendU8;
    BLResult function(BLArrayCore* self, ushort value) blArrayAppendU16;
    BLResult function(BLArrayCore* self, uint value) blArrayAppendU32;
    BLResult function(BLArrayCore* self, ulong value) blArrayAppendU64;
    BLResult function(BLArrayCore* self, float value) blArrayAppendF32;
    BLResult function(BLArrayCore* self, double value) blArrayAppendF64;
    BLResult function(BLArrayCore* self, const(void)* item) blArrayAppendItem;
    BLResult function(BLArrayCore* self, const(void)* data, size_t n) blArrayAppendData;
    BLResult function(BLArrayCore* self, size_t index, ubyte value) blArrayInsertU8;
    BLResult function(BLArrayCore* self, size_t index, ushort value) blArrayInsertU16;
    BLResult function(BLArrayCore* self, size_t index, uint value) blArrayInsertU32;
    BLResult function(BLArrayCore* self, size_t index, ulong value) blArrayInsertU64;
    BLResult function(BLArrayCore* self, size_t index, float value) blArrayInsertF32;
    BLResult function(BLArrayCore* self, size_t index, double value) blArrayInsertF64;
    BLResult function(BLArrayCore* self, size_t index, const(void)* item) blArrayInsertItem;
    BLResult function(BLArrayCore* self, size_t index, const(void)* data, size_t n) blArrayInsertData;
    BLResult function(BLArrayCore* self, size_t index, ubyte value) blArrayReplaceU8;
    BLResult function(BLArrayCore* self, size_t index, ushort value) blArrayReplaceU16;
    BLResult function(BLArrayCore* self, size_t index, uint value) blArrayReplaceU32;
    BLResult function(BLArrayCore* self, size_t index, ulong value) blArrayReplaceU64;
    BLResult function(BLArrayCore* self, size_t index, float value) blArrayReplaceF32;
    BLResult function(BLArrayCore* self, size_t index, double value) blArrayReplaceF64;
    BLResult function(BLArrayCore* self, size_t index, const(void)* item) blArrayReplaceItem;
    BLResult function(BLArrayCore* self, size_t rStart, size_t rEnd, const(void)* data, size_t n) blArrayReplaceData;
    BLResult function(BLArrayCore* self, size_t index) blArrayRemoveIndex;
    BLResult function(BLArrayCore* self, size_t rStart, size_t rEnd) blArrayRemoveRange;
    bool function(const(BLArrayCore)* a, const(BLArrayCore)* b) pure blArrayEquals;
}