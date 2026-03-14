package funkin.data.songs;

import funkin.data.songs.SongData;
import funkin.data.songs.SongMetadata;
import haxe.Json;
import lime.utils.Assets;

enum abstract ChartFormat(String) to String
{
	var Vslice = "Friday Night Funkin' - 0.8.3";
	var Psych = 'Psych Engine - 1.0';
	var PELegacy = 'Psych Engine - 0.6.3';
	var Psychness = 'Psychness Engine - 0.5.1';
	var Codename = 'CODENAME - 1.0.1';
	var Nightmare = 'NightmareVision - develop';
	var FPSPlus = "FPSPlus - 8.2.0";
	var Horizon = "Funkin': Horizon Engine (alpha) - Chart Editor";
}

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
	public var format:ChartFormat = DEFAULT_CHART_FORMAT;

	public static final DEFAULT_CHART_FORMAT:ChartFormat = ChartFormat.Horizon;
	public static final HORIZON_CONVERTED:String = " - Converted by: Horizon Engine (alpha) - Chart Editor";

    public function new()
    {
        
    }
}