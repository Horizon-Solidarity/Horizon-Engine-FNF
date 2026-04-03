package funkin.play;

import funkin.data.songs.SongData;
import funkin.data.songs.EventData;
import funkin.api.scripting.ScriptManager;

import json2object.JsonParser;
import sys.io.File;

class Event
{
    public var meta:EventMetadata;
    public var data:ChartEventsData;
    
    var scripts:ScriptManager;

    public function new(meta:EventMetadata, data:ChartEventsData)
    {
        this.meta = meta;
        this.data = data;

        scripts = new ScriptManager();
        for (ext in ScriptManager.LUA_EXTENSIONS.concat(ScriptManager.HSCRIPT_EXTENSIONS))
            scripts.loadFromFile("scripts/play/events/" + meta.script + "." + ext, this, true, false);
        scripts.call("onLoad");
    }

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

    public function call()
    {
        scripts.call("onCall");
    }
}