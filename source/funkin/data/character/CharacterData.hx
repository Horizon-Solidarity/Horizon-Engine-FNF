package funkin.data.character;

import funkin.data.AnimationData;

enum abstract CharacterRenderType(String) from String to String
{
  /**
   * Renders the character using a single graphic.
   */
    public var Image = 'image';
  /**
   * Renders the character using a single spritesheet and XML data.
   */
    public var Sparrow = 'sparrow';

  /**
   * Renders the character using a single spritesheet and TXT data.
   */
    public var Packer = 'packer';

  /**
   * Renders the character using multiple spritesheets and XML data.
   */
    public var MultiSparrow = 'multisparrow';

  /**
   * Renders the character using a single spritesheet of symbols and JSON data.
   */
    public var AnimateAtlas = 'animateatlas';

  /**
   * Renders the character using multiple spritesheets of symbols and JSON data.
   */
    public var MultiAnimateAtlas = 'multianimateatlas';

  /**
   * Renders the character using a custom method.
   */
    public var Custom = 'custom';
}

class CharacterMetadata
{
	public static inline final DEFAULT_CHARACTER_ID:String = "bf";


    public var name:String;

    public var assetPath:String;

    public var renderType:CharacterRenderType;

	@:default([0, 0])
    public var offset:Array<Float>;

	@:default([0, 0])
    public var cameraOffset:Array<Float>;

	@:default({id: "face", bar: {colored: false}})
	public var healthIcon:HealthiconData;

	@:default([])
    public var animations:Array<NamedAnimationData>;

    /**
     * @default [true]
     */
	@:default(true)
    public var antialiasing:Bool;

    /**
     * @default [[1.0,1.0]]
     */
	@:default([1, 1])
    public var scale:Array<Float>;

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
     * @default [2]
     */
	@:default(["idle"])
    public var danceAnimations:Array<Null<String>>;

    /**
     * @default [false]
     */
	@:default(false)
    public var loopOnHold:Bool;

    /**
     * @default [true]
     */
	@:default(true)
    public var doubleGhost:Bool;

	public static inline function fromCharacterId(id:String)
	{
		if (Paths.json("characters/" + id) == null)
		{
			trace('Character file of $id not found! defaulting to $DEFAULT_CHARACTER_ID...');
			id = DEFAULT_CHARACTER_ID;
		}

		var parser = new json2object.JsonParser<CharacterMetadata>();

		try
		{
			parser.fromJson(File.getContent(Paths.json("characters/" + id)));
		}
		catch (e:Dynamic)
		{
			trace('Error loading character file of "$id": $e');
			parser.fromJson(File.getContent(Paths.json("characters/" + DEFAULT_CHARACTER_ID)));
		}

		return parser.value;
	}
}

typedef HealthiconData =
{
    @:default("face")
	var id:String;
	var bar:HealthBarData;
}

typedef HealthBarData =
{
	var colored:Bool;
	@:optional var color:Array<Int>;
}