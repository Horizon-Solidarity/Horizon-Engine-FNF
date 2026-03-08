package funkin.play;

import flixel.FlxState;
import funkin.objects.Character;

class PlayState extends MusicBeatState
{
	var player:Character;

	override public function create()
	{
		super.create();
		var text = new FlxText(0, 0, 0, "Hello World", 64);
		text.screenCenter();
		add(text);

		player = new Character(20, 20);
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
