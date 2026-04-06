package funkin.play.ui.huds;

import funkin.backend.scripting.ScriptManager;

class ScriptedHUD extends HUD
{
    public var scripts:ScriptManager;

    public function new(style:String):Void
    {
        super();

        scripts = new ScriptManager();
        scripts.customPreset = PlayState.instance.presetScript;
        scripts.loadFromName("scripts/play/huds/" + style, this, true, false);

        Conductor.instance.onStepHit.add((step) -> scripts.call("onStepHit", [step]));
        Conductor.instance.onBeatHit.add((beat) -> scripts.call("onBeatHit", [beat]));
		Conductor.instance.onMeasureHit.add((measure) -> scripts.call("onMeasureHit", [measure]));

        scripts.set("add", add);
        scripts.set("remove", remove);
        scripts.set("members", members);
        scripts.set("insert", insert);
    }

    override public function load():Void
    {
        super.load();
        scripts.call("onLoad");
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        scripts.call("onUpdate", [elapsed]);
    }

    // The conductor callback has already been set in the script by PlayState.instance.presetScript, so do not override it here.
    // override public function stepHit(step:Int)
}