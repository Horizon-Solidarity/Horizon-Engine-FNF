package funkin.objects;

import funkin.data.character.CharacterData;
import funkin.data.character.HealthIconMeta;
import funkin.objects.icontype.DefaultIcon;
import funkin.objects.icontype.SplitableIcon;

class HealthIcon
{
    public var splitIcon:SplitableIcon;
    public var defaultIcon:DefaultIcon;

	public var iconData:String = '';
    
	public var iconImage:String = '';

    public var split:SplitableIconData;
	public var winEnabled:Bool;

    public var iconScale:Array<Float> = [1, 1];
    public var iconAngle:Float = 0;
    public var iconFlipX:Bool = false;
    public var iconFlipY:Bool = false;
    public var iconOffsets:Array<Float> = [0, 0];

    public var splitEnabled:Bool = false;
	public var normalEnabled:Bool = false;
	public var missesEnabled:Bool = false;
	public var winningEnabled:Bool = false;

    public var normalImage:String = 'normal';
    public var missesImage:String = 'misses';
    public var winningImage:String = 'winning';

    // _________________ Icon utilities template (for Engine Developers) __________________
    // By the way, I haven't written the contents of the class I called either lol.

    /*
    splitIcon = new SplitableIcon({
        posit = iconOffsets,
        normal = normalImage,
        misses = missesImage,
        winStuff = [winEnabled, winningImage]
    })
    defaultIcon = new SplitableIcon({
        posit = iconOffsets,
						icon = iconImage,
        winStuff = [winEnabled, winningImage]
    })
    */

    // _____________________________________________________________________________________
    // _____________________________________________________________________________________
}