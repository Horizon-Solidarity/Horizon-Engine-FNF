package funkin.play.ui.notes;

import funkin.objects.FunkinSprite;
import funkin.data.ui.NoteskinData;
import sys.io.File;

class Receptor extends FunkinSprite
{
	public var lane:Int = 0;

	public function new(lane:Int)
	{
		this.lane = lane;
		super();
	}

	override public function playAnimation(anim:String, force:Bool = false)
    {
        animation.play(anim, force);
		centerOffsets();
		centerOrigin();
		var off = offsets.get(anim);

		if (off != null)
		{
			this.offset.x += off.x;
			this.offset.y += off.y;
		}
    }
}