package funkin.api.scripting.handlers;

import funkin.api.scripting.IScriptHandler.ScriptType;
import insanity.Script;

class HScript implements IScriptHandler
{
    public var scriptType:ScriptType = HSCRIPT;

    public static function fromFile(path:String):IScriptHandler
    {
        var instance = new HScript(sys.io.File.getContent(path), path);
        return instance;
    }

    public static function fromString(code:String):IScriptHandler
    {
        var instance = new HScript(code);
        return instance;
    }

    var _script:Script;

    public function new(code:String, ?path:String)
    {
        _script = new Script(code, path);
        _script.start();
    }

    public function call(id:String, ?args:Array<Dynamic>):Dynamic
    {
        if (exists(id))
        {
            try
            {
                return _script.call(id, args);
            }
            catch(e)
            {
                trace('Error on running function $id: ' + e);
            }
        }
        return null;
    }

    public function exists(id:String):Bool
    {
        return _script.variables.exists(id);
    }

    public function get(id:String):Dynamic
    {
        return _script.variables.get(id);
    }

    public function set(id:String, value:Dynamic):Void
    {
        return _script.variables.set(id, value);
    }

    public function preset():Void
    {
        ScriptGlobals.preset(this);
    }

    public function setParent(parent:Dynamic):Void
    {
        _script.interp.parent = parent;
    }

    public function destroy():Void
    {
        call("onDestroy");
    }
}