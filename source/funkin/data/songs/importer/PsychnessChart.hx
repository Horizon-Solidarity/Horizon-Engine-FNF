package funkin.data.songs.importer;

typedef NessSong =
{
	var song:String;
	var notes:Array<NessSection>;
	var events:Array<Dynamic>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;
	var offset:Float;

	var characters:Array<NessCharacter>;
	var stage:String;
	var format:String;

	@:optional var player1:String;
	@:optional var player2:String;
	@:optional var gfVersion:String;

	@:optional var gameOverChar:String;
	@:optional var gameOverSound:String;
	@:optional var gameOverLoop:String;
	@:optional var gameOverEnd:String;

	@:optional var disableNoteRGB:Bool;

	@:optional var arrowSkin:String;
	@:optional var splashSkin:String;
}

typedef NessSection =
{
	var sectionNotes:Array<Dynamic>;
	var sectionBeats:Float;
	var mustHitSection:Bool;
	var focusCharacter:Int;
	@:optional var altAnim:Bool;
	@:optional var gfSection:Bool;
	@:optional var bpm:Float;
	@:optional var changeBPM:Bool;
}

enum abstract CharacterType(String) from String to String
{
	var OPPONENT = 'opponent';
	var PLAYER = 'player';
	var GIRLFRIEND = 'girlfriend';
}

typedef NessCharacter =
{
	var name:String;
	var position:Array<Float>;
	var strumPosition:Array<Float>;
	var visible:Bool;
	var strumVisible:Bool;
	var noteVisible:Bool;
	var characterType:CharacterType;
	@:optional var index:Int;
}

// ___________________________________________________________________________________
// ___________________________________________________________________________________