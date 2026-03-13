package funkin.data.character;

import funkin.data.animation.AnimationData;

enum abstract CharacterRenderType(String) from String to String
{
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
    public var MultiSparrow = 'Multiple-Sparrow';

  /**
   * Renders the character using a single spritesheet of symbols and JSON data.
   */
    public var AnimateAtlas = 'animateatlas';

  /**
   * Renders the character using multiple spritesheets of symbols and JSON data.
   */
    public var MultiAnimateAtlas = 'Multiple-Animateatlas';

  /**
   * Renders the character using a custom method.
   */
    public var Custom = 'custom';
}

typedef CharacterMetadata =
{
    var name:String;
    var assetPath:String;
    var renderType:CharacterRenderType;
    var offsets:Array<Float>;
    var cameraOffsets:Array<Float>;
    var healthIcon:HealthIconData;
    var animations:Array<NamedAnimationData>;

    /**
     * @default [false]
     */
    @:optional var isPixel:Bool;

    /**
     * @default [[1.0,1.0]]
     */
    @:optional var scale:Array<Float>;

    /**
     * @default [false]
     */
    @:optional var flipX:Bool;

    /**
     * @default [false]
     */
    @:optional var flipY:Bool;

    /**
     * @default [2]
     */
    @:optional var idleBeat:Int;

    /**
     * @default [8.0]
     */
    @:optional var singTime:Float;

    /**
     * @default [false]
     */
    @:optional var sustainAnim:Bool;

    /**
     * @default [false]
     */
    @:optional var ghostEffect:Bool;

    /**
     * @default [{}]
     */
    @:optional var deathData:CharacterDeathData;
}

typedef HealthIconData =
{
    var id:String;
    var splitable:SplitableIconData;
    var win:WinningIconData;

    /**
     * @default [[1.0,1.0]]
     */
    @:optional var scale:Array<Float>;

    /**
     * @default [0.0]
     */
    @:optional var angle:Float;

    /**
     * @default [false]
     */
    @:optional var flipX:Bool;

    /**
     * @default [false]
     */
    @:optional var flipY:Bool;

    /**
     * @default [[0.0,0.0]]
     */
    @:optional var offsets:Array<Float>;
}

typedef SplitableIconData =
{
    var enabledS:Bool;

    /**
     * @default [""]
     */
    @:optional var normalPath:String;

    /**
     * @default [""]
     */
    @:optional var missPath:String;
}

typedef WinningIconData =
{
    var enabledW:Bool;

    /**
     * @default [""]
     */
    @:optional var winAssetPath:String;
}

typedef CharacterDeathData =
{

    /**
     * @default [[0.0,0.0]]
     */
    @:optional var cameraOffsets:Array<Float>;

    /**
     * @default [1.0]
     */
    @:optional var cameraZoom:Float;

    /**
     * @default [0.0]
     */
    @:optional var preTransDelay:Float;
}