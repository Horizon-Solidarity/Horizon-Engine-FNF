package funkin.objects;

import funkin.data.animation.AnimationData;
import animate.FlxAnimate;
import flixel.util.typeLimit.OneOfTwo;

class FunkinSprite extends FlxAnimate
{
    public var offsets:Map<String, FlxPoint> = new Map<String, FlxPoint>();

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
        if (offsets.exists(anim))
            this.offset = offsets.get(anim);
        animation.play(anim, force);
    }
}