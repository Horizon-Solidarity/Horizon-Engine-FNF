package funkin.data.character;

typedef HealthIconData =
{
    var splitable:SplitableIconData;
    var winning:Bool;

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
	/**
	 * @default [false]
	 */
	@:optional var isPixel:Bool;
}

typedef SplitableIconData =
{
    var enabledSplit:Bool;

    /**
     * @default [null]
     */
    @:optional var normal:Bool;

    /**
     * @default [null]
     */
    @:optional var missses:Bool;
}