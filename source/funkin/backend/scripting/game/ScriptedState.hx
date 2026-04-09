package funkin.backend.scripting.game;

class ScriptedState extends MusicBeatState
{
    public function new()
    {
        super();
        
        scripts.call("onLoad");
    }
}