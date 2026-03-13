package funkin.data.songs.importer;

typedef VSliceChart =
{
	var scrollSpeed:Dynamic;	// Map<String, Float>
	var events:Array<VSliceEvent>;
	var notes:Dynamic;			// Map<String, Array<VSliceNote>>
	var generatedBy:String;
	var version:String;
}

typedef VSliceNote =
{
	var t:Float;					// Strum time
	var d:Int;						// Note data
	@:optional var l:Null<Float>;	// Sustain Length
	@:optional var k:String;		// Note type
}

typedef VSliceEvent =
{
	var t:Float;	// Strum time
	var e:String;	// Event name
	var v:Dynamic;	// Values
}

// Metadata
typedef VSliceMetadata = 
{
	var songName:String;
	var artist:String;
	var charter:String;
	var playData:VSlicePlayData;

	var timeFormat:String;
	var timeChanges:Array<VSliceTimeChange>;
	var generatedBy:String;
	var version:String;
}

typedef VSlicePlayData =
{
	var difficulties:Array<String>;
	var characters:VSliceCharacters;
	var noteStyle:String;
	var stage:String;
}

typedef VSliceCharacters =
{
	var player:String;
	var girlfriend:String;
	var opponent:String;
}

typedef VSliceTimeChange =
{
	var t:Float;
	var bpm:Float;
}

// Package
typedef VSlicePackage =
{
	var chart:VSliceChart;
	var metadata:VSliceMetadata;
}