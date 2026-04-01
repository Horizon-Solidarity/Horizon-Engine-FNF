package funkin.data.songs;

import funkin.play.Song;

typedef SongMetadata =
{
    @:default(Song.DEFAULT_CHART_FORMAT)
    var version:String;

	var name:String;

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

    @:default('Unknown Animator')
    var animatior:String;

    @:default('Unknown Coder')
    var coder:String;
}

typedef SongVariationData =
{
    var id:String;

    @:default('Unknown Song Mix')
    var name:String;

    @:default(["easy", "normal", "hard"])
    var difficulties:Array<String>;

    var credits:SongCredits;
}