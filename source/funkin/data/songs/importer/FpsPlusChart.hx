package funkin.data.songs.importer;

typedef FPSSong =
{
	var song:String;
	var notes:Array<FPSSection>;
	var bpm:Float;
	var speed:Float;

	var player1:String;
	var player2:String;
	var stage:String;
	var gf:String;
}

typedef FPSSongEvents =
{
	var events:Array<Dynamic>;
}

typedef FPSSection =
{
	var sectionNotes:Array<Dynamic>;
	var lengthInSteps:Int;
	var mustHitSection:Bool;
	var bpm:Float;
	var changeBPM:Bool;
}

// ___________________________________________________________________________________
// ___________________________________________________________________________________