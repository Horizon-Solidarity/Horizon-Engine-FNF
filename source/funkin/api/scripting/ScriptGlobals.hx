package funkin.api.scripting;

import funkin.play.PlayState;

class ScriptGlobals
{
    public static inline final FUNCTION_STOP:String = "##FUNCTION_STOP##";
    public static inline final FUNCTION_CONTINUE:String = "##FUNCTION_CONTINUE##";

    public static function preset(script:IScriptHandler)
    {
        script.set("Paths", Paths);
        script.set("Conductor", Conductor);
        script.set("FunkinAssets", FunkinAssets);
        script.set("ClientPrefs", ClientPrefs);
        script.set("PlayState", PlayState);
        if (PlayState.instance != null)
            script.set("game", PlayState.instance);

        script.set("FlxSprite", FlxSprite);
        script.set("FlxCamera", FlxCamera);
        script.set("FlxG", FlxG);
        script.set("FlxMath", FlxMath);
        script.set("FlxSound", FlxSound);
        script.set("FlxText", FlxText);
        script.set("FlxTween", FlxTween);
        script.set("FlxEase", FlxEase);
        script.set("FlxTimer", FlxTimer);
    }
}