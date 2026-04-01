package funkin.play.ui.notes;

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
}