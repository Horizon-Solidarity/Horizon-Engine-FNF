package funkin.data.animation;

typedef NamedAnimationData =
{
	> UnnamedAnimationData,
	var name:String;
}

typedef UnnamedAnimationData =
{
	var prefix:String;

	/**
	 * @default ""
	 */
	@:optional var altAssetPath:String;

	/**
	 * @default []
	 */
	@:optional var indices:Array<Int>;

	/**
	 * @default 24
	 */
	@:optional var frameRate:Int;

	/**
	 * @default false
	 */
	@:optional var flipX:Bool;

	/**
	 * @default false
	 */
	@:optional var flipY:Bool;

	/**
	 * @default [0, 0]
	 */
	@:optional var offsets:Array<Float>;

	/**
	 * @default false
	 */
	@:optional var looped:Bool;
}
