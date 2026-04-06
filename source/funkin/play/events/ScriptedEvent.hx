package funkin.play.events;

import funkin.backend.scripting.ScriptManager;
import funkin.data.songs.EventData;
import funkin.data.songs.SongData;
import sys.io.File;

class ScriptedEvent extends Event
{   
    var scripts:ScriptManager;

    public function new(name:String)
    {
        super();

        scripts = new ScriptManager();
        scripts.customPreset = PlayState.instance.presetScript;
        scripts.loadFromName("scripts/play/events/" + name, this, true, false);
        scripts.set("getArgValue", getArgValue);

        Conductor.instance.onStepHit.add((step) -> scripts.call("onStepHit", [step]));
        Conductor.instance.onBeatHit.add((beat) -> scripts.call("onBeatHit", [beat]));
		Conductor.instance.onMeasureHit.add((measure) -> scripts.call("onMeasureHit", [measure]));
    }

    override public function load()
    {
        super.load();
        scripts.call("onLoad");
    }

    override public function call()
    {
        super.call();
        scripts.call("onCall");
    }

    override public function allowCallBeforeStart() return scripts.call("allowCallBeforeStart", [true, false]) ?? false;
}