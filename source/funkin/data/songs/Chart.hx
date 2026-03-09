package funkin.data.songs;

import funkin.data.songs.SongData;
import funkin.data.songs.SongMetadata;
import haxe.Json;
import lime.utils.Assets;

class Chart
{
    public var songs:String;
    public var chartNote:Array<ChartNotesData>;
    public var events:Array<ChartEventsData>;
    public var bpm:Float;
    public var needsVocals:Bool;
    public var hudSkin:String;
    public var speed:Float = 2;
    public var stage:String = 'mainStage';
    public var dadChar:String = 'dad';
    public var gfChar:String = 'gf';
    public var bfChar:String = 'bf';
    public var format:String = "Funkin': Horizon Engine Chart Editor";

    public function new()
    {
        
    }
}