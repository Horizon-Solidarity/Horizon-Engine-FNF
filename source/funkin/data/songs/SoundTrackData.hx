package funkin.data.songs;

typedef SoundTrackMetadata =
{
	@:default("Unknown")
    var artist:String;
	@:default({start: 0, end: 15000})
	var preview:AudioPreviewData;
	@:default("")
	var album:String;

	@:default([])
	var bpmChanges:Array<AudioBPMChangesData>;
}

typedef AudioPreviewData =
{
	var start:Float;
	var end:Float;
}

typedef AudioBPMChangesData =
{
	var time:Float;
	var bpm:Float;
	var ?endBpm:Float;
	var ?stepTime:Float;
	var ?stepsPerBeat:Int;
	var ?beatsPerMeasure:Int;
}