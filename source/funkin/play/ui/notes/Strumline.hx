package funkin.play.ui.notes;

import funkin.objects.FunkinSprite;
import funkin.data.ui.NoteskinData;
import funkin.data.songs.SongData;

import flixel.util.FlxSignal;
import sys.io.File;
import haxe.io.Path;

class Strumline extends FlxTypedSpriteGroup<FunkinSprite>
{
	public static inline final DEFAULT_NOTE_SKIN:String = 'funkin';

	public var skin:NoteskinMetadata;
	public var skinId(default, set):String;

	public var directions:Array<String> = ["left", "down", "up", "right"];
	public var mania(default, set):Int;
	public var noteSpawnDistance:Float = 3000;

	public var inputs:Array<String> = ["note_left", "note_down", "note_up", "note_right"];

	public var botplay:Bool;
	public var downscroll:Bool;
	public var speed:Float;

	public var receptors:Array<Receptor> = [];
	public var notes:Array<Note> = [];

	public var noteQueue:Array<ChartNoteData> = [];

	public var onNoteHit:FlxTypedSignal<Note->Void> = new FlxTypedSignal<Note->Void>();
	public var onNoteMiss:FlxTypedSignal<Null<Note>->Void> = new FlxTypedSignal<Null<Note>->Void>();

	public function new(skin:String = DEFAULT_NOTE_SKIN, botplay:Bool = false, downscroll:Bool = false, speed:Float = 1)
	{
		super();

		this.skinId = skin;

		this.botplay = botplay;
		this.downscroll = downscroll;
		this.speed = speed;

		mania = 4;
	}

	public function addNoteQueue(queue:ChartNoteData):Void
	{
		noteQueue.push(queue);
		noteQueue.sort(function(a, b)
		{
			if (a.time < b.time)
				return -1;
			else
				return 1;
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (noteQueue.length > 0)
		{
			if (noteQueue[0].time - Conductor.instance.songPosition < noteSpawnDistance)
			{
				var data = noteQueue[0];
				noteQueue.remove(data);

				var note = new Note(this, data, skin);
				add(note);
				notes.push(note);
			}
		}

		members.sort(function(a, b)
		{
			if (a is Receptor)
				return -1;
			else if (a is Note && b is Note)
			{
				if (cast(a, Note).data.time > cast(b, Note).data.time)
					return -1;
				else
					return 1;
			}
			return -1;
		});

		for (note in notes)
		{
			if (note.state != HIT)
			{
				var targetX:Float = receptors[note.data.lane].x + 25; // wtf
				var targetY:Float = receptors[note.data.lane].y + 0.45 * (Conductor.instance.songPosition - note.data.time) * speed * (downscroll ? 1 : -1);
				note.setPosition(targetX, targetY);
				
				if (botplay && note.data.time <= Conductor.instance.songPosition)
					noteHit(note);
			}
		}
		
		// INPUT HANDLING
		for (i in 0...directions.length)
		{
			if (!botplay && Controls.instance.justPressed(inputs[i]))
			{
				var targetNote:Note = null;
				for (note in notes)
					if (note.state == HITTABLE && note.data.lane == i)
					{
						targetNote = note;
						break;
					}
				if (targetNote != null)
					noteHit(targetNote);
				else
				{
					receptors[i].playAnimation("pressed");
					if (!ClientPrefs.data.ghostTapping)
						noteMiss(null);
				}
			}
			else if ((receptors[i].animation.finished && botplay) || Controls.instance.justReleased(inputs[i]))
				receptors[i].playAnimation("static");
		}
	}

	public function noteHit(note:Note)
	{
		receptors[note.data.lane].playAnimation("confirm", true);

		onNoteHit.dispatch(note);

		notes.remove(note);
		note.destroy();
	}

	public function noteMiss(note:Null<Note>)
	{
		onNoteHit.dispatch(note);
		if (note != null)
		{
			notes.remove(note);
			note.destroy();
		}
	}

	function set_skinId(value:String):String
	{
		skinId = value;
		if (Paths.json("ui/noteskins" + skinId) == null)
			skinId = DEFAULT_NOTE_SKIN;
		var parser = new json2object.JsonParser<NoteskinMetadata>();
		parser.fromJson(File.getContent(Paths.json("ui/noteskins/" + skinId)));
		skin = parser.value;
		return skinId;
	}

	function set_mania(value:Int):Int
	{
		if (mania == value)
			return mania;
		mania = value;
		
		for (receptor in receptors)
			receptor.destroy();
		receptors = [];

		for (i in 0...mania)
		{
			var receptor = new Receptor(i);
			receptor.frames = FunkinAssets.getSparrow(Path.join([skin.folder, skin.assets.strumline.assetPath]));
			receptor.scale.set(skin.assets.strumline.scale, skin.assets.strumline.scale);
			receptor.alpha = skin.assets.strumline.alpha;
			receptor.antialiasing = skin.assets.strumline.antialiasing;


			receptor.addAnimationData("static", skin.assets.strumline.animations.get(directions[i] + "Static")[0]);
			receptor.addAnimationData("pressed", skin.assets.strumline.animations.get(directions[i] + "Press")[0]);
			receptor.addAnimationData("confirm", skin.assets.strumline.animations.get(directions[i] + "Confirm")[0]);

			receptor.playAnimation("static");
			receptor.updateHitbox();

			receptor.x += ((160 * skin.assets.strumline.scale) * i) + skin.assets.strumline.offset[0];
			receptor.y += skin.assets.strumline.offset[1];

			receptors.push(receptor);
			add(receptor);
		}

		return mania;
	}
}