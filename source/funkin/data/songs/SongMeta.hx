package funkin.data.songs;

import funkin.play.Song;

typedef SongMetadata =
{
    @:default(Song.DEFAULT_CHART_FORMAT)
    var version:String;

	var name:String;
    var bpm:Float;

    @:default(["easy", "normal", "hard"])
    var difficulties:Array<String>;
    @:default([])
    var variations:Array<SongVariationData>;

    var credits:SongCredits;


    @:default(Song.HORIZON_CONVERTED)
    var generatedBy:String;
}

// _____________________________ Metadata's Internal Structure _____________________________

typedef SongCredits =
{
    @:default('Unknown Charter')
    var charter:String;

    @:default('Unknown Artist')
    var art:String;

    @:default('Unknown Animator')
    var animation:String;

    @:default('Unknown Coder')
    var code:String;
}

typedef SongVariationData =
{
    var name:String;

    @:default(["easy", "normal", "hard"])
    var difficulties:Array<String>;
}