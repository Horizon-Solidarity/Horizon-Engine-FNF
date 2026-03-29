package funkin.objects;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSort;
import funkin.data.animation.AnimationData;
import funkin.data.character.CharacterData;
import haxe.Json;
import openfl.utils.AssetType;
import openfl.utils.Assets;

class Character extends FlxSprite
{
	public static var CHARACTER_DEFAULT_SPRITE:String = 'characters/BOYFRIEND';

	public var displayName:String = '';

	public var charSprite:String = '';
	public var spriteType:String = '';
	public var noAntialiasing:Bool = true;

	public var sprScale:Array<Float> = [1, 1];

	public var sprFlipX:Bool = false;
	public var sprFlipY:Bool = false;

	public var sprPosition:Array<Float> = [0, 0];
	public var camPosition:Array<Float> = [0, 0];

	public var charIdleBeat:Int = 4;
	public var charSingingTime:Float = 4;

	public var animSinging:Bool = false;
	public var ghostEffect:Bool = false;

	public var animArray:Array<NamedAnimationData> = [];
	public var animOffsets:Map<String, Array<Dynamic>>;

	public function new(x:Float = 0, y:Float = 0, ?charName:String = 'bf')
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();

		/*

												var characterBf:String = 'characters/BOYFRIEND';
		frames = Paths.getSparrowAtlas(characterBf);
        
												scale.set(1, 1);
												updateHitbox();
												offset.set(17, 14);

												animation.addByPrefix("idle", "BF idle dance", 24, true);

												antialiasing = true;

		 */

		changeCharacter(charName);
	}

	public function changeCharacter(charID:String):Void
	{
		var charJson:String = 'data/characters/$charID.json';
		var path:String = Paths.getPath(charJson, TEXT);

		loadCharacter(Json.parse(Assets.getText(path)));
	}

	public function loadCharacter(json:Dynamic)
	{
		scale.set(1, 1);
		updateHitbox();

		displayName = json.name;

		spriteType = json.renderType;

		charSprite = json.assetPath;
		var texture:FlxAtlasFrames = Paths.getSparrowAtlas(charSprite);
		frames = texture;

		if (json.scale != null && json.scale != 1)
		{
			scale.set(json.scale, json.scale);
			updateHitbox();
		}

		sprPosition = json.offsets;
		camPosition = json.cameraOffsets;

		charIdleBeat = json.idleBeat;
		charSingingTime = json.singTime;

		animSinging = json.sustainAnim;
		ghostEffect = json.ghostEffect;

		noAntialiasing = (json.isPixel == true);
		antialiasing = ClientPrefs.data.antialiasing ? !noAntialiasing : false;

		animArray = json.animations;
		if (animArray != null && animArray.length > 0)
		{
			for (anim in animArray)
			{
				final animName:String = '' + anim.name;
				final animPrefix:String = '' + anim.prefix;
				final animFps:Int = anim.frameRate ?? 24;
				final animLoop:Bool = !!anim.looped;
				final animIndices:Array<Int> = anim.indices ?? [];

				final animFlipX:Bool = anim.flipX ?? false;
				final animFlipY:Bool = anim.flipY ?? false;

				if (animIndices != null && animIndices.length > 0)
				{
					addAnimByIndices(animName, animPrefix, animIndices, animFps, animLoop, animFlipX, animFlipY);
				}
				else
				{
					addAnimByPrefix(animName, animPrefix, animFps, animLoop, animFlipX, animFlipY);
				}

				if (anim.offsets != null && anim.offsets.length > 1)
				{
					addOffset(animName, anim.offsets[0], anim.offsets[1]);
				}
			}
		}
		else
		{
			addAnimByPrefix("idle", "BF idle dance", 24, true);
		}
	}

	var _lastPlayedAnimation:String;
	inline public function getAnimationName():String
	{
		return _lastPlayedAnimation;
	}

    public function playAnim(isAnimName:String, isForce:Bool = false, isReversed:Bool = false, isFrame:Int = 0)
    {
        animation.play(isAnimName, isForce, isReversed, isFrame);
        _lastPlayedAnimation = isAnimName;
    }
	public function addAnimByPrefix(animName:String, prefix:String, fps:Int = 24, looped:Bool = false, ?flipX:Bool = false, ?flipY:Bool = false)
	{
		animation.addByPrefix(animName, prefix, fps, looped, flipX, flipY);
	}

	public function addAnimByIndices(animName:String, prefix:String, indices:Array<Int>, fps:Int = 24, looped:Bool = false, ?flipX:Bool = false,
			?flipY:Bool = false)
	{
		animation.addByIndices(animName, prefix, indices, fps, looped, flipX, flipY);
	}

	public function addOffset(anim:String, x:Float = 0, y:Float = 0):Void
	{
		animOffsets[anim] = [x, y];
	}
}