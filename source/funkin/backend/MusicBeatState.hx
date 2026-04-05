package funkin.backend;

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
		conductor.onMeasureHit.add(measureHit);

		FlxG.signals.preStateSwitch.addOnce(() ->
		{
			funkin.cache.ImageCache.destroyByCount();
			funkin.util.FunkinAssets.clearSparrowCache();
			openfl.system.System.gc();
		});
    }

	public function stepHit(step:Int){}
	public function beatHit(beat:Int){}
	public function measureHit(measure:Int) {}
}