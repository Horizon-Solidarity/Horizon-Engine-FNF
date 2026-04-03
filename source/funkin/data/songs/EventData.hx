package funkin.data.songs;

import haxe.io.Path;
import hxjsonast.Json;

enum ParamType
{
	TBool;
	TInt(?min:Int, ?max:Int, ?step:Float);
	TFloat(?min:Float, ?max:Float, ?step:Float, ?precision:Int);
	TString;
	TCharacterList;
}

class EventMetadata
{
	public static var list:Map<String, String> = [];


	@:default([])
	public var aliases:Array<String>;
	public var script:String;
	@:default("Unknown")
	public var author:String;

	@:default([])
	public var args:Array<EventArgData>;

	public static function reloadEvents()
	{
		list.clear();

		for (file in FunkinAssets.listDirectory("data/events/"))
		{
			if (file.endsWith(".json"))
			{
				var json = haxe.Json.parse(File.getContent(Paths.getPath(Path.join(["data/events", file]))));
				var event = Path.withoutDirectory(Path.withoutExtension(file));
				if (json.aliases != null)
				{
					var aliases:Array<String> = json.aliases;
					for (alias in aliases)
						list.set(alias, event);
				}
				list.set(event, event);
			}
		}
	}
	public static function fromEventId(id:String):EventMetadata
	{
		if (!list.exists(id))
			reloadEvents();
		if (!list.exists(id)) // if still not exists, return null
		{
			trace('Event file of $id not found! returning null!');
			return null;
		}

		var parser = new json2object.JsonParser<EventMetadata>();

		try
		{
			parser.fromJson(File.getContent(Paths.json("events/" + id)));
		}
		catch (e:Dynamic)
		{
			trace('Error loading event file of "$id": $e');
			return null;
		}

		return parser.value;
	}
}

class EventArgData
{
	public var id:String;
	public var name:String;

	@:jcustomparse(funkin.data.songs.EventData.EventArgUtil.parseArgType)
	public var type:ParamType;
	public var defaultValue:String;
}

class EventArgUtil
{
	public static function parseArgType(json:Json, name:String):ParamType
	{
		switch (json.value)
		{
			case JString(s):
				// oowhhhh im so codenamin....
				var parser = new hscript.Parser();
				var interp = new hscript.Interp();

				interp.variables.set("Bool", ParamType.TBool);
				interp.variables.set("Int", function (?min:Int, ?max:Int, ?step:Float):ParamType {return ParamType.TInt(min, max, step);});
				interp.variables.set("Float", function (?min:Float, ?max:Float, ?step:Float, ?precision:Int):ParamType {return ParamType.TFloat(min, max, step, precision);});
				interp.variables.set("String", ParamType.TString);
				interp.variables.set("CharacterList", ParamType.TCharacterList);

				return interp.expr(parser.parseString(s));
			default:
				throw 'Expected arg type property to be a string, but it was ${json.value}.';
		}

		return ParamType.TString;
	}
}