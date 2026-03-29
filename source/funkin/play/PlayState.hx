package funkin.play;

import flixel.FlxState;
import funkin.objects.Character;
import funkin.play.ui.UI;

class PlayState extends MusicBeatState
{
	var PLY_X:Float = 770;
	var PLY_Y:Float = 100;

	public var playerCameraOffsets:String;

	var playerGroup:FlxSpriteGroup;
	var player:Character = null;

	var camGame:FlxCamera;
	var camHUD:FlxCamera;
	var camOther:FlxCamera;

	var _hud:UI;

	override public function create()
	{
		super.create();
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camOther = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.add(camOther, false);

		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		playerGroup = new FlxSpriteGroup(PLY_X, PLY_Y);

		var text = new FlxText(0, 0, 0, "Hello World", 64);
		text.screenCenter();
		add(text);

		player = new Character(20, 20, 'bf');
		add(player);
	}

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

		if (!player.getAnimationName().startsWith('sing'))
        	player.playAnim('idle');

		notePress();
    }

	function notePress()
	{
		var left:Bool = false;
		var down:Bool = false;
		var up:Bool = false;
		var right:Bool = false;

		left = FlxG.keys.anyPressed([LEFT, A]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		up = FlxG.keys.anyPressed([UP, W]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (left)
			player.playAnim('singLeft', true);
		else if (down)
			player.playAnim('singDown', true);
		else if (up)
			player.playAnim('singUp', true);
		else if (right)
			player.playAnim('singRight', true);
	}
}
