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
        for (ext in ScriptManager.LUA_EXTENSIONS.concat(ScriptManager.HSCRIPT_EXTENSIONS))
            scripts.loadFromFile("scripts/play/huds/" + style + "." + ext, this, true, false);

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