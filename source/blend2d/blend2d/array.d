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
struct BLArray {
    mixin BLExtends!BLObject;

    /// Pointer to array data.
    void* data;
    /// Array size [in items].
    size_t size;
    /// Array capacity [in items].
    size_t capacity;
}

/// BitArray container [C API].
struct BLBitArray {
    mixin BLExtends!BLObject;
}

version(B2D_Static) {
nothrow @nogc extern(C):

    BLResult blBitArrayInit(BLBitArray* self);
    BLResult blBitArrayInitMove(BLBitArray* self, BLBitArray* other);
    BLResult blBitArrayInitWeak(BLBitArray* self, const(BLBitArray)* other);
    BLResult blBitArrayDestroy(BLBitArray* self);
    BLResult blBitArrayReset(BLBitArray* self);
    BLResult blBitArrayAssignMove(BLBitArray* self, BLBitArray* other);
    BLResult blBitArrayAssignWeak(BLBitArray* self, const(BLBitArray)* other);
    BLResult blBitArrayAssignWords(BLBitArray* self, const(uint)* wordData, uint wordCount);
    bool blBitArrayIsEmpty(const(BLBitArray)* self);
    uint blBitArrayGetSize(const(BLBitArray)* self);
    uint blBitArrayGetWordCount(const(BLBitArray)* self);
    uint blBitArrayGetCapacity(const(BLBitArray)* self);
    const(uint)* blBitArrayGetData(const(BLBitArray)* self);
    uint blBitArrayGetCardinality(const(BLBitArray)* self);
    uint blBitArrayGetCardinalityInRange(const(BLBitArray)* self, uint startBit, uint endBit);
    bool blBitArrayHasBit(const(BLBitArray)* self, uint bitIndex);
    bool blBitArrayHasBitsInRange(const(BLBitArray)* self, uint startBit, uint endBit);
    bool blBitArraySubsumes(const(BLBitArray)* a, const(BLBitArray)* b);
    bool blBitArrayIntersects(const(BLBitArray)* a, const(BLBitArray)* b);
    bool blBitArrayGetRange(const(BLBitArray)* self, uint* startOut, uint* endOut);
    bool blBitArrayEquals(const(BLBitArray)* a, const(BLBitArray)* b);
    int blBitArrayCompare(const(BLBitArray)* a, const(BLBitArray)* b);
    BLResult blBitArrayClear(BLBitArray* self);
    BLResult blBitArrayResize(BLBitArray* self, uint nBits);
    BLResult blBitArrayReserve(BLBitArray* self, uint nBits);
    BLResult blBitArrayShrink(BLBitArray* self);
    BLResult blBitArraySetBit(BLBitArray* self, uint bitIndex);
    BLResult blBitArrayFillRange(BLBitArray* self, uint startBit, uint endBit);
    BLResult blBitArrayFillWords(BLBitArray* self, uint bitIndex, const(uint)* wordData, uint wordCount);
    BLResult blBitArrayClearBit(BLBitArray* self, uint bitIndex);
    BLResult blBitArrayClearRange(BLBitArray* self, uint startBit, uint endBit);
    BLResult blBitArrayClearWord(BLBitArray* self, uint bitIndex, uint wordValue);
    BLResult blBitArrayClearWords(BLBitArray* self, uint bitIndex, const(uint)* wordData, uint wordCount);
    BLResult blBitArrayReplaceOp(BLBitArray* self, uint nBits, uint** dataOut);
    BLResult blBitArrayReplaceBit(BLBitArray* self, uint bitIndex, bool bitValue);
    BLResult blBitArrayReplaceWord(BLBitArray* self, uint bitIndex, uint wordValue);
    BLResult blBitArrayReplaceWords(BLBitArray* self, uint bitIndex, const(uint)* wordData, uint wordCount);
    BLResult blBitArrayAppendBit(BLBitArray* self, bool bitValue);
    BLResult blBitArrayAppendWord(BLBitArray* self, uint wordValue);
    BLResult blBitArrayAppendWords(BLBitArray* self, const(uint)* wordData, uint wordCount);

    BLResult blArrayInit(BLArray* self, BLObjectType arrayType);
    BLResult blArrayInitMove(BLArray* self, BLArray* other);
    BLResult blArrayInitWeak(BLArray* self, const(BLArray)* other);
    BLResult blArrayDestroy(BLArray* self);

    BLResult blArrayReset(BLArray* self);

    size_t blArrayGetSize(const(BLArray)* self) pure;
    size_t blArrayGetCapacity(const(BLArray)* self) pure;
    size_t blArrayGetItemSize(BLArray* self) pure;
    const(void)* blArrayGetData(const(BLArray)* self) pure;

    BLResult blArrayClear(BLArray* self);
    BLResult blArrayShrink(BLArray* self);
    BLResult blArrayReserve(BLArray* self, size_t n);
    BLResult blArrayResize(BLArray* self, size_t n, const(void)* fill);

    BLResult blArrayMakeMutable(BLArray* self, void** dataOut);
    BLResult blArrayModifyOp(BLArray* self, BLModifyOp op, size_t n, void** dataOut);
    BLResult blArrayInsertOp(BLArray* self, size_t index, size_t n, void** dataOut);

    BLResult blArrayAssignMove(BLArray* self, BLArray* other);
    BLResult blArrayAssignWeak(BLArray* self, const(BLArray)* other);
    BLResult blArrayAssignDeep(BLArray* self, const(BLArray)* other);
    BLResult blArrayAssignData(BLArray* self, const(void)* data, size_t n);
    BLResult blArrayAssignExternalData(BLArray* self, void* data, size_t size, size_t capacity, BLDataAccessFlags dataAccessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData);

    BLResult blArrayAppendU8(BLArray* self, ubyte value);
    BLResult blArrayAppendU16(BLArray* self, ushort value);
    BLResult blArrayAppendU32(BLArray* self, uint value);
    BLResult blArrayAppendU64(BLArray* self, ulong value);
    BLResult blArrayAppendF32(BLArray* self, float value);
    BLResult blArrayAppendF64(BLArray* self, double value);
    BLResult blArrayAppendItem(BLArray* self, const(void)* item);
    BLResult blArrayAppendData(BLArray* self, const(void)* data, size_t n);

    BLResult blArrayInsertU8(BLArray* self, size_t index, ubyte value);
    BLResult blArrayInsertU16(BLArray* self, size_t index, ushort value);
    BLResult blArrayInsertU32(BLArray* self, size_t index, uint value);
    BLResult blArrayInsertU64(BLArray* self, size_t index, ulong value);
    BLResult blArrayInsertF32(BLArray* self, size_t index, float value);
    BLResult blArrayInsertF64(BLArray* self, size_t index, double value);
    BLResult blArrayInsertItem(BLArray* self, size_t index, const(void)* item);
    BLResult blArrayInsertData(BLArray* self, size_t index, const(void)* data, size_t n);

    BLResult blArrayReplaceU8(BLArray* self, size_t index, ubyte value);
    BLResult blArrayReplaceU16(BLArray* self, size_t index, ushort value);
    BLResult blArrayReplaceU32(BLArray* self, size_t index, uint value);
    BLResult blArrayReplaceU64(BLArray* self, size_t index, ulong value);
    BLResult blArrayReplaceF32(BLArray* self, size_t index, float value);
    BLResult blArrayReplaceF64(BLArray* self, size_t index, double value);
    BLResult blArrayReplaceItem(BLArray* self, size_t index, const(void)* item);
    BLResult blArrayReplaceData(BLArray* self, size_t rStart, size_t rEnd, const(void)* data, size_t n);

    BLResult blArrayRemoveIndex(BLArray* self, size_t index);
    BLResult blArrayRemoveRange(BLArray* self, size_t rStart, size_t rEnd);

    bool blArrayEquals(const(BLArray)* a, const(BLArray)* b) pure;

} else {
nothrow @nogc extern(C):

    BLResult function(BLBitArray* self) blBitArrayInit;
    BLResult function(BLBitArray* self, BLBitArray* other) blBitArrayInitMove;
    BLResult function(BLBitArray* self, const(BLBitArray)* other) blBitArrayInitWeak;
    BLResult function(BLBitArray* self) blBitArrayDestroy;
    BLResult function(BLBitArray* self) blBitArrayReset;
    BLResult function(BLBitArray* self, BLBitArray* other) blBitArrayAssignMove;
    BLResult function(BLBitArray* self, const(BLBitArray)* other) blBitArrayAssignWeak;
    BLResult function(BLBitArray* self, const(uint)* wordData, uint wordCount) blBitArrayAssignWords;
    bool function(const(BLBitArray)* self) blBitArrayIsEmpty;
    uint function(const(BLBitArray)* self) blBitArrayGetSize;
    uint function(const(BLBitArray)* self) blBitArrayGetWordCount;
    uint function(const(BLBitArray)* self) blBitArrayGetCapacity;
    const(uint)* function(const(BLBitArray)* self) blBitArrayGetData;
    uint function(const(BLBitArray)* self) blBitArrayGetCardinality;
    uint function(const(BLBitArray)* self, uint startBit, uint endBit) blBitArrayGetCardinalityInRange;
    bool function(const(BLBitArray)* self, uint bitIndex) blBitArrayHasBit;
    bool function(const(BLBitArray)* self, uint startBit, uint endBit) blBitArrayHasBitsInRange;
    bool function(const(BLBitArray)* a, const(BLBitArray)* b) blBitArraySubsumes;
    bool function(const(BLBitArray)* a, const(BLBitArray)* b) blBitArrayIntersects;
    bool function(const(BLBitArray)* self, uint* startOut, uint* endOut) blBitArrayGetRange;
    bool function(const(BLBitArray)* a, const(BLBitArray)* b) blBitArrayEquals;
    int function(const(BLBitArray)* a, const(BLBitArray)* b) blBitArrayCompare;
    BLResult function(BLBitArray* self) blBitArrayClear;
    BLResult function(BLBitArray* self, uint nBits) blBitArrayResize;
    BLResult function(BLBitArray* self, uint nBits) blBitArrayReserve;
    BLResult function(BLBitArray* self) blBitArrayShrink;
    BLResult function(BLBitArray* self, uint bitIndex) blBitArraySetBit;
    BLResult function(BLBitArray* self, uint startBit, uint endBit) blBitArrayFillRange;
    BLResult function(BLBitArray* self, uint bitIndex, const(uint)* wordData, uint wordCount) blBitArrayFillWords;
    BLResult function(BLBitArray* self, uint bitIndex) blBitArrayClearBit;
    BLResult function(BLBitArray* self, uint startBit, uint endBit) blBitArrayClearRange;
    BLResult function(BLBitArray* self, uint bitIndex, uint wordValue) blBitArrayClearWord;
    BLResult function(BLBitArray* self, uint bitIndex, const(uint)* wordData, uint wordCount) blBitArrayClearWords;
    BLResult function(BLBitArray* self, uint nBits, uint** dataOut) blBitArrayReplaceOp;
    BLResult function(BLBitArray* self, uint bitIndex, bool bitValue) blBitArrayReplaceBit;
    BLResult function(BLBitArray* self, uint bitIndex, uint wordValue) blBitArrayReplaceWord;
    BLResult function(BLBitArray* self, uint bitIndex, const(uint)* wordData, uint wordCount) blBitArrayReplaceWords;
    BLResult function(BLBitArray* self, bool bitValue) blBitArrayAppendBit;
    BLResult function(BLBitArray* self, uint wordValue) blBitArrayAppendWord;
    BLResult function(BLBitArray* self, const(uint)* wordData, uint wordCount) blBitArrayAppendWords;
    BLResult function(BLArray* self, BLObjectType arrayType) blArrayInit;
    BLResult function(BLArray* self, BLArray* other) blArrayInitMove;
    BLResult function(BLArray* self, const(BLArray)* other) blArrayInitWeak;
    BLResult function(BLArray* self) blArrayDestroy;
    BLResult function(BLArray* self) blArrayReset;
    size_t function(const(BLArray)* self) pure blArrayGetSize;
    size_t function(const(BLArray)* self) pure blArrayGetCapacity;
    size_t function(BLArray* self) pure blArrayGetItemSize;
    const(void)* function(const(BLArray)* self) pure blArrayGetData;
    BLResult function(BLArray* self) blArrayClear;
    BLResult function(BLArray* self) blArrayShrink;
    BLResult function(BLArray* self, size_t n) blArrayReserve;
    BLResult function(BLArray* self, size_t n, const(void)* fill) blArrayResize;
    BLResult function(BLArray* self, void** dataOut) blArrayMakeMutable;
    BLResult function(BLArray* self, BLModifyOp op, size_t n, void** dataOut) blArrayModifyOp;
    BLResult function(BLArray* self, size_t index, size_t n, void** dataOut) blArrayInsertOp;
    BLResult function(BLArray* self, BLArray* other) blArrayAssignMove;
    BLResult function(BLArray* self, const(BLArray)* other) blArrayAssignWeak;
    BLResult function(BLArray* self, const(BLArray)* other) blArrayAssignDeep;
    BLResult function(BLArray* self, const(void)* data, size_t n) blArrayAssignData;
    BLResult function(BLArray* self, void* data, size_t size, size_t capacity, BLDataAccessFlags dataAccessFlags, BLDestroyExternalDataFunc destroyFunc, void* userData) blArrayAssignExternalData;
    BLResult function(BLArray* self, ubyte value) blArrayAppendU8;
    BLResult function(BLArray* self, ushort value) blArrayAppendU16;
    BLResult function(BLArray* self, uint value) blArrayAppendU32;
    BLResult function(BLArray* self, ulong value) blArrayAppendU64;
    BLResult function(BLArray* self, float value) blArrayAppendF32;
    BLResult function(BLArray* self, double value) blArrayAppendF64;
    BLResult function(BLArray* self, const(void)* item) blArrayAppendItem;
    BLResult function(BLArray* self, const(void)* data, size_t n) blArrayAppendData;
    BLResult function(BLArray* self, size_t index, ubyte value) blArrayInsertU8;
    BLResult function(BLArray* self, size_t index, ushort value) blArrayInsertU16;
    BLResult function(BLArray* self, size_t index, uint value) blArrayInsertU32;
    BLResult function(BLArray* self, size_t index, ulong value) blArrayInsertU64;
    BLResult function(BLArray* self, size_t index, float value) blArrayInsertF32;
    BLResult function(BLArray* self, size_t index, double value) blArrayInsertF64;
    BLResult function(BLArray* self, size_t index, const(void)* item) blArrayInsertItem;
    BLResult function(BLArray* self, size_t index, const(void)* data, size_t n) blArrayInsertData;
    BLResult function(BLArray* self, size_t index, ubyte value) blArrayReplaceU8;
    BLResult function(BLArray* self, size_t index, ushort value) blArrayReplaceU16;
    BLResult function(BLArray* self, size_t index, uint value) blArrayReplaceU32;
    BLResult function(BLArray* self, size_t index, ulong value) blArrayReplaceU64;
    BLResult function(BLArray* self, size_t index, float value) blArrayReplaceF32;
    BLResult function(BLArray* self, size_t index, double value) blArrayReplaceF64;
    BLResult function(BLArray* self, size_t index, const(void)* item) blArrayReplaceItem;
    BLResult function(BLArray* self, size_t rStart, size_t rEnd, const(void)* data, size_t n) blArrayReplaceData;
    BLResult function(BLArray* self, size_t index) blArrayRemoveIndex;
    BLResult function(BLArray* self, size_t rStart, size_t rEnd) blArrayRemoveRange;
    bool function(const(BLArray)* a, const(BLArray)* b) pure blArrayEquals;
}