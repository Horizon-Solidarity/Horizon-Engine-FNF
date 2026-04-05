package;

import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;

using StringTools;

class StageConverter {
	static function lerp(a:Float, b:Float, t:Float)
	{
		return a + (b - a) * t;
	}

	public static function main()
	{
		trace("Put V-Slice's Stage Path!");
		var vsliceStagePath = Sys.stdin().readLine().trim();
		if (!FileSystem.exists(vsliceStagePath)) {
			trace('No Stage Exists in ($vsliceStagePath) !!');
			return;
		}

		var vsliceStage = haxe.Json.parse(File.getContent(vsliceStagePath));

		var horizonStage:StageMetadata = {
			directory: Path.addTrailingSlash(vsliceStage.directory),
			name: vsliceStage.name,
			camera: {
				// make camera starts at center of player and opponent
				initialPosition: [
					lerp(vsliceStage.characters.bf.position[0], vsliceStage.characters.dad.position[0], 0.5),
					lerp(vsliceStage.characters.bf.position[1], vsliceStage.characters.dad.position[1], 0.5)
				],
				zoom: vsliceStage.cameraZoom,
			},
			characters: {
				player: {
					scale: vsliceStage.characters.bf.scale != null ? vsliceStage.characters.bf.scale : [1, 1],
					zIndex: vsliceStage.characters.bf.zIndex,
					position: vsliceStage.characters.bf.position,
					cameraOffset: vsliceStage.characters.bf.cameraOffset != null ? vsliceStage.characters.bf.cameraOffset : [0, 0]
				},
				opponent: {
					scale: vsliceStage.characters.dad.scale != null ? vsliceStage.characters.dad.scale : [1, 1],
					zIndex: vsliceStage.characters.dad.zIndex,
					position: vsliceStage.characters.dad.position,
					cameraOffset: vsliceStage.characters.dad.cameraOffset != null ? vsliceStage.characters.dad.cameraOffset : [0, 0]
				},
				spectator: {
					scale: vsliceStage.characters.gf.scale != null ? vsliceStage.characters.gf.scale : [1, 1],
					zIndex: vsliceStage.characters.gf.zIndex,
					position: vsliceStage.characters.gf.position,
					cameraOffset: vsliceStage.characters.gf.cameraOffset != null ? vsliceStage.characters.gf.cameraOffset : [0, 0]
				}
			},
			props: [],
		}

		for (i in 0...vsliceStage.props.length)
		{
			var prop = vsliceStage.props[i];

			var animType:String = prop.animType != null ? prop.animType : "image";
			if (animType == "sparrow" && prop.animations.length == 0)
				animType = "image";

			horizonStage.props.push({
				name: prop.name,
				assetPath: prop.assetPath,
				position: prop.position,
				renderType: animType,
				zIndex: prop.zIndex,
				scale: prop.scale != null ? prop.scale : [1, 1],
				scrollFactor: prop.scroll != null ? prop.scroll : [1, 1],
				antialiasing: prop.isPixel != null ? !prop.isPixel : true,
				animations: [],
				flipX: prop.flipX != null ? prop.flipX : false,
				flipY: prop.flipY != null ? prop.flipY : false,
			});


			if (prop.animations != null)
			{
				for (x in 0...prop.animations.length)
				{
					var animation = prop.animations[x];

					horizonStage.props[i].animations.push({
						name: animation.name,
						prefix: animation.prefix,
						frameRate: animation.frameRate != null ? animation.frameRate : 24,
						indices: animation.indices != null ? animation.indices : [],
						flipX: animation.flipX != null ? animation.flipX : false,
						flipY: animation.flipY != null ? animation.flipY : false,
						offset: animation.offsets != null ? animation.offsets : [0, 0],
						looped: animation.looped != null ? animation.looped : false,
					});
				}
			}
		}

		
		
		FileSystem.createDirectory("exported_stages");
		File.saveContent("exported_stages/" + Path.withoutDirectory(vsliceStagePath), haxe.Json.stringify(horizonStage, "\t"));
	}
}



typedef StageMetadata =
{
    var directory:String;
    
    var name:String;
    var camera:StageCameraData;
    
    var characters:StageCharacterMetadata;
    var props:Array<StagePropData>;
}

typedef StageCameraData =
{
    var zoom:Float;
    var initialPosition:Array<Float>;
}

typedef BasePropData = {
	var zIndex:Int;
    var position:Array<Float>;
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
    var cameraOffset:Array<Float>;
}

typedef StagePropData =
{
	> BasePropData,
	var name:String;
	var assetPath:String;
	var renderType:CharacterRenderType;
	var scrollFactor:Array<Float>;
	var antialiasing:Bool;

	var animations:Array<NamedAnimationData>;

	var flipX:Bool;
	var flipY:Bool;
}

typedef NamedAnimationData =
{
	var name:String;
	var prefix:String;
	@:optional var altAssetPath:String;
	@:optional var indices:Array<Int>;
	@:optional var frameRate:Int;
	@:optional var flipX:Bool;
	@:optional var flipY:Bool;
	@:optional var offset:Array<Float>;
	@:optional var looped:Bool;
}
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