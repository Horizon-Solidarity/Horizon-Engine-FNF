package funkin.api.scripting;

import haxe.io.Path;

import funkin.api.scripting.handlers.*;

class ScriptManager
{
    public var scripts:Array<IScriptHandler> = [];

    public function new(){}

    public function loadFromFolder(folder:String, ?parent:Dynamic, callOnCreate:Bool = true):Void
    {
        for (file in FunkinAssets.listDirectory(folder))
        {
            loadFromFile(Path.join([folder, file]), callOnCreate);
        }
    }

    public function loadFromFile(path:String, ?parent:Dynamic, callOnCreate:Bool = true):Void
    {
        var realPath = Paths.getPath(path);
        var script:IScriptHandler = null;

        switch(Path.extension(realPath))
        {
            case "lua":
                script = LuaScript.fromFile(realPath);
            case "hx", "hxc", "hscript":
                script = HScript.fromFile(realPath);
        }

        if (script != null)
            addScript(script, parent, callOnCreate);
    }

    public function addScript(script:IScriptHandler, ?parent:Dynamic, callOnCreate:Bool = true):Void
    {
        if (parent != null)
            script.setParent(parent);
        if (!scripts.contains(script))
            scripts.push(script);
        if (callOnCreate && script.exists("onCreate"))
            script.call("onCreate");
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
}