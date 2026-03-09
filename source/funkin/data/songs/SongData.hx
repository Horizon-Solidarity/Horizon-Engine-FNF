package funkin.data.songs;

typedef ChartDataInfo =
{
    var songs:ChartDataMain;
}

typedef ChartDataMain =
{
    var scrolSpeed:Float;
    var vocalsEnabled:Bool;
    var events:Array<ChartEventsData>;
    var notes:Array<ChartNotesData>;
}

typedef ChartEventsData =
{
    var TIME:Float;
    var NAME:String;
    var DATA:Array<Dynamic>;
}

typedef ChartNotesData =
{
    var TIME:Float;
    var ID:Int;
    var LENGTH:Float;
    var DATA:String;
}
