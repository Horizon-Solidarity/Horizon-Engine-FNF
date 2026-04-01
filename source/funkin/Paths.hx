package funkin;

import sys.FileSystem;
import sys.io.File;

class Paths
{
	public static inline function image(key:String, folder:String = "images"):String
	{
		return getPath('$folder/$key.png');
	}

	public static inline function xml(key:String, folder:String = "images"):String
	{
		return getPath('$folder/$key.xml');
	}

	public static inline function sound(key:String, folder:String = "sounds"):String
	{
		return getPath('$folder/$key.ogg');
	}

	public static inline function music(key:String, folder:String = "music"):String
	{
		return getPath('$folder/$key.ogg');
	}

	public static inline function inst(song:String, variation:String = "default"):String
	{
		if (variation != "default")
			return getPath('songs/$song/audio/$variation/Inst.ogg');
		return getPath('songs/$song/audio/Inst.ogg');
	}

	public static inline function voice(song:String, postfix:String = "", variation:String = "default"):String
	{
		if (variation != "default")
			return getPath('songs/$song/audio/$variation/Voices$postfix.ogg');
		return getPath('songs/$song/audio/Voices$postfix.ogg');
	}

	public static inline function font(key:String, ext:String = "ttf", folder:String = "fonts"):String
	{
		return getPath('$folder/$key.$ext');
	}

	public static inline function json(key:String, folder:String = "data"):String
	{
		return getPath('$folder/$key.json');
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