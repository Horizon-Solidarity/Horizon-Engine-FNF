package funkin.objects;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;

class Character extends FlxSprite
{
    public var curCharacter:String;

	public var positionArray:Array<Float> = [0, 0];
	public var cameraPosition:Array<Float> = [0, 0];

    var animSinging:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		// frames = Paths.getSparrowAtlas('characters/bf/BOYFRIEND');
        var characterBf:String = 'characters/BOYFRIEND';
		frames = Paths.getSparrowAtlas(characterBf);
        
        scale.set(1, 1);
        offset.set(17, 14);
        animation.addByPrefix("idle", "BF idle dance", 24, true);
		animation.addByPrefix('singUP', 'BF NOTE UP');
		animation.addByPrefix('singLEFT', 'BF NOTE LEFT');
		animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT');
		animation.addByPrefix('singDOWN', 'BF NOTE DOWN');
		animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS');
		animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS');
		animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS');
		animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS');
		animation.addByPrefix('hey', 'BF HEY');

		animation.addByPrefix('firstDeath', "BF dies");
		animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
		animation.addByPrefix('deathConfirm', "BF Dead confirm");

		animation.addByPrefix('scared', 'BF idle shaking', 24, true);
        
		antialiasing = true;
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
}