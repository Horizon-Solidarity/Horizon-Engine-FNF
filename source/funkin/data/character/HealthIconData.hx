package funkin.data.character;

import funkin.data.animation.AnimationData;

enum abstract HealthIconRenderType(String) from String to String
{
	/***
	* Renders the health icon using a sliced single graphic. (Used on Basegame)
	*/
	public var Slice = 'slice';
	
	/**
   	* Renders the health icon using a multiple graphic by state.
   	*/
	public var Multiple = 'multiple';
	/**

	* Renders the health icon using a single spritesheet and XML data.
	*/
	public var Sparrow = 'sparrow';

	/**
	* Renders the health icon using a single spritesheet of symbols and JSON data.
	*/
	public var AnimateAtlas = 'animateatlas';

	/**
	* Renders the health icon using a custom method.
	*/
	public var Custom = 'custom';
}

class HealthIconMetadata
{
	public static inline final DEFAULT_ICON_ID:String = "face";

	public var renderType:HealthIconRenderType;

	@:default(false)
	public var hasWinning:Bool;

	/**
	 * @default [[1.0,1.0]]
	 */
	@:default([1, 1])
	public var scale:Array<Float>;

	/**
	 * @default [0.0]
	 */
	@:default(0)
	public var angle:Float;

	/**
	 * @default [false]
	 */
	@:default(false)
	public var flipX:Bool;

	/**
	 * @default [false]
	 */
	@:default(false)
	public var flipY:Bool;

	/**
	 * @default [[0.0,0.0]]
	 */
	@:default([0, 0])
	public var offset:Array<Float>;
	/**
	 * @default [true]
	 */
	@:default(true)
	public var antialiasing:Bool;

	@:default([])
    public var animations:Array<NamedAnimationData>;


	public static inline function fromIconId(id:String)
	{
		if (Paths.json("metadata", "images/icons/" + id) == null)
		{
			trace('Healthicon metadata file of $id not found! defaulting to $DEFAULT_ICON_ID...');
			id = DEFAULT_ICON_ID;
		}

		var parser = new json2object.JsonParser<HealthIconMetadata>();

		try
		{
			parser.fromJson(File.getContent(Paths.json("metadata", "images/icons/" + id)));
		}
		catch (e:Dynamic)
		{
			trace('Error loading Healthicon metadata file of "$id": $e');
			parser.fromJson(File.getContent(Paths.json("metadata", "images/icons/" + DEFAULT_ICON_ID)));
		}

		return parser.value;
	}
}