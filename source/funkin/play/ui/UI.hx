package funkin.play.ui;

import funkin.api.scripting.ScriptManager;

class UI extends FlxSpriteGroup
{
    public var scripts:ScriptManager;

    public function new(style:String):Void
    {
        super();

        scripts = new ScriptManager();
        for (ext in ScriptManager.LUA_EXTENSIONS.concat(ScriptManager.HSCRIPT_EXTENSIONS))
            scripts.loadFromFile("scripts/play/ui/" + style + "." + ext, this, true);

        Conductor.instance.onStepHit.add((step) -> scripts.call("onStepHit", [step]));
        Conductor.instance.onBeatHit.add((beat) -> scripts.call("onBeatHit", [beat]));
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        scripts.call("onUpdate", [elapsed]);
    }
}