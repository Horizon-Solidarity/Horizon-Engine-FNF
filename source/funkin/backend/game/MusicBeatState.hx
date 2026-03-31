package funkin.backend.game;

import flixel.FlxState;

class MusicBeatState extends FlxState
{
	private var curStep:Int = 0;
	private var curBeat:Int = 0;

	private var curDecStep:Float = 0;
	private var curDecBeat:Float = 0;

	public var controls(get, never):Controls;
	private function get_controls()
	{
		return Controls.instance;
	}
	public static var timePassedOnState:Float = 0;

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
		var oldStep:Int = curStep;
		timePassedOnState += elapsed;

		updateBeat();

		if (oldStep != curStep)
		{
			if (curStep > 0)
				stepHit();
		}

        super.update(elapsed);
    }

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
		curDecBeat = curDecStep / 4;
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void {}


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