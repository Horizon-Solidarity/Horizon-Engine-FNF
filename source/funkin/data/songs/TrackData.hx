package funkin.data.songs;

typedef TrackMetadata =
{
    var name:String;
    var artist:String;
    var bpm:Float;
    var songTime:Float;
    var preview:TrackPreviewData;
    var album:TrackAlbumData;
}

typedef TrackPreviewData =
{
    var start:Float;
    var end:Float;
}

typedef TrackAlbumData =
{
    var assetPath:String;
    var text:String;
    var fonts:Array<Dynamic>; // enabled, fontPath
}