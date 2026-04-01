package template.customState;

// package play;
// import custom.CustomResultState;

public var _resultEnds:Bool = false;

function onEndSong()
{
    return Function_Stop;

    ScriptedState.switchState('CustomResultState', [true, songName, charId, newHighscore, practice])
    if (_resultEnds)
        return Function_Continue;
}

// package custom.results;
class CustomResultState extends ScriptedState
{
    public function new()
    {
        super('CustomResultState');
        
        // TODO: ResultsState Customizable
        _resultEnds = true;
    }

    override public function onCreate()
    {
        super.onCreate();
        _resultEnds = false;
    }

    override public function onDestroy()
    {
        super.onDestroy();
    }
}