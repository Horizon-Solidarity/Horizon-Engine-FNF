package funkin.backend.scripting;

import flixel.util.FlxDestroyUtil;
import funkin.backend.scripting.handlers.*;
import haxe.io.Path;

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

    public function loadFromName(path:String, ?parent:Dynamic, ignoreNonExistError:Bool = false, callOnCreate:Bool = true):Void
    {
        for (ext in ScriptManager.LUA_EXTENSIONS.concat(ScriptManager.HSCRIPT_EXTENSIONS))
            loadFromFile(path + "." + ext, parent, ignoreNonExistError, callOnCreate);
    }

    public function loadFromFile(path:String, ?parent:Dynamic, ignoreNonExistError:Bool = false, callOnCreate:Bool = true):IScriptHandler
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
            return addScript(script, parent, callOnCreate);
        return null;
    }

    public function addScript(script:IScriptHandler, ?parent:Dynamic, callOnCreate:Bool = true):IScriptHandler
    {
        if (parent != null)
            script.setParent(parent);
        if (!scripts.contains(script))
            scripts.push(script);
        script.preset();
        customPreset(script);

        if (callOnCreate && script.exists("onCreate"))
            script.call("onCreate");
        return script;
    }


    public dynamic function customPreset(script:IScriptHandler){}

    public function set(id:String, value:Dynamic)
    {
        for (script in scripts)
        {
            script.set(id, value);
        }
    }

    public function call(id:String, ?args:Array<Dynamic>, ?acceptedValues:Array<Dynamic>):Dynamic
    {
        if (acceptedValues == null)
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