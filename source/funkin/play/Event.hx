package funkin.play;

import funkin.backend.scripting.ScriptManager;
import funkin.data.songs.EventData;
import funkin.data.songs.SongData;
import json2object.JsonParser;
import sys.io.File;

import funkin.play.events.ScriptedEvent;

class Event
{
    public static var types:Map<String, Event> = [];

    public static function get(type:String, chartData:ChartEventsData):Event
    {
        if (Paths.json("events/" + type) != null)
        {
            var typeParser = new JsonParser<EventMetadata>();
            var meta:EventMetadata;
            try
            {
                meta = typeParser.fromJson(sys.io.File.getContent(Paths.json("events/" + type)), Paths.json("events/" + type));
            
                var instance:Event = Type.resolveClass(meta.script) != null ? Type.createInstance(Type.resolveClass(meta.script), []) : new ScriptedEvent(meta.script);
                if (instance != null)
                {
                    instance.data = chartData;
                    instance.meta = meta;
                    instance.load();
                }
                return instance;
            }
            catch (e:Dynamic)
            {
                trace('Error loading event of "$type": $e');
                return null;
            }
        }

        trace("Notetype " + type + " not found!");
        return null;
    }

    public var game(get, never):PlayState;
    function get_game() return PlayState.instance;

    public var meta:EventMetadata;
    public var data:ChartEventsData;

    public function new(){}

    public function allowCallBeforeStart() return false;

    public function load():Void{}

    public function getArgValue(arg:String):Dynamic
    {
        if (data.data.exists(arg) && data.data.get(arg) != null)
            return data.data.get(arg);
        else
        {
            for (argData in meta.args)
            {
                if (argData.id == arg)
                {
                    switch(argData.type)
                    {
                        case TBool:
                            return (argData.defaultValue == "true");
                        case TInt(min, max, step):
                            return Std.parseInt(argData.defaultValue);
                        case TFloat(min, max, step, precision):
                            return Std.parseInt(argData.defaultValue);
                        case TCharacterList:
                            return Std.parseInt(argData.defaultValue);
                        default:
                            return argData.defaultValue;
                    }
                }
            }
        }

        return null;
    }

    public function call():Void{}
}