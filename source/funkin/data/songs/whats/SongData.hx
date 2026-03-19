package funkin.data.songs.whats;

typedef ChartDataInfo =
{
    var songs:ChartDataMain;
}

typedef ChartDataMain =
{
	var scrolSpeed:Float;
    var gameplayData:Array<SongCharacterMetadata>;
}

typedef SongCharacterMetadata =
{
    var characters:Array<SongCharacterData>;
    var localEvents:Array<ChartEventsData>;
    var notes:Array<ChartNotesData>;
}

typedef SongCharacterData =
{
    var id:String;
    // var strumLine:Array<SongStrumLineData>;
    // var color:SongCharColorData;
	var position:Array<Float>;
    var vocalSuffix:String;
    var strumLine:StrumLinedata;
}

typedef StrumLinedata =
{
    var visible:Bool;
    var keys:Int;
    var scale:Float;
    var distance:Float;
    var offsets:Array<Float>;
	var visible:Bool;
}

typedef ChartNotesData =
{
    var TIME:Float;
    var ID:Int;
    var LENGTH:Float;
    var DATA:Array<Dynamic>;
}

// __________________________________________ Events _______________________________________________
typedef SongEvents =
{
    var globalEvents:Array<ChartEventsData>;
}

typedef ChartEventsData =
{
    var TIME:Float;
    var NAME:String;
    var DATA:Array<Dynamic>;
}