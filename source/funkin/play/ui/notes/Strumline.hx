package funkin.play.ui.notes;

import funkin.data.ui.NoteskinData;
import funkin.data.songs.SongData;

import flixel.util.FlxSignal;
import sys.io.File;
import haxe.io.Path;

class Strumline extends FlxTypedSpriteGroup<Receptor>
{
	public static final DEFAULT_NOTE_SKIN:String = 'funkin';

	public var skin:NoteskinMetadata
	public var skinId(set, default):String

	public var directions:Array<String> = ["left", "down", "up", "right"];
	public var mania(set, default):Int;
	public var noteSpawnDistance:Float = 3000;

	public var inputs:Array<String> = ["note_left", "note_down", "note_up", "note_right"];

	public var botplay:Bool;
	public var downscroll:Bool;
	public var speed:Float;

	public var receptors:Array<Receptor> = [];
	public var notes:Array<Note> = [];

	public var noteQueue:Array<ChartNoteData> = [];

	public var onNoteHit:FlxTypedSignal<Note->Void> = new FlxTypedSignal()<Note->Void>;
	public var onNoteMiss:FlxTypedSignal<Note->Void> = new FlxTypedSignal()<Note->Void>;

	public function new(x:Float, y:Float, skin:String = DEFAULT_NOTE_SKIN, botplay:Bool = false, downscroll:Bool = false, speed:Float = 1)
	{
		super(x, y);

		this.skinId = skin;

		this.botplay = botplay;
		this.downscroll = downscroll;
		this.speed = speed;

		mania = 4;
	}

	public function addNoteQueue(queue:ChartNoteData):Void
	{
		noteQueue.push(queue);
		noteQueue.sort(function(i, a, b)
		{
			if (a.time > b.time)
				return -1;
			else
				return 1;
		});
	}

	public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function set_skinId(value:String):String
	{
		skinId = value;
		if (Paths.json("ui/noteskins" + skinId) == null)
			skinId = DEFAULT_NOTE_SKIN;
		var parser = new json2object.JsonParser<NoteskinData>();
		parser.fromJson(File.getContent(Paths.json("ui/noteskins" + skinId)));
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
			receptor.frames = FunkinAssets.getSparrow(Path.join([skin.folder, skin.strumline.assetPath]));
			receptor.scale.set(skin.strumline.scale, skin.strumline.scale);
			receptor.alpha = skin.strumline.alpha;

			receptor.x = ((160 * 0.7) * i) + skin.strumline.offset[0];
			receptor.y = skin.strumline.offset[0];

			receptor.addAnimationData("static", skin.strumline.animations.get(directions[i] + "Static")[0]);
			receptor.addAnimationData("pressed", skin.strumline.animations.get(directions[i] + "Press")[0]);
			receptor.addAnimationData("confirm", skin.strumline.animations.get(directions[i] + "Confirm")[0]);

			receptor.playAnimation("static");

			receptors.push(receptor);
			add(receptor);
		}

		return mania;
	}
}