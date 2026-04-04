package;

import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;

using StringTools;

class CharacterConverter {
	public static function main()
	{
		trace("Put V-Slice's Character Path!");
		var vsliceCharPath = Sys.stdin().readLine().trim();
		if (!FileSystem.exists(vsliceCharPath)) {
			trace('No Character Exists in ($vsliceCharPath) !!');
			return;
		}

		var vsliceChar = haxe.Json.parse(File.getContent(vsliceCharPath));

		var horizonChar:CharacterMetadata = {
			name: vsliceChar.name,
			assetPath: vsliceChar.assetPath,
			renderType: vsliceChar.renderType != null ? vsliceChar.renderType : "sparrow",
			offset: vsliceChar.offsets != null ? vsliceChar.offsets : [0, 0],
			cameraOffset: vsliceChar.cameraOffsets != null ? vsliceChar.cameraOffsets : [0, 0],
			healthIcon: {
				id: vsliceChar.healthIcon != null ? vsliceChar.healthIcon.id : Path.withoutExtension(Path.withoutDirectory(vsliceCharPath)),
				bar: {
					colored: false
				}
			},
			animations: [],
			antialiasing: vsliceChar.isPixel != null ? !vsliceChar.isPixel : true,
			scale: [1, 1],
			flipX: vsliceChar.flipX != null ? vsliceChar.flipX : false,
			flipY: vsliceChar.flipY != null ? vsliceChar.flipY : false,
			danceAnimations: ["idle"],
			loopOnHold: false,
			doubleGhost: true
		}

		for (i in 0...vsliceChar.animations.length)
		{
			var anim = vsliceChar.animations[i];
			horizonChar.animations.push({
				name: anim.name,
				prefix: anim.prefix,
				indices: anim.frameIndices != null ? anim.frameIndices : [],
				frameRate: anim.frameRate != null ? anim.frameRate : 24,
				flipX: anim.flipX != null ? anim.flipX : false,
				flipY: anim.flipY != null ? anim.flipY : false,
				offset: anim.offsets != null ? anim.offsets : [0, 0],
				looped: anim.looped != null ? anim.looped : false,
			});
			if (anim.name == "danceLeft")
				horizonChar.danceAnimations = ["danceLeft", "danceRight"];
		}

		var theScale:Dynamic = vsliceChar.scale;
		if (theScale != null)
			if (theScale is Float)
				horizonChar.scale = [theScale, theScale];
			else
				horizonChar.scale = theScale;

		
		
		FileSystem.createDirectory("exported_characters");
		File.saveContent("exported_characters/" + Path.withoutDirectory(vsliceCharPath), haxe.Json.stringify(horizonChar, "\t"));
	}
}



enum abstract CharacterRenderType(String) from String to String
{
  /**
   * Renders the character using a single spritesheet and XML data.
   */
    public var SPARROW = 'sparrow';

  /**
   * Renders the character using a single spritesheet and TXT data.
   */
    public var PACKER = 'packer';

  /**
   * Renders the character using multiple spritesheets and XML data.
   */
    public var MULTI_SPARROW = 'multisparrow';

  /**
   * Renders the character using a single spritesheet of symbols and JSON data.
   */
    public var ANIMATE_ATLAS = 'animateatlas';

  /**
   * Renders the character using multiple spritesheets of symbols and JSON data.
   */
    public var MULTI_ANIMATE_ATLAS = 'multianimateatlas';

  /**
   * Renders the character using a custom method.
   */
    public var CUSTOM = 'custom';
}

typedef CharacterMetadata =
{
    var name:String;

    var assetPath:String;

    var renderType:CharacterRenderType;

    var offset:Array<Float>;

    var cameraOffset:Array<Float>;

	var healthIcon:HealthiconData;

    var animations:Array<NamedAnimationData>;

    /**
     * @default [true]
     */
    var antialiasing:Bool;

    /**
     * @default [[1.0,1.0]]
     */
    var scale:Array<Float>;

    /**
     * @default [false]
     */
    var flipX:Bool;

    /**
     * @default [false]
     */
    var flipY:Bool;

    /**
     * @default [2]
     */
    var danceAnimations:Array<Null<String>>;

    /**
     * @default [false]
     */
    var loopOnHold:Bool;

    /**
     * @default [true]
     */
    var doubleGhost:Bool;
}

typedef HealthiconData =
{
	var id:String;
	var bar:HealthBarData;
}

typedef HealthBarData =
{
	var colored:Bool;
	@:optional var color:Array<Int>;
}

typedef NamedAnimationData =
{
	var name:String;

	var prefix:String;

	/**
	 * @default null
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
	@:optional var offset:Array<Float>;

	/**
	 * @default false
	 */
	@:optional var looped:Bool;
}