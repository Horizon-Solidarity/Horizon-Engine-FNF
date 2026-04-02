package funkin.data.stages;

class StageMetadata
{
    public static inline final DEFAULT_STAGE_ID:String = "stage";


    var directory:String;
    @:default("Unknown")
    var name:String;
    @:default(1.1)
    var cameraSpeed:Float;
    @:default(0.7)
    var cameraZoom:Float;
    
    var character:StageCharacterMetadata;
    // var props:Array<StagePropsData>;

    public static inline function fromStageId(id:String)
	{
		if (Paths.json("stages/" + id) == null)
		{
			trace('Stage file of $id not found! defaulting to $DEFAULT_STAGE_ID...');
			id = DEFAULT_STAGE_ID;
		}

		var parser = new json2object.JsonParser<CharacterMetadata>();

		try
		{
			parser.fromJson(File.getContent(Paths.json("stages/" + id)));
		}
		catch (e:Dynamic)
		{
			trace('Error loading stage file of "$id": $e');
			parser.fromJson(File.getContent(Paths.json("stages/" + DEFAULT_STAGE_ID)));
		}

		return parser.value;
	}
}

typedef StageCharacterMetadata =
{
    var player:StageCharacterData;
    var opponent:StageCharacterData;
    var spectator:StageCharacterData;
}

typedef StageCharacterData =
{
    var zIndex:Int;
    var position:Array<Float>;
    var cameraPos:Array<Float>;
}