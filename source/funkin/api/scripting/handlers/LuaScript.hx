package funkin.api.scripting.handlers;

import funkin.api.scripting.IScriptHandler.ScriptType;
import lscript.LScript;

class LuaScript extends LScript implements IScriptHandler
{
    public var scriptType:ScriptType = LUA;

    public static function fromFile(path:String):IScriptHandler
    {
        return new LuaScript(sys.io.File.getContent(path), '$path: ');
    }

    public static function fromString(code:String):IScriptHandler
    {
        return new LuaScript(code, "Unknown: ");
    }

    public function new(code:String, tracePrefix:String)
    {
        super(code);
        this.tracePrefix = tracePrefix;

        execute();
    }

    public function call(id:String, ?args:Array<Dynamic>):Dynamic
    {
        if (!exists(id))
            return null;
        return callFunc(id, args);
    }

    public function exists(id:String):Bool
    {
        return get(id) != null;
    }

    public function get(id:String):Dynamic
    {
        return getVar(id);
    }

    public function set(id:String, value:Dynamic):Void
    {
        return setVar(id, value);
    }

    public function preset():Void
    {
        ScriptGlobals.preset(this);
    }

    public function setParent(parent:Dynamic):Void
    {
        this.parent = parent;
    }

    public function destroy():Void
    {
        call("onDestroy");
        llua.Lua.close(luaState);
        luaState = null;
    }
}