package funkin.data.songs;

typedef SoundTrackMetadata =
{
    var artist:String;
	var preview:AudioPreviewData;
	var album:TrackAlbumData;
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