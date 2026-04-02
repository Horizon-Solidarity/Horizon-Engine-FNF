package funkin.data.songs;

typedef SongChartData =
{
	var bpm:Float;
	@:default(1)
	var scrollSpeed:Float;
	@:default([])
	var events:Array<ChartEventsData>;
	@:default([])
	var characters:Array<SongCharacterData>;

	@:default("stage")
	var stage:String;
	@:default("funkin")
	var uiStyle:String;
}

typedef SongCharacterData =
{
	var id:String;
	var type:CharacterType;
	@:default("")
	var vocalSuffix:String;
	var strumline:Strumlinedata;
}

typedef Strumlinedata =
{
	@:default(true)
	var visible:Bool;
	@:default(4)
	var keys:Int;
	@:default(1)
	var scale:Float;
	@:default([0, 0])
	var offset:Array<Float>;
	@:default([])
	var notes:Array<ChartNoteData>;
}

typedef ChartNoteData =
{
    var time:Float;
    var lane:Int;
	@:default(0)
    var length:Float;
	@:default("")
	var type:String;
}

typedef ChartEventsData =
{
	var time:Float;
	var name:String;
	@:default([])
	var data:Map<String, Dynamic>;
}

enum abstract CharacterType(String) to String
{
	var OPPONENT = 'opponent';
	var SPECTATOR = 'spectator';
	var PLAYER = 'player';
}