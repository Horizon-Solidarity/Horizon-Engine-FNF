package funkin.data.menu.init;

typedef InitMetadata =
{
	var initHandler:Array<InitVisibleData>;
    var titleData:TitleData;
    @:optional var easterEgg:Bool;
}

typedef InitVisibleData =
{
    var sickBeat:Int;
    var data:Array<Dynamic>;
    @:optional var easterData:Array<Dynamic>;
}

typedef TitleData =
{
    var normal:TitleDataMain;
    @:optional var easter:TitleDataMain;
}

typedef TitleDataMain =
{
    var introImagePath:String;
    @:optional var characters:Array<String>;
    @:optional var logo:LogoData;
    @:optional var start:InitStartData;
    @:optional var bpm:Int;
}

typedef LogoData =
{
    var assetPath:String;
    var animation:Array<LogoAnimData>;
    var position:Array<Float>;
}

typedef LogoAnimData =
{
    var name:String;
    var prefix:String;
    @:optional var indices:Array<Int>;
    @:optional var looped:Bool;
    @:optional var frameRate:Int;
}

typedef InitStartData =
{
    var assetPath:String;
    var animation:InitStartAnim;
    var position:Array<Float>;
    var nextState:Array<Dynamic>;
}

typedef InitStartAnim =
{
    var name:String;
    var prefix:String;
    @:optional var indices:Array<Int>;
    @:optional var frameRate:Int;
}

// _________________________________ Title Character Data _____________________________________

typedef TitleCharData =
{
    var visible:Bool;
    var assetPath:String;
    var animation:Array<TitleCharAnim>;
}

typedef TitleCharAnim =
{
    var name:String;
    var prefix:String;
    @:optional var indices:Array<Int>;
    @:optional var looped:Bool;
    @:optional var frameRate:Int;
}