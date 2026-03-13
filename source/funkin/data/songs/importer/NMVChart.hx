package funkin.data.songs.importer;

typedef NMVSection =
{
	var sectionNotes:Array<Dynamic>;
	var mustHitSection:Bool;
	
	var ?sectionBeats:Int;
	var gfSection:Bool;
	var bpm:Float;
	var changeBPM:Bool;
	var altAnim:Bool;
}

typedef NMVSong =
{
	var song:String;
	var notes:Array<NMVSection>;
	var events:Array<Dynamic>;
	var bpm:Float;
	var needsVoices:Bool;
	var ?trackSwap:Bool;
	var speed:Float;
	
	var keys:Int;
	var lanes:Int;
	
	var player1:String;
	var player2:String;
	var gfVersion:String;
	var stage:String;
	
	var arrowSkins:Array<String>;
	
	// var arrowSkin:String;
	// var splashSkin:String;
	var ?format:String;
}

// ___________________________________________________________________________________
// ___________________________________________________________________________________