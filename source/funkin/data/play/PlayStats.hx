package funkin.data.play;

class PlayStats
{
    public var sicks:Int = 0;
    public var goods:Int = 0;
    public var bads:Int = 0;
    public var shits:Int = 0;

    public var score:Float = 0;
    public var misses:Int = 0;
    public var accuracy(get, never):Float;
    function get_accuracy()
    {
        return (((sicks * Judgements.get("sick").accuracyMult) + (goods * Judgements.get("good").accuracyMult) + (bads * Judgements.get("bad").accuracyMult) + (shits * Judgements.get("shit").accuracyMult)) / everyNotes) * 100;
    }

    var everyNotes(get, never):Float;
    function get_everyNotes() return sicks + goods + bads + shits + misses;

    public function new(){}
}