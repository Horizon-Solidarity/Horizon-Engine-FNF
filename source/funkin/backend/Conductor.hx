package funkin.backend;

import flixel.util.FlxSignal.FlxTypedSignal;

typedef BPMChange = {
	var bpm:Float;
	var time:Float;
	var step:Float;
}

class Conductor extends flixel.FlxBasic {
	public static var safeZone:Float = 160;

	public static var instance:Conductor;
	
	public var bpm:Float = 100;

	public var crochet(get, never):Float;
	function get_crochet() return (60 / bpm) * 1000;
	public var stepCrochet(get, never):Float;
	function get_stepCrochet() return crochet / 4;

	public var onStepHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();
	public var onBeatHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();

	public var bpmChanges:Array<BPMChange> = [];

	public var songPosition:Float = 0;

	public var curStep:Int = 0;
	public var curBeat:Int = 0;

	override public function new()
	{
		super();
		instance = this;
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