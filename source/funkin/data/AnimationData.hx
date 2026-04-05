package funkin.data;

typedef NamedAnimationData =
{
	> UnnamedAnimationData,
	var name:String;
}

typedef UnnamedAnimationData =
{
	var prefix:String;

	/**
	 * @default null
	 */
	@:optional var altAssetPath:String;

	/**
	 * @default []
	 */
	@:default([])
	@:optional var indices:Array<Int>;

	/**
	 * @default 24
	 */
	@:default(24)
	@:optional var frameRate:Int;

	/**
	 * @default false
	 */
	@:default(false)
	@:optional var flipX:Bool;

	/**
	 * @default false
	 */
	@:default(false)
	@:optional var flipY:Bool;

	/**
	 * @default [0, 0]
	 */
	@:default([])
	@:optional var offset:Array<Float>;

	/**
	 * @default false
	 */
	@:default(false)
	@:optional var looped:Bool;
}
