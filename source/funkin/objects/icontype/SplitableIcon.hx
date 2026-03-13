package funkin.objects.icontype;

class SplitableIcon // extends FlxSprite
{
    /**
     * [SplitableIconController]
     * @param posit iconOffsets @default [0, 0]
     * @param normal normalIconImage @default 'normal'
     * @param misses missesIconImage @default 'misses'
     * @param winStuff [enabled, winIconImage] @default [false, 'winning']
     */
    public function new(param:SplitableIconParam)
    {
        // super(param.posit[0], param.posit[1])
    }
}

typedef SplitableIconParam =
{
    var posit:Array<Float>;
    var normal:String;
    var misses:String;
    var winStuff:Array<Dynamic>;
}