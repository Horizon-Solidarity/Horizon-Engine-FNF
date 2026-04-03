package funkin.data.play;

import funkin.data.animation.AnimationData;

class NoteskinMetadata
{
    public static inline final DEFAULT_NOTESKIN_ID:String = 'funkin';


    public var name:String;
    @:default("Unknown")
    public var author:String;
    public var folder:String;
    public var assets:NoteskinAssetsData;

    public static inline function fromSkinId(id:String):NoteskinMetadata
	{
		if (Paths.json("noteskins/" + id) == null)
		{
			trace('Noteskin file of $id not found! defaulting to $DEFAULT_NOTESKIN_ID...');
			id = DEFAULT_NOTESKIN_ID;
		}

		var parser = new json2object.JsonParser<NoteskinMetadata>();

		try
		{
			parser.fromJson(File.getContent(Paths.json("noteskins/" + id)));
		}
		catch (e:Dynamic)
		{
			trace('Error loading noteskin file of "$id": $e');
			parser.fromJson(File.getContent(Paths.json("noteskins/" + DEFAULT_NOTESKIN_ID)));
		}

		return parser.value;
	}
}

typedef NoteskinAssetsData =
{
    @:optional var note:NoteskinData;
    @:optional var strumline:NoteskinData;
    @:optional var holdNote:NoteskinData;
    @:optional var noteSplash:NoteskinData;
    @:optional var holdNoteCover:NoteskinData;
}

typedef NoteskinData =
{
    var assetPath:String;
    @:default(1)
    var scale:Float;
    @:default(1)
    var alpha:Float;
    @:default([0, 0])
    var offset:Array<Float>;
    @:default([])
    var animations:Map<String, Array<UnnamedAnimationData>>;
    @:default(true)
    var antialiasing:Bool;
}