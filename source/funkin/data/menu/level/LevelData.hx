package funkin.data.menu.level;

typedef LevelData =
{
    var name:String;
    var titleAssetPath:String;
    var characters:Array<WeekCharData>;
    var bgColor:String;
    var allDifficulties:Array<String>;
    var songs:Array<LevelSongData>;
}

typedef WeekCharData =
{
    var id:String;
    var scale:Float;
    var offsets:Array<Float>;
}

typedef LevelSongData =
{
    var songName:String; // songName.toLowerCase();
    var secret:Bool;
    var difficulties:Array<String>;
}