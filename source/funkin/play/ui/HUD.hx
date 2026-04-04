package funkin.play.ui;

import funkin.api.scripting.ScriptManager;

class HUD extends FlxSpriteGroup
{
    public var scripts:ScriptManager;

    public function new(style:String):Void
    {
        super();

        scripts = new ScriptManager();
        for (ext in ScriptManager.LUA_EXTENSIONS.concat(ScriptManager.HSCRIPT_EXTENSIONS))
            scripts.loadFromFile("scripts/play/huds/" + style + "." + ext, this, true, false);

        Conductor.instance.onStepHit.add((step) -> scripts.call("onStepHit", [step]));
        Conductor.instance.onBeatHit.add((beat) -> scripts.call("onBeatHit", [beat]));

        scripts.set("HealthIcon", HealthIcon);

        scripts.call("onLoad");
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        scripts.call("onUpdate", [elapsed]);
    }
}