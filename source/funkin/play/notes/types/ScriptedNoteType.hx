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
        for (ext in ScriptManager.LUA_EXTENSIONS.concat(ScriptManager.HSCRIPT_EXTENSIONS))
            scripts.loadFromFile("scripts/play/notetypes/" + type + "." + ext, this, true, false);
        scripts.call("onLoad");
    }

    override public function noteInit(note:Note)
        scripts.call("onNoteInit", [note]);
    override public function noteUpdate(note:Note, elapsed:Float)
        scripts.call("onNoteUpdate", [note, elapsed]);
    override public function noteHit(note:Note, strumline:Strumline)
        scripts.call("onNoteHit", [note, strumline]);
}