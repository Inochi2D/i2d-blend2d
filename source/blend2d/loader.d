module blend2d.loader;
import bindbc.loader;

import blend2d.blend2d;

version(B2D_Static) {

} else {
nothrow @nogc:

    enum Blend2DSupport {
        noLibrary,
        badLibrary,
        blend2d
    }

    private {
        SharedLib lib;
        Blend2DSupport loadedVersion;
    }

    @nogc nothrow:

    Blend2DSupport loadedBlend2DVersion() {
        return loadedVersion;
    }

    bool isBlend2DLoaded() {
        return lib != invalidHandle;
    }

    Blend2DSupport loadBlend2D() {
        version (Windows) {
            const(char)[][1] libNames =
                [
                    "blend2d.dll"
                ];
        } else version (OSX) {
            const(char)[][1] libNames =
                [
                    "libblend2d.dylib"
                ];
        } else version (Posix) {
            const(char)[][2] libNames =
                [
                    "libblend2d.so",
                    "/usr/local/lib/libblend2d.so",
                    "/lib/libblend2d.so"
                ];
        } else
            static assert(0, "Blend2D is not yet supported on this platform.");

        Blend2DSupport ret;
        foreach (name; libNames) {
            ret = loadBlend2D(name.ptr);
            if (ret != Blend2DSupport.noLibrary)
                break;
        }
        return ret;
    }

    Blend2DSupport loadBlend2D(const(char)* libName) {
        int loaded;

        pragma(inline, true)
        void dynamicLinkFuncs(alias module_, string prefix)(ref int loaded) {
            import std.algorithm.searching : startsWith;
            import std.traits : isSomeFunction;

            static foreach (m; __traits(allMembers, module_)) {
                static if (m.startsWith(prefix) && isSomeFunction!(__traits(getMember, module_, m))) {
                    lib.bindSymbol(
                        cast(void**)&__traits(getMember, module_, m),
                        __traits(getMember, module_, m).stringof
                    );
                    loaded++;
                }
            }
        }

        lib = load(libName);
        if (lib == invalidHandle) {
            return Blend2DSupport.noLibrary;
        }
        loadedVersion = Blend2DSupport.badLibrary;

        dynamicLinkFuncs!(blend2d.blend2d.api, "bl")(loaded);
        dynamicLinkFuncs!(blend2d.blend2d.image, "bl")(loaded);
        dynamicLinkFuncs!(blend2d.blend2d.context, "bl")(loaded);
        dynamicLinkFuncs!(blend2d.blend2d.geometry, "bl")(loaded);
        dynamicLinkFuncs!(blend2d.blend2d.font, "bl")(loaded);
        dynamicLinkFuncs!(blend2d.blend2d.glyphs, "bl")(loaded);
        dynamicLinkFuncs!(blend2d.blend2d.style, "bl")(loaded);

        loaded -= errorCount();
        if (loaded <= 0)
            return Blend2DSupport.badLibrary;

        loadedVersion = Blend2DSupport.blend2d;
        return loadedVersion;
    }

    void unloadBlend2D() {
        unload(lib);
        lib = invalidHandle;

        pragma(inline, true)
        void dynamicUnlinkFuncs(alias module_, string prefix)() {
            import std.algorithm.searching : startsWith;
            import std.traits : isSomeFunction;

            static foreach (m; __traits(allMembers, module_)) {
                static if (m.startsWith(prefix) && isSomeFunction!(__traits(getMember, module_, m))) {
                    __traits(getMember, module_, m) = null;
                }
            }
        }

        dynamicUnlinkFuncs!(blend2d.blend2d.api, "bl");
        dynamicUnlinkFuncs!(blend2d.blend2d.image, "bl");
        dynamicUnlinkFuncs!(blend2d.blend2d.context, "bl");
        dynamicUnlinkFuncs!(blend2d.blend2d.geometry, "bl");
        dynamicUnlinkFuncs!(blend2d.blend2d.font, "bl");
        dynamicUnlinkFuncs!(blend2d.blend2d.glyphs, "bl");
        
    }
}