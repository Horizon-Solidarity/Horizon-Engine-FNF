package funkin.data.songs.whats;

typedef SongMetadata =
{
    var version:String;

    var songName:String;

    var bpm:Float;
    
    var contributor:SongCredits;

    var playData:SongPlayData;

    var generatedBy:String;
}

// _____________________________ Metadata's Internal Structure _____________________________

typedef SongCredits =
{
    var music:String;

    var chart:String;

    @:optional var art:String;

    @:optional var animation:String;

    @:optional var code:String;
}

typedef SongPlayData =
{
    var difficulties:Array<String>;

    @:optional var variations:Array<SongVariationData>;

    var audio:SongAudioData;

    var stage:String;

    var songStartCamera:SongStartCamera;

    @:optional var uiStyle:String;
}

typedef SongAudioData =
{
    var splitVocals:Bool;
    // var altInst:Array<String>;
}

// ___________________________________ Work In Progress ___________________________________

typedef SongStrumLineData =
{
    var enabled:Bool;
    var offsets:Array<Float>;
}

typedef SongVariationData =
{
    var charMixes:Array<String>;
    @:optional var extraDiffs:Array<String>;
}

typedef SongStartCamera =
{
    var focus:Map<String, Int>;
    var zoom:Float;
}