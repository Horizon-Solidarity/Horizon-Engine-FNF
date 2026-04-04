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
            healthGain: 0.25,
            scoreGain: 300,
            showSplash: true
        },
        {
            id: "good",
            range: 90,
            accuracyMult: 0.85,
            healthGain: 0.1,
            scoreGain: 200,
            showSplash: false
        },
        {
            id: "bad",
            range: 135,
            accuracyMult: 0.45,
            healthGain: -0.06,
            scoreGain: 100,
            showSplash: false
        },
        {
            id: "shit",
            range: 180,
            accuracyMult: 0.3,
            healthGain: -0.1,
            scoreGain: 10,
            showSplash: false
        }
    ];

    public static function get(id:String):JudgementData
    {
        for (judge in judges)
        {
            if (judge.id == id)
                return judge;
        }
        return null;
    }

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
    var healthGain:Float;
    var scoreGain:Float;
    var showSplash:Bool;
}