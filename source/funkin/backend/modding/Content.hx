package funkin.backend.modding;

import funkin.data.ContentData;
import haxe.io.Path;
import json2object.JsonParser;

class Content
{
    public var data:ContentMetadata;
	public var _garbage:Bool = false;

	public function new(folder:String)
	{
		var metaParser = new JsonParser<ContentMetadata>();
		try
		{
			var path = Path.join([ContentManager.CONTENTS_ROOT, folder, "metadata.json"]);
			data = metaParser.fromJson(sys.io.File.getContent(path), path);
		}
		catch (e:Dynamic)
		{
			trace('Error loading content metadata of "$folder": $e');
			_garbage = true;
		}

		if (data != null)
		{
			data.folder = folder;
		}
	}

	public function getPath(key:String)
	{
		var path = Path.join([ContentManager.CONTENTS_ROOT, data.folder, key]);
		if (sys.FileSystem.exists(path))
			return path;
		return null;
	}
}