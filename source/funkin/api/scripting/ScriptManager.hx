package funkin.api.scripting;

import haxe.io.Path;
import flixel.util.FlxDestroyUtil;

import funkin.api.scripting.handlers.*;

class ScriptManager implements IFlxDestroyable
{
    public static final LUA_EXTENSIONS:Array<String> = ["lua"];
    public static final HSCRIPT_EXTENSIONS:Array<String> = ["hx", "hxs", "hscript"];

    
    public var scripts:Array<IScriptHandler> = [];

    public function new(){}

    public function loadFromFolder(folder:String, ?parent:Dynamic, callOnCreate:Bool = true):Void
    {
        for (file in FunkinAssets.listDirectory(folder))
        {
            loadFromFile(Path.join([folder, file]), parent, true, callOnCreate);
        }
    }

    public function loadFromFile(path:String, ?parent:Dynamic, ignoreNonExistError:Bool = false, callOnCreate:Bool = true):Void
    {
        var realPath = Paths.getPath(path);
        var script:IScriptHandler = null;

        if (LUA_EXTENSIONS.contains(Path.extension(realPath)))
            script = LuaScript.fromFile(realPath);
        else if (HSCRIPT_EXTENSIONS.contains(Path.extension(realPath)))
            script = HScript.fromFile(realPath);
        else if (!ignoreNonExistError)
            trace('Script file ($path) not found! Skipping...');


        if (script != null)
            addScript(script, parent, callOnCreate);
    }

    public function addScript(script:IScriptHandler, ?parent:Dynamic, callOnCreate:Bool = true):Void
    {
        if (parent != null)
            script.setParent(parent);
        if (!scripts.contains(script))
            scripts.push(script);
        script.preset();

        if (callOnCreate && script.exists("onCreate"))
            script.call("onCreate");
    }

    public function set(id:String, value:Dynamic)
    {
        for (script in scripts)
        {
            script.set(id, value);
        }
    }

    public function call(id:String, ?args:Array<Dynamic>, ?acceptedValues:Array<Dynamic>):Dynamic
    {
        if (acceptedValues != null)
            acceptedValues = [ScriptGlobals.FUNCTION_STOP, ScriptGlobals.FUNCTION_CONTINUE];
        var result:Dynamic = null;

        for (script in scripts)
        {
            var ret = script.call(id, args);
            if (ret != null && acceptedValues.contains(ret))
                result = ret;
        }

        return result;
    }

    public function destroy():Void
    {
        for (script in scripts)
            script.destroy();
    }
}