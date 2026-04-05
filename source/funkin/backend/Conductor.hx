package funkin.backend;

import flixel.util.FlxSignal;
import funkin.data.songs.SoundTrackData;

/**
 * Represents a change in BPM, time signature, or a linear BPM transition.
 */
typedef BPMChange =
{
	var time:Float;
	var endTime:Float;

	var bpm:Float;
	var endBpm:Float;

	var step:Float;
	var startBeat:Float;
	var startMeasure:Float;

	var beatsPerMeasure:Int;
	var stepsPerBeat:Int;
}

/**
 * The Conductor handles the music timing, tracking beats, steps, and measures.
 * It supports variable BPMs, time signatures, and linear BPM transitions (ramping).
 */
class Conductor extends flixel.FlxBasic {
	// The maximum delay allowed for hitting notes (in milliseconds)
	public static var safeZone:Float = 160;

	public static var instance:Conductor;
	
	// Current Beats Per Minute
	public var bpm:Float = 100;

	// Number of steps in a single beat (typically 4)
	public var stepsPerBeat:Int = 4;
	// Number of beats in a single measure (typically 4)
	public var beatsPerMeasure:Int = 4;

	// Time in milliseconds for a single beat
	public var crochet(get, never):Float;
	function get_crochet() return (60 / bpm) * 1000;
	// Time in milliseconds for a single step
	public var stepCrochet(get, never):Float;
	function get_stepCrochet()
		return crochet / stepsPerBeat;

	// Signals dispatched when the song hits a new step, beat, or measure
	public var onStepHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();
	public var onBeatHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();
	public var onMeasureHit:FlxTypedSignal<Int->Void> = new FlxTypedSignal<Int->Void>();

	// List of scheduled BPM/time signature changes
	public var bpmChanges:Array<BPMChange> = [];

	// Current playback position of the song in milliseconds
	public var songPosition:Float = 0;

	// Current step, beat, and measure indices (integers)
	public var curStep:Int = 0;
	public var curBeat:Int = 0;
	public var curMeasure:Int = 0;

	// Floating-point precision variants of step, beat, and measure
	public var curStepFloat:Float = 0;
	public var curBeatFloat:Float = 0;
	public var curMeasureFloat:Float = 0;

	// The default timing parameters used before the first BPM change
	private var defaultBpmChange:BPMChange = {
		time: 0,
		endTime: Math.POSITIVE_INFINITY,
		bpm: 100,
		endBpm: 100,
		step: 0,
		startBeat: 0,
		startMeasure: 0,
		beatsPerMeasure: 4,
		stepsPerBeat: 4
	};

	override public function new()
	{
		super();
		instance = this;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		var event:BPMChange = defaultBpmChange;

		// Find the active BPM change event based on the current song position
		for (i in 0...bpmChanges.length)
		{
			if (songPosition >= bpmChanges[i].time)
			{
				event = bpmChanges[i];
			}
			else
			{
				break; // The array is sorted by time, so we can stop searching here
			}
		}

		// Calculate how much time has passed since the current BPM change event started
		var timePassed:Float = songPosition - event.time;
		var duration:Float = event.endTime - event.time;

		// Clamp timePassed to avoid negative or out-of-bounds calculations
		if (timePassed < 0)
			timePassed = 0;
		if (timePassed > duration)
			timePassed = duration;

		var currentBpm:Float = event.bpm;

		// Handle linear BPM transitions (ramping) if the start and end BPM differ
		if (event.bpm != event.endBpm && duration > 0 && duration != Math.POSITIVE_INFINITY)
		{
			var ratio:Float = timePassed / duration;
			currentBpm = event.bpm + (event.endBpm - event.bpm) * ratio;
		}

		// Calculate how many beats have passed.
		// For linear transitions, we use the average BPM over the elapsed time to calculate the integral of beats.
		var passedBeats:Float = timePassed * (event.bpm + currentBpm) / (2 * 60000);

		// Update the active BPM
		if (bpm != currentBpm)
			bpm = currentBpm;

		// Update the time signature (steps per beat, beats per measure)
		stepsPerBeat = event.stepsPerBeat;
		beatsPerMeasure = event.beatsPerMeasure;

		// Update the floating-point timing values
		curBeatFloat = event.startBeat + passedBeats;
		curStepFloat = event.step + passedBeats * event.stepsPerBeat;
		curMeasureFloat = event.startMeasure + passedBeats / event.beatsPerMeasure;

		var oldStep:Int = curStep;
		var oldBeat:Int = curBeat;
		var oldMeasure:Int = curMeasure;

		// Update integer timing values
		curStep = Math.floor(curStepFloat);
		curBeat = Math.floor(curBeatFloat);
		curMeasure = Math.floor(curMeasureFloat);

		if (oldStep != curStep)
			onStepHit.dispatch(curStep);
		if (oldBeat != curBeat)
			onBeatHit.dispatch(curBeat);
		if (oldMeasure != curMeasure)
			onMeasureHit.dispatch(curMeasure);
	}

	/**
	 * Parses audio events (e.g., from a track.json) into a pre-calculated list
	 * of BPM changes for performance optimization.
	 */
	public function loadBPMChanges(events:Array<AudioBPMChangesData>)
	{
		bpmChanges = [];
		if (events == null || events.length == 0)
			return;

		// Ensure events are chronologically sorted
		events.sort(function(a, b)
		{
			if (a.time < b.time)
				return -1;
			if (a.time > b.time)
				return 1;
			return 0;
		});

		// Accumulators to track global timing state across consecutive events
		var curSteps:Float = 0;
		var curBeats:Float = 0;
		var curMeasures:Float = 0;

		for (i in 0...events.length)
		{
			var ev = events[i];
			var evTime = ev.time;
			var nextTime = (i < events.length - 1) ? events[i + 1].time : Math.POSITIVE_INFINITY;

			var evStartBpm = ev.bpm;
			// Determines if this BPM change is a ramping/linear transition
			var isLinear = (ev.stepTime != null && ev.stepTime > 0 && ev.endBpm != null && ev.endBpm != ev.bpm);
			var evEndBpm = isLinear ? ev.endBpm : ev.bpm;

			// Inherit time signature fields from previous events if not specified
			var evSteps = (ev.stepsPerBeat != null) ? ev.stepsPerBeat : ((bpmChanges.length == 0) ? 4 : bpmChanges[bpmChanges.length - 1].stepsPerBeat);
			var evBeats = (ev.beatsPerMeasure != null) ? ev.beatsPerMeasure : ((bpmChanges.length == 0) ? 4 : bpmChanges[bpmChanges.length - 1].beatsPerMeasure);

			var linearEndTime = evTime;
			if (isLinear)
			{
				// Calculate duration in ms using the integral of the linear BPM transition
				var beatsToInterpolate = ev.stepTime / evSteps;
				var durMs = (beatsToInterpolate * 120000) / (evStartBpm + evEndBpm);
				linearEndTime = evTime + durMs;
			}

			// Add the primary BPM change event (could be a flat change or ramping segment)
			var newChange:BPMChange = {
				time: evTime,
				endTime: isLinear ? linearEndTime : nextTime,
				bpm: evStartBpm,
				endBpm: evEndBpm,
				step: curSteps,
				startBeat: curBeats,
				startMeasure: curMeasures,
				stepsPerBeat: evSteps,
				beatsPerMeasure: evBeats
			};
			bpmChanges.push(newChange);

			// Provide a follow-up "flat" BPM event if this is the last event but it ramps linearly and then ends
			if (isLinear && nextTime == Math.POSITIVE_INFINITY)
			{
				var linearDur = linearEndTime - evTime;
				var passedBeatsLinear = linearDur * (evStartBpm + evEndBpm) / 120000.0;
				var flatChange:BPMChange = {
					time: linearEndTime,
					endTime: Math.POSITIVE_INFINITY,
					bpm: evEndBpm,
					endBpm: evEndBpm,
					step: curSteps + passedBeatsLinear * evSteps,
					startBeat: curBeats + passedBeatsLinear,
					startMeasure: curMeasures + passedBeatsLinear / evBeats,
					stepsPerBeat: evSteps,
					beatsPerMeasure: evBeats
				};
				bpmChanges.push(flatChange);
			}

			// Accumulate absolute time steps to start the next event accurately
			if (nextTime != Math.POSITIVE_INFINITY)
			{
				var durToNext = nextTime - evTime;

				// Case 1: A linear change finishes before the next event begins
				if (isLinear && linearEndTime < nextTime)
				{
					var linearDur = linearEndTime - evTime;
					var passedBeatsLinear = linearDur * (evStartBpm + evEndBpm) / 120000.0;

					var flatCurBeats = curBeats + passedBeatsLinear;
					var flatCurSteps = curSteps + passedBeatsLinear * evSteps;
					var flatCurMeasures = curMeasures + passedBeatsLinear / evBeats;

					// Push a bridging flat event right after the linear transition completes
					var flatChange:BPMChange = {
						time: linearEndTime,
						endTime: nextTime,
						bpm: evEndBpm,
						endBpm: evEndBpm,
						step: flatCurSteps,
						startBeat: flatCurBeats,
						startMeasure: flatCurMeasures,
						stepsPerBeat: evSteps,
						beatsPerMeasure: evBeats
					};
					bpmChanges.push(flatChange);

					var flatDur = nextTime - linearEndTime;
					var passedBeatsFlat = flatDur * evEndBpm / 60000.0;

					curBeats = flatCurBeats + passedBeatsFlat;
					curSteps = flatCurSteps + passedBeatsFlat * evSteps;
					curMeasures = flatCurMeasures + passedBeatsFlat / evBeats;
				}
				// The next event truncates an ongoing linear transition
				else if (isLinear)
				{
					var ratio = durToNext / (linearEndTime - evTime);
					var bpmAtNext = evStartBpm + (evEndBpm - evStartBpm) * ratio;
					var passedBts = durToNext * (evStartBpm + bpmAtNext) / 120000.0;

					curBeats += passedBts;
					curSteps += passedBts * evSteps;
					curMeasures += passedBts / evBeats;
				}
				// A standard flat BPM plays normally until the next event
				else
				{
					var passedBts = durToNext * evStartBpm / 60000.0;

					curBeats += passedBts;
					curSteps += passedBts * evSteps;
					curMeasures += passedBts / evBeats;
				}
			}
		}

		// Initialize default timings from the first BPM change event
		if (bpmChanges.length > 0)
		{
			var first = bpmChanges[0];
			defaultBpmChange.bpm = first.bpm;
			defaultBpmChange.endBpm = first.bpm;
			defaultBpmChange.beatsPerMeasure = first.beatsPerMeasure;
			defaultBpmChange.stepsPerBeat = first.stepsPerBeat;

			bpm = first.bpm;
			beatsPerMeasure = first.beatsPerMeasure;
			stepsPerBeat = first.stepsPerBeat;
		}
	}
}