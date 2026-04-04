package funkin.data.play;

import funkin.data.animation.AnimationData;
import funkin.data.play.NoteskinData;
import funkin.data.songs.SongData;

class Judgements
{
    public static final judges:Array<JudgementData> = [
        {
            id: "sick",
            range: 45,
            accuracyMult: 1,
            healthMult: 1.1,
            showSplash: true
        }
    ];

    public static function judge(data:ChartNoteData, ?pos:Float):JudgementData
    {
        if (pos == null) pos = Conductor.instance.songPosition;
        var diff = Math.abs(data.time - pos);

        for (judge in judges)
        {
            if (diff <= judge.range)
                return judge;
        }

        return judges[0];
    }
}

typedef JudgementData = {
    var id:String;
    var range:Float;
    var accuracyMult:Float;
    var healthMult:Float;
    var showSplash:Bool;
}