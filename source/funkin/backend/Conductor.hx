package funkin.backend;

import mogato.song.formats.ChartFormat;
import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.system.FlxSound;

typedef BPMChange = {
	var bpm:Float;
	var time:Float;
	var step:Float;
}

class Conductor extends flixel.FlxBasic {
	public static var safeZone:Float = 160;

	public static var instance:Conductor;
	
	public var bpm(default, set):Float = 100;
	private function set_bpm(newBPM:Float) {
		crochet = (60 / newBPM) * 1000;
		stepCrochet = crochet / 4;
		return bpm = newBPM;
	}

	public var crochet:Float = 0;
	public var stepCrochet:Float = 0;

	public var onStepHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();
	public var onBeatHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();

	public var bpmChanges:Array<BPMChange> = [];

	public var songPosition:Float = 0;

	public var curStep:Int = 0;
	public var curBeat:Int = 0;

	override public function new(song:ChartFormat)
	{
		super();

		instance = this;

		bpmChanges = [];

		var time:Float = 0;
		var step:Float = 0;

		bpm = song.bpm;
		crochet = (60 / bpm) * 1000;
		stepCrochet = crochet / 4;

		for(e in song.events) {
			if(e.name == "BPM Change") {
				if(Std.parseFloat(e.data.bpm) == song.bpm) continue;

				var steps:Float = (e.time - time) / ((60 / song.bpm) * 1000 / 4);
				step += steps;
				time = e.time;
				song.bpm = e.data.bpm;

				bpmChanges.push({
					step: step,
					time: time,
					bpm: song.bpm
				});
			}
		}
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		var songPos:Float = songPosition;
		var bpmChange:BPMChange = {step: 0, time: 0, bpm: 0};
		for (event in bpmChanges) {
			if (songPos >= event.time) {
				bpmChange = event;
				break;
			}
		}

		if (bpmChange.bpm > 0 && bpm != bpmChange.bpm)
			bpm = bpmChange.bpm;

		var oldStep:Int = curStep;
		curStep = Math.floor((bpmChange.step + (songPos - bpmChange.time) / stepCrochet));

		var oldBeat:Int = curBeat;
		curBeat = Math.floor(curStep / 4);

		if(oldStep != curStep)
			onStepHit.dispatch(curStep);
		if (oldBeat != curBeat)
			onBeatHit.dispatch(curBeat);
	}
}