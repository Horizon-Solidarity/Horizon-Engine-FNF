package funkin.objects;

import animate.FlxAnimate;
import flixel.util.typeLimit.OneOfTwo;
import funkin.data.AnimationData;

class FunkinSprite extends FlxAnimate
{
    public var offsets:Map<String, FlxPoint> = new Map<String, FlxPoint>();

    public var zIndex:Int = 0;

    public function addAnimationData(name:String, data:UnnamedAnimationData)
    {
        if (isAnimate)
        {
            if (data.indices.length > 0)
                this.anim.addBySymbolIndices(name, data.prefix, data.indices, data.frameRate, data.looped, data.flipX, data.flipY);
            else
                this.anim.addBySymbol(name, data.prefix, data.frameRate, data.looped, data.flipX, data.flipY);
        }
        else
        {
            if (data.indices.length > 0)
                this.animation.addByIndices(name, data.prefix, data.indices, "", data.frameRate, data.looped, data.flipX, data.flipY);
            else
                this.animation.addByPrefix(name, data.prefix, data.frameRate, data.looped, data.flipX, data.flipY);
        }
        offsets.set(name, FlxPoint.get(data.offset[0], data.offset[1]));
    }

    public function playAnimation(anim:String, force:Bool = false)
    {
		animation.play(anim, force);
        
        if (offsets.exists(anim))
        {
			this.offset = offsets.get(anim);
        }
    }

    inline public function isAnimationNull():Bool
	{
		return (animation.curAnim == null);
	}

	public function isAnimationFinished():Bool
	{
		if (isAnimationNull())
			return false;
		return animation.curAnim.finished;
	}

    public function clearAnimations()
    {
        for (anim in animation.getNameList())
		{
			animation.remove(anim);
			if (offsets.exists(anim))
				offsets.remove(anim);
		}
    }

    public function animationExists(name:String)
    {
        return animation.exists(name);
    }
}