package funkin.backend.game;

import flixel.FlxState;

class MusicBeatState extends FlxState
{
	public var controls(get, never):Controls;
	private function get_controls()
	{
		return Controls.instance;
	}
    public function new()
    {
        super();
    }

    override function create()
    {
        super.create();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }

    /*
    public function switchState(nextState:FlxState = null)
    {
		if(nextState == null) nextState = FlxG.state;
		if(nextState == FlxG.state)
		{
			resetState();
			return;
		}

		if(FlxTransitionableState.skipNextTransIn) FlxG.switchState(nextState);
		// else startTransition(nextState);
		FlxTransitionableState.skipNextTransIn = false;
    }

	public static function resetState() {
		if(FlxTransitionableState.skipNextTransIn) FlxG.resetState();
		// else startTransition();
		FlxTransitionableState.skipNextTransIn = false;
	}
        */
}