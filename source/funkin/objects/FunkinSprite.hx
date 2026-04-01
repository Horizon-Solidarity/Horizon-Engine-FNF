package funkin.backend.game.graphics;

import funkin.data.animation.AnimationData;
import animate.FlxAnimate;

class FunkinSprite extends FlxAnimate
{
    public var offsets:Map<String, FlxPoint> = new Map<String, FlxPoint>();

    public function addAnimationData(name:String, data:AnimationData)
    {
        if (isAnimate)
        {
            if (indices.length > 0)
                this.anim.addBySymbolIndices(name, data.prefix, data.indices, data.frameRate, data.looped, data.flipX, data.flipY);
            else
                this.anim.addBySymbol(name, data.prefix, data.frameRate, data.looped, data.flipX, data.flipY);
        }
        else
        {
            if (indices.length > 0)
                this.animation.addByIndices(name, data.prefix, data.indices, data.frameRate, data.looped, data.flipX, data.flipY);
            else
                this.animation.addByPrefix(name, data.prefix, data.frameRate, data.looped, data.flipX, data.flipY);
        }
        offsets.set(name, FlxPoint.get(data.offsets[0], data.offsets[1]));
    }

    public function playAnimation(anim:String)
    {
        if (offsets.exists(anim))
            this.offset = offsets.get(anim);
        animation.play(anim);
    }
}