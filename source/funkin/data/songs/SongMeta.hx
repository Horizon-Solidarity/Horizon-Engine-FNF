package funkin.data.songs;

import funkin.play.Song.ChartFormat;

typedef SongMetadata =
{
    @:default("0.0.1")
    var version:String;

	var name:String;

    @:default(["easy", "normal", "hard"])
    var difficulties:Array<String>;
    @:default([])
    var variations:Array<SongVariationData>;

    var credits:SongCredits;


    @:default("Unknown")
    var generatedBy:String;
}

// _____________________________ Metadata's Internal Structure _____________________________

typedef SongCredits =
{
    @:default('Unknown Charter')
    var charter:String;

    @:default('Unknown Animator')
    var animator:String;

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