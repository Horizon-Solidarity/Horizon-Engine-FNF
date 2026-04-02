package notes;

import funkin.play.ui.notes.types.ScriptedNote;

class AltAnimationsNote extends ScriptedNote
{
    var singAnim:String = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

    public function new(note:Int)
    {
		super("", singAnim[note] + "-alt");
    }
}