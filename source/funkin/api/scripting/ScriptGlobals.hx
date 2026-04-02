package funkin.api.scripting;

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
        script.set("PlayState", funkin.play.PlayState);

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