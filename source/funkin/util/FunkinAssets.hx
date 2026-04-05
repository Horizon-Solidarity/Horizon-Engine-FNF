package funkin.util;

import flixel.graphics.frames.FlxAtlasFrames;

class FunkinAssets
{
    public static inline function listDirectory(directory:String):Array<String>
    {
        if (Paths.getPath(directory, "assets") == null)
            return [];
        var result = FileSystem.readDirectory(Paths.getPath(directory, "assets"));
        // TODO: handle mods
        return result;
    }

    public static inline function getSparrow(key:String, ?folder:String):FlxAtlasFrames
	{
        // TODO: use fromFile instead for mod support
		return FlxAtlasFrames.fromSparrow(Paths.image(key, folder), Paths.xml(key, folder));
	}

    public static inline function getText(key:String):String
    {
        return sys.io.File.getContent(Paths.getPath(key));
    }
}