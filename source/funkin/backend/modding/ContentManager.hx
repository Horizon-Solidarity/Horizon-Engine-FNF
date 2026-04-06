package funkin.backend.modding;

import funkin.data.ContentData;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

class ContentManager
{
	public static inline final CONTENTS_ROOT:String = "content/";
    public static var contents:Array<Content> = [];
	public static var currentContent:String = null;

	public static function init():Void
	{
		contents = [];
		for (folder in FileSystem.readDirectory(CONTENTS_ROOT))
		{
			if (!FileSystem.isDirectory(Path.join([CONTENTS_ROOT, folder])))
				continue;
			var content = new Content(folder);
			if (!content._garbage)
			{
				trace("[ContentManager] Loaded content: " + content.data.name);
				contents.push(content);
			}
		}
	}

	public static function getFileBelong(file:String):String
	{
		for (content in contents)
		{
			if (FileSystem.exists(Path.join([CONTENTS_ROOT, content.data.folder, file])))
				return content.data.folder;
		}

		return null;
	}

	public static function get(folder:String):Content
		return contents.filter((c) -> return c.data.folder == folder)[0];
}