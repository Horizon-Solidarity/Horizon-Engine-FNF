package funkin.data.play;

import funkin.data.animation.AnimationData;
import funkin.data.play.NoteskinData;

class Judgements
{
    public static final judges:Array<JudgementData> = [
        {
            id: "sick",
            range: 45,
            accuracyMult: 1,
            healthAdd: 1.1,
            showSplash: true
        }
    ];

    public static function judge(data:ChartNoteData, pos:Float = Conductor.instance.songPosition):JudgementData
    {
        var diff = Math.abs(data.time - pos);

        for (judge in judges)
        {
            if (diff <= judge.range)
                return judge;
        }
    }
}

typedef JudgementData = {
    var id:String;
    var range:Float;
    var accuracyMult:Float;
    var healthMult:Float;
    var showSplash:Bool;
}