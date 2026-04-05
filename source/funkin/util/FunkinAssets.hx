package funkin.util;

import flixel.graphics.frames.FlxAtlasFrames;
import funkin.backend.modding.ContentManager;
import sys.io.File;

class FunkinAssets
{
    public static inline function listDirectory(directory:String):Array<String>
    {
        if (Paths.getPath(directory, "assets") == null)
            return [];
        var result = FileSystem.readDirectory(Paths.getPath(directory, "assets"));
		for (content in ContentManager.contents)
			if (content.getPath(directory) != null)
				result = result.concat(FileSystem.readDirectory(content.getPath(directory)));
        return result;
    }

    public static inline function getSparrow(key:String, ?folder:String):FlxAtlasFrames
	{
        // TODO: use fromFile instead for mod support
		return FlxAtlasFrames.fromSparrow(Paths.image(key, folder), File.getContent(Paths.xml(key, folder)));
	}

    public static inline function getText(key:String):String
    {
        return sys.io.File.getContent(Paths.getPath(key));
    }
}