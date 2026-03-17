package funkin.data.songs.whats;

typedef SoundTrackMetadata =
{
    var name:String;
    var artist:String;
    var songData:AudioSetting;
}

typedef AudioSetting =
{
    var bpm:Float;
    var songTime:Float;
    var step:Int;
    var beat:Int;
}