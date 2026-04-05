package funkin.play.notes;

import funkin.data.play.NoteTypeData;
import json2object.JsonParser;
import funkin.play.notes.types.ScriptedNoteType;

class NoteType
{
    public static var types:Map<String, NoteType> = [];

    public static function get(type:String):NoteType
    {
        if (types.exists(type))
            return types.get(type);

        if (Paths.json("notetypes/" + type) != null)
        {
            var typeParser = new JsonParser<NoteTypeData>();
            var data:NoteTypeData;
            try
            {
                data = typeParser.fromJson(sys.io.File.getContent(Paths.json("notetypes/" + type)), Paths.json("notetypes/" + type));
            
                var instance = Type.resolveClass(data.path) != null ? Type.createInstance(Type.resolveClass(data.path), []) : new ScriptedNoteType(data.path);
                types.set(type, instance);
                return instance;
            }
            catch (e:Dynamic)
            {
                trace('Error loading notetype of "$type": $e');
                return null;
            }
        }

        trace("Notetype " + type + " not found!");
        return null;
    }

    public var note:Note;

    public function new(){}

    public function noteInit(note:Note){}
    public function noteUpdate(note:Note, elapsed:Float){}
    public function noteHit(note:Note, strumline:Strumline){}
}