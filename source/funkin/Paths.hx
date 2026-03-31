package funkin;

import sys.FileSystem;
import sys.io.File;

class Paths
{
	public static inline function image(key:String):String
	{
		return getPath('images/$key.png');
	}

	public static inline function xml(key:String):String
	{
		return getPath('images/$key.xml');
	}

	public static inline function sound(key:String):String
	{
		return getPath('sounds/$key.ogg');
	}

	public static inline function music(key:String):String
	{
		return getPath('music/$key.ogg');
	}

	public static inline function font(key:String, ext:String = "ttf"):String
	{
		return getPath('fonts/$key.$ext');
	}

	public static inline function json(key:String):String
	{
		return getPath('data/$key.json');
	}

	public static inline function getPath(key:String, ?content:String):String
	{
		var ret:String = "assets/" + key;
		if (content != null && content.toLowerCase() == "assets")
		{
			if (FileSystem.exists(ret))
				return ret;
			return null;
		}
		// TODO: handle mods
		if (FileSystem.exists(ret))
			return ret;
		return null;
	}
}