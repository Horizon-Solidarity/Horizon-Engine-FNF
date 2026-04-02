package funkin.data.ui;

import funkin.data.animation.AnimationData;

typedef NoteskinMetadata =
{
    var name:String;
    @:default("Unknown")
    var author:String;
    var folder:String;
    var assets:NoteskinAssetsData;
}

typedef NoteskinAssetsData =
{
    var note:NoteskinData;
    var strumline:NoteskinData;
    var holdNote:NoteskinData;
    var noteSplash:NoteskinData;
    var holdNoteCover:NoteskinData;
}

typedef NoteskinData =
{
    var assetPath:String;
    @:default(1)
    var scale:Float;
    @:default(1)
    var alpha:Float;
    @:default([0, 0])
    var offset:Array<Float>;
    @:default([])
    var animations:Map<String, Array<UnnamedAnimationData>>;
    @:default(true)
    var antialiasing:Bool;
}