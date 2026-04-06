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

typedef EventMetadata =
{
	@:default([])
	var aliases:Array<String>;
	var script:String;
	@:default("Unknown")
	var author:String;

	@:default([])
	var args:Array<EventArgData>;
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
				var parser = new insanity.backend.Parser();
				var interp = new insanity.backend.Interp();

				interp.variables.set("bool", ParamType.TBool);
				interp.variables.set("int", (?min:Int, ?max:Int, ?step:Float) -> return ParamType.TInt(min, max, step));
				interp.variables.set("float", (?min:Float, ?max:Float, ?step:Float, ?precision:Int) -> ParamType.TFloat(min, max, step, precision));
				interp.variables.set("string", () -> return ParamType.TString);
				interp.variables.set("characterList", () -> return ParamType.TString);
				
				if (!s.endsWith(")")) // stupid workaround
					s += "()";

				@:privateAccess
				return interp.expr(parser.parseScript(s));
			default:
				throw 'Expected arg type property to be a string, but it was ${json.value}.';
		}

		return ParamType.TString;
	}
}