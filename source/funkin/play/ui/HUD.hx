package funkin.play.ui;

import funkin.backend.scripting.ScriptManager;

class HUD extends FlxSpriteGroup
{
    public var game(get, never):PlayState;
    function get_game() return PlayState.instance;

    public function new():Void
    {
        super();

        Conductor.instance.onStepHit.add(stepHit);
        Conductor.instance.onBeatHit.add(beatHit);
		Conductor.instance.onMeasureHit.add(measureHit);

        load();
    }

    public function load():Void{}

    public function stepHit(step:Int){}
    public function beatHit(beat:Int){}
    public function measureHit(measure:Int){}
}