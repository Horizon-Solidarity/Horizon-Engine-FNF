package funkin.objects.icontype;

class DefaultIcon // extends FlxSprite
{
    /**
     * [DefaultIconController]
     * @param pos 
     * @param iconImage 
     * @param winStuff 
     */
    public function new(param:DefaultIconParam)
    {
        // super(param.posit[0], param.posit[1])
    }
}

typedef DefaultIconParam =
{
    var posit:Array<Float>;
    var iconImage:String;
    var winStuff:Array<Dynamic>;
}