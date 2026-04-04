package funkin.data.stages;

import funkin.data.character.CharacterData;
import funkin.data.animation.AnimationData;

class StageMetadata
{
    public static inline final DEFAULT_STAGE_ID:String = "stage";


    public var directory:String;
    @:default("Unknown")
    public var name:String;
    public var camera:StageCameraData;
    
    public var characters:StageCharacterMetadata;
    public var props:Array<StagePropData>;


    public static inline function fromStageId(id:String)
	{
		if (Paths.json("stages/" + id) == null)
		{
			trace('Stage file of $id not found! defaulting to $DEFAULT_STAGE_ID...');
			id = DEFAULT_STAGE_ID;
		}

		var parser = new json2object.JsonParser<StageMetadata>();

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

typedef StageCameraData =
{
	@:default(0.7)
    var zoom:Float;
	@:default([0, 0])
    var initialPosition:Array<Float>;
}

typedef BasePropData = {
	var zIndex:Int;
	@:default([0, 0])
    var position:Array<Float>;
	@:default([1, 1])
	var scale:Array<Float>;
}

typedef StageCharacterMetadata =
{
    var player:StageCharacterData;
    var spectator:StageCharacterData;
	var opponent:StageCharacterData;
}

typedef StageCharacterData =
{
	> BasePropData,
	@:default([])
    var cameraOffset:Array<Float>;
}

typedef StagePropData =
{
	> BasePropData,
	var assetPath:String;
	var renderType:CharacterRenderType;
	@:default([1, 1])
	var scrollFactor:Array<Float>;
	@:default(true)
	var antialiasing:Bool;
	@:default([])
	var animations:Array<NamedAnimationData>;
	@:default(false)
	var flipX:Bool;
	@:default(false)
	var flipY:Bool;
}