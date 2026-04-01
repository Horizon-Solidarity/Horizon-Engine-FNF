package funkin.play.songs;

import funkin.data.songs.SongData;
import funkin.data.songs.SongMeta;
import haxe.Json;
import lime.utils.Assets;

enum abstract ChartFormat(String) to String
{
	var Vslice = 'Friday Night Funkin\' - 0.8.3';
	var Psych = 'Psych Engine - 1.0';
	var PELegacy = 'Psych Engine - 0.6.3';
	var Psychness = 'Psychness Engine - 0.5.1';
	var Codename = 'CODENAME - 1.0.1';
	var Nightmare = 'NightmareVision - develop';
	var FPSPlus = 'FPSPlus - 8.2.0';
	var Horizon = 'Funkin\': Horizon Engine (alpha) - Chart Editor';
}

enum abstract CharacterType(String) to String
{
	var OPPONENT = 'opponent';
	var CENTER = 'center';
	var PLAYER = 'player';
}

class Song
{
	public static final DEFAULT_CHART_FORMAT:ChartFormat = ChartFormat.Horizon;
	public static final HORIZON_CONVERTED:String = ' - Converted by: Horizon Engine (alpha) - Chart Editor';

    final _metadata:SongMetadata;
    final _chartData:ChartDataInfo;
    final _trackData:SoundTrackMetadata;
    // final _difficulties:Map<String, SongDifficulty>;
    final _variations:Map<String, SongVariationData>;

    public var songName:String = 'Unknown SongName';
    public var musicians:String = 'Unknown Musician';
    public var charters:String = 'Unknown Charter';
    public var artists:String = '';
    public var animaters:String = '';
    public var coders:String = '';

    public var focusChar:Int = 0;
    public var camZoom:Float = 1.00;
    
    public var hudSkin:String = 'funkin';
    
    public var stage:String = 'mainStage';

    public var dadChar:String = 'dad';
    public var gfChar:String = 'gf';
    public var bfChar:String = 'bf';

    public var difficulty:Array<String> = ['Easy', 'Normal', 'Hard'];

    public var covers:Array<String> = [];

    public var extraDifficulties:Array<String> = [];

    public var chartNote:Array<ChartNotesData>;
    public var events:Array<ChartEventsData>;
    public var bpm:Float = 150;
    public var needsVocals:Bool = true;
    public var speed:Float = 2;
	public var format:ChartFormat = DEFAULT_CHART_FORMAT;

    public function new()
    {
        
    }
}