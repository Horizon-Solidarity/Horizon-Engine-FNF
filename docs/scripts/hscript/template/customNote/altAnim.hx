package template.customNote;

// import funkin.play.ui.notes.types.ScriptedNote;
class AltAnimationsNote // extends ScriptedNote
{
    var singAnim:String = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
	var note:Int;

	public function new()
    {
		super("", singAnim[note] + "-alt");
    }
	override public function onNoteHit(id:Int)
	{
		note = id;
	}
}