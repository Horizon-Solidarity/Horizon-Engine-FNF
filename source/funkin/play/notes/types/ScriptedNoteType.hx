package funkin.play.notes.types;

import funkin.backend.scripting.ScriptManager;

class ScriptedNoteType extends NoteType
{
    public var scripts:ScriptManager;

    public function new(type:String)
    {
        super();

        scripts = new ScriptManager();
        scripts.customPreset = PlayState.instance.presetScript;
        scripts.loadFromName("scripts/play/notetypes/" + type, this, true, false);
        scripts.call("onLoad");
    }

    override public function noteInit(note:Note)
        scripts.call("onNoteInit", [note]);
    override public function noteUpdate(note:Note, elapsed:Float)
        scripts.call("onNoteUpdate", [note, elapsed]);
    override public function noteHit(note:Note, strumline:Strumline)
        scripts.call("onNoteHit", [note, strumline]);
}