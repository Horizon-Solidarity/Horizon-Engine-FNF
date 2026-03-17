package funkin.data.songs;

/**
 * Metadata Main
 */
typedef SongMetadata =
{
    /**
     * Semver System
     * When the major version changes, older charts may become unusable.
     * @default 1.0.0
     */
    var version:String;

    /**
     * Song Name
     * You can also use capital letters and spaces.
     * @default Test
     */
    var songName:String;

    /**
     * BPM Setting
     * @default 150
     */
    var bpm:Float;

    /**
     * Contributor
     * Others than the charter and composer may be included optionally.
     * When there are two or more contributors to a single position,
     * it is best to write it like this:
     * * people1 + people2
     * * people1 (feat. people2 + people3)
     * Visit to typedef [SongCredits]
     */
    var contributor:SongCredits;

    /**
     * Gameplay Data Settings
     * Visit to typedef [SongPlayData]
     */
    var playData:SongPlayData;

    /**
     * Song Generator Info
     * If you're one of those power users who wrote the chart code yourself,
     * you might want to write “People (by hand)”.
     * @default Funkin': Horizon Engine Chart Editor
     */
    var generatedBy:String;
}

// _____________________________ Metadata's Internal Structure _____________________________

/**
 * Contributors Data
 */
typedef SongCredits =
{
    /**
     * Composer
     * @default Unknown
     */
    var music:String;

    /**
     * Charter (and Event Maker)
     * @default Unknown
     */
    var chart:String;

    /**
     * Game Artist (optionally)
     */
    @:optional var art:String;

    /**
     * Game Animator (optionally)
     */
    @:optional var animation:String;

    /**
     * Game Coder (optionally)
     */
    @:optional var code:String;
}

typedef SongPlayData =
{
    /**
     * Chart Difficulties Data
     * The Chart data file names within the same folder indicate their difficulty level,
     * and the file corresponding to the difficulty level written here will be loaded.
     * @default [normal]
     */
    var difficulties:Array<String>;

    /**
     * Song Variations Data
     * If it's not a blank,
     * it will load the folder containing the variation name within the songs folder.
     * If left blank, the default folder will be loaded.
     * @default []
     */
    @:optional var variations:Array<String>;

    /**
     * Song Character Data
     * You can change characters and adjust color tones.
     * Visit to typedef [SongCharacterMetadata]
     */
    var characters:SongCharacterMetadata;

    /**
     * Song Audio Data
     * You can enable split vocals or configure settings to use alternative instruments.
     * Visit to typedef [SongAudioData]
     */
    var audio:SongAudioData;

    /**
     * Song Stage Data
     * You can change the stage for gameplay.
     * @default mainStage
     */
    var stage:String;

    /**
     * Song Start Camera Settings
     * You can set the character to focus on,
     * camera zoom, coordinates, and other settings at Song Start.
     * Visit to typedef [SongStartCamera]
     */
    var startCamera:SongStartCamera;

    /**
     * Gameplay UI Style
     * @default funkin
     */
    @:optional var uiStyle:String;
}

/**
 * Song Character Data
 * Visit to typedef [SongCharacterData]
 */
typedef SongCharacterMetadata =
{
    var opponent:SongCharacterData;
    var center:SongCharacterData;
    var player:SongCharacterData;
}

typedef SongAudioData =
{
    var splitVocals:Bool;
    // var altInst:Array<String>;
}

// ___________________________________ Work In Progress ___________________________________

typedef SongCharacterData =
{
    var id:String;
    // var strumLine:Array<SongStrumLineData>;
    // var color:SongCharColorData;
}

typedef SongStrumLineData =
{
    var enabled:Bool;
    var offsets:Array<Float>;
}

typedef SongStartCamera =
{
    var focus:String;
    var zoom:Float;
}