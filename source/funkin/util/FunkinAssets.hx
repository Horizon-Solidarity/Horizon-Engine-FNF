package funkin.util;

import flixel.graphics.frames.FlxAtlasFrames;

class FunkinAssets
{
    public static inline function listDirectory(directory:String):Array<String>
    {
        trace(directory);
        var result = FileSystem.readDirectory(Paths.getPath(directory, "assets"));
        // TODO: handle mods
        return result;
    }

    public static inline function getSparrow(key:String):FlxAtlasFrames
	{
        // TODO: use fromFile instead for mod support
		return FlxAtlasFrames.fromSparrow(Paths.image(key), Paths.xml(key));
	}

    public static inline function getText(key:String):String
    {
        return sys.io.File.getContent(Paths.getPath(key));
    }
}