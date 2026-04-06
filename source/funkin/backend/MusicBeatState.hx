package funkin.backend;

import flixel.FlxState;
import funkin.backend.Conductor;
import funkin.backend.scripting.ScriptManager;

class MusicBeatState extends FlxState
{
	public var conductor:Conductor;
	public var controls(get, never):Controls;
	private function get_controls()
	{
		return Controls.instance;
	}

	public var scripts:ScriptManager;
	public final NO_SCRIPTING_STATES:Array<Dynamic> = [funkin.play.PlayState];

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

		// extension scripts
		if (!NO_SCRIPTING_STATES.contains(Type.getClass(this)))
		{
			scripts = new ScriptManager();
			scripts.loadFromName("scripts/states/" + getClassName());

			scripts.set("add", add);
			scripts.set("remove", remove);
			scripts.set("insert", insert);
			scripts.set("members", members);
		}
    }

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		scripts?.call("onUpdate", [elapsed]);
	}

	public function stepHit(step:Int)
		scripts?.call("onStepHit", [step]);
	public function beatHit(beat:Int)
		scripts?.call("onBeatHit", [beat]);
	public function measureHit(measure:Int)
		scripts?.call("onMeasureHit", [measure]);

	override public function destroy()
	{
		scripts?.destroy();
		super.destroy();
	}

	public function getClassName()
	{
		var thing = Type.getClassName(Type.getClass(this)).split(".");
		return thing[thing.length - 1];
	}
}