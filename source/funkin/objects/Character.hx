package funkin.objects;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSort;
import funkin.backend.game.system.IMusicBeatSystem;
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

	public var charIdleBeat:Int = 2;
	public var charSingingTime:Float = 4;

	public var animSinging:Bool = false;
	public var ghostEffect:Bool = false;

	public var animArray:Array<NamedAnimationData> = [];
	public var animOffsets:Map<String, Array<Dynamic>>;

	// _____________________ search variables _____________________
	public var stunned:Bool = false;
	public var debugMode:Bool = false;
	public var skipDance:Bool = false;
	public var specialAnim:Bool = false;
	public var danceIdle:Bool = false;
	public var danced:Bool = false;
	public var idleSuffix:String = '';
	public var holdTimer:Float = 0;

	public function new(x:Float = 0, y:Float = 0, ?charName:String = 'bf')
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();

		changeCharacter(charName);
	}

	public function changeCharacter(charID:String):Void
	{
		animArray = [];
		animOffsets = [];

		var path:String = Paths.json('characters/$charID');

		try
		{
			loadCharacter(Json.parse(Assets.getText(path)));
		}
		catch (e:Dynamic)
		{
			trace('Error loading character file of "$charID": $e');
		}
		skipDance = false;
		recalculateDanceIdle();
		dance();
	}

	public function loadCharacter(json:Dynamic)
	{
		scale.set(1, 1);
		updateHitbox();

		displayName = json.name;

		spriteType = json.renderType;

		charSprite = json.assetPath;
		var texture:FlxAtlasFrames = FunkinAssets.getSparrow(charSprite);
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
					addOffset(anim.name, anim.offsets[0], anim.offsets[1]);
				}
			}
		}
		else
		{
			addAnimByPrefix("idle", "BF idle dance", 24, true);
		}
	}

	override function update(elapsed:Float)
	{
		if (debugMode)
		{
			super.update(elapsed);
			return;
		}

		if (specialAnim && isAnimationFinished())
		{
			specialAnim = false;
			dance();
		}
		else if (getAnimationName().endsWith('miss') && isAnimationFinished())
		{
			dance();
			finishAnimation();
		}

		if (getAnimationName().startsWith('sing'))
			holdTimer += elapsed;

		if (holdTimer >= IMusicBeatSystem.stepCrochet * (0.0011 #if FLX_PITCH / (FlxG.sound.music != null ? FlxG.sound.music.pitch : 1) #end) * charSingingTime)
		{
			dance();
			holdTimer = 0;
		}
		super.update(elapsed);
	}

	public function dance()
	{
		if (!debugMode && !skipDance && !specialAnim)
		{
			if (danceIdle)
			{
				danced = !danced;

				if (danced)
					playAnim('danceRight' + idleSuffix);
				else
					playAnim('danceLeft' + idleSuffix);
			}
			else if (hasAnimation('idle' + idleSuffix))
				playAnim('idle' + idleSuffix);
		}
	}

	var _lastPlayedAnimation:String;

    public function playAnim(isAnimName:String, isForce:Bool = false, isReversed:Bool = false, isFrame:Int = 0)
    {
		specialAnim = false;
        animation.play(isAnimName, isForce, isReversed, isFrame);
        _lastPlayedAnimation = isAnimName;
		if (hasAnimation(isAnimName))
		{
			var daOffset = animOffsets.get(isAnimName);
			offset.set(daOffset[0], daOffset[1]);
		}
    }
	public function addAnimByPrefix(animName:String, prefix:String, fps:Int = 24, looped:Bool = false, ?flipX:Bool = false, ?flipY:Bool = false)
	{
		animation.addByPrefix(animName, prefix, fps, looped, flipX, flipY);
	}

	public function addAnimByIndices(animName:String, prefix:String, indices:Array<Int>, fps:Int = 24, looped:Bool = false, ?flipX:Bool = false,
			?flipY:Bool = false)
	{
		animation.addByIndices(animName, prefix, indices, '', fps, looped, flipX, flipY);
	}

	public function addOffset(anim:String, x:Float = 0, y:Float = 0):Void
	{
		animOffsets[anim] = [x, y];
	}
	// _____________________ search functions _____________________
	inline public function isAnimationNull():Bool
	{
		return (animation.curAnim == null);
	}

	inline public function getAnimationName():String
	{
		return _lastPlayedAnimation;
	}

	public function isAnimationFinished():Bool
	{
		if (isAnimationNull())
			return false;
		return animation.curAnim.finished;
	}

	public function finishAnimation():Void
	{
		animation.curAnim.finish();
	}

	public function hasAnimation(anim:String):Bool
	{
		return animOffsets.exists(anim);
	}

	public var animPaused(get, set):Bool;

	private function get_animPaused():Bool
	{
		if (isAnimationNull())
			return false;
		return animation.curAnim.paused;
	}

	private function set_animPaused(value:Bool):Bool
	{
		if (isAnimationNull())
			return value;
		animation.curAnim.paused = value;

		return value;
	}

	function sortAnims(Obj1:Array<Dynamic>, Obj2:Array<Dynamic>):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1[0], Obj2[0]);
	}

	private var settingCharacterUp:Bool = true;

	public function recalculateDanceIdle()
	{
		var lastDanceIdle:Bool = danceIdle;
		danceIdle = (hasAnimation('danceLeft' + idleSuffix) && hasAnimation('danceRight' + idleSuffix));

		if (settingCharacterUp)
		{
			charIdleBeat = (danceIdle ? 1 : 2);
		}
		else if (lastDanceIdle != danceIdle)
		{
			var calc:Float = charIdleBeat;
			if (danceIdle)
				calc /= 2;
			else
				calc *= 2;

			charIdleBeat = Math.round(Math.max(calc, 1));
		}
		settingCharacterUp = false;
	}
}