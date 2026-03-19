package funkin.data.songs.whats;

typedef SoundTrackMetadata =
{
    var artist:String;
    var songData:AudioSetting;
	var preview:AudioPreviewData;
	var album:TrackAlbumData;
}

typedef AudioSetting =
{
    var bpm:Float;
    var songTime:Float;
    var step:Int;
    var beat:Int;
	var splitVocals:Bool;
}
typedef AudioPreviewData =
{
	var start:Float;
	var end:Float;
}

typedef TrackAlbumData =
{
	var assetPath:String;
	var text:String;
	var fonts:Array<Dynamic>;
}