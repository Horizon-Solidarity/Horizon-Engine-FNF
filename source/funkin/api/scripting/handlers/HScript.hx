package funkin.api.scripting.handlers;

import funkin.api.scripting.IScriptHandler.ScriptType;
import rulescript.RuleScript;

class HScript extends RuleScript implements IScriptHandler
{
    public var scriptType:ScriptType = HSCRIPT;

    public static function fromFile(path:String):IScriptHandler
    {
        return fromString(sys.io.File.getContent(path));
    }

    public static function fromString(code:String):IScriptHandler
    {
        var instance = new HScript();
        instance.tryExecute(code);
        return instance;
    }

    public function call(id:String, ?args:Array<Dynamic>):Dynamic
    {
        var func = variables.get(id);
        return Reflect.callMethod(null, func, args);
    }

    public function exists(id:String):Bool
    {
        return variables.exists(id);
    }

    public function get(id:String):Dynamic
    {
        return variables.get(id);
    }

    public function set(id:String, value:Dynamic):Void
    {
        return variables.set(id, value);
    }

    public function preset():Void{}

    public function setParent(parent:Dynamic):Void
    {
        this.superInstance = parent;
    }
}