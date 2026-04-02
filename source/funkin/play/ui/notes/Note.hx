package funkin.play.ui.notes;

import funkin.data.songs.SongData;
import funkin.data.ui.NoteskinData;
import funkin.objects.FunkinSprite;

enum NoteState
{
	NORMAL;
	HIT;
	HITTABLE;
	HOLDING;
	MISSED;
}

class Note extends FunkinSprite
{
	public var skin(default, set):NoteskinMetadata;
	public var data:ChartNoteData;

	public var strumline:Strumline;

	public var state:NoteState = NORMAL;

	public var animSuffix:String = "";

	public function new(strumline:Strumline, data:ChartNoteData, skin:NoteskinMetadata)
	{
		super();

		this.strumline = strumline;
		this.data = data;
		this.skin = skin;
    }

	function set_skin(value:NoteskinMetadata)
	{
		skin = value;

		frames = FunkinAssets.getSparrow(haxe.io.Path.join([skin.folder, skin.assets.note.assetPath]));
		scale.set(skin.assets.note.scale, skin.assets.note.scale);
		alpha = skin.assets.note.alpha;
		antialiasing = skin.assets.note.antialiasing;

		offset.set(skin.assets.note.offset[0], skin.assets.note.offset[1]);

		this.addAnimationData("default", skin.assets.note.animations.get(strumline.directions[data.lane])[0]);
		this.playAnimation("default");

		updateHitbox();
		centerOrigin();

		return value;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (state == HIT || state == MISSED || Conductor.instance == null || data == null)
			return;
		if (data.time > Conductor.instance.songPosition - Conductor.safeZone && data.time < Conductor.instance.songPosition + Conductor.safeZone)
			state = HITTABLE;
		else if (data.time < Conductor.instance.songPosition - Conductor.safeZone)
			state = MISSED;
	}
}