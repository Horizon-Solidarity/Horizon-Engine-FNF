package funkin.api.scripting;

enum ScriptType
{
    LUA;
    HSCRIPT;
}

interface IScriptHandler
{
    public var scriptType:ScriptType;

    public function call(id:String, ?args:Array<Dynamic>):Dynamic;

    public function exists(id:String):Bool;
    public function get(id:String):Dynamic;
    public function set(id:String, value:Dynamic):Void;

    public function preset():Void;
    public function setParent(parent:Dynamic):Void;
}