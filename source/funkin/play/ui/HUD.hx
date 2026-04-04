package funkin.play.ui;

import funkin.api.scripting.ScriptManager;

class HUD extends FlxSpriteGroup
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

        scripts.call("onLoad");
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        scripts.call("onUpdate", [elapsed]);
    }
}