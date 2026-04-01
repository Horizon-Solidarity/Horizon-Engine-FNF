package funkin.backend.game;

import flixel.FlxState;
import funkin.backend.Conductor;

class MusicBeatState extends FlxState
{
	public var conductor:Conductor;
	public var controls(get, never):Controls;
	private function get_controls()
	{
		return Controls.instance;
	}

    override function create()
    {
        super.create();

		conductor = new Conductor();
		add(conductor);

		conductor.onStepHit.add(stepHit);
		conductor.onBeatHit.add(beatHit);
    }

	public function stepHit(step:Int){}
	public function beatHit(beat:Int){}
}