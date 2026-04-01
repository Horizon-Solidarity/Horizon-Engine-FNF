package funkin.play;

import flixel.FlxState;
import funkin.api.scripting.ScriptManager;
import funkin.backend.game.system.IMusicBeatSystem;
import funkin.objects.Character;
import funkin.play.ui.UI;

class PlayState extends MusicBeatState
{
	// ___________________ Character Stuff ___________________
	public var OPP_X:Float = 100;
	public var OPP_Y:Float = 100;

	public var PLY_X:Float = 770;
	public var PLY_Y:Float = 100;

	public var CNT_X:Float = 400;
	public var CNT_Y:Float = 130;

	public var playerCameraOffsets:String;

	public var opponentGroup:FlxSpriteGroup;
	public var playerGroup:FlxSpriteGroup;
	public var centerGroup:FlxSpriteGroup;

	public var opponent:Character = null;
	public var player:Character = null;
	public var center:Character = null;

	// ___________________ Camera Stuff ___________________
	public var camGame:FlxCamera;
	public var camHUD:FlxCamera;
	public var camOther:FlxCamera;
	public var _hud:UI;

	// ___________________ Gameplay Stuff ___________________
	public var skipCountdown:Bool = false;
	
	// ___________________ Script Stuff ___________________
	public var scripts:ScriptManager;

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

		var text = new FlxText(0, 0, 0, "Hello World", 64);
		text.screenCenter();
		add(text);

		scripts = new ScriptManager();
		scripts.loadFromFolder("scripts/play/", true);


		setupCharacter();
	}

	function setupCharacter()
	{
		player = new Character(20, 20, 'bf');
		add(player);
		opponent = new Character(20, 20, 'dad');
		add(opponent);

		PLY_X = 770 + player.sprPosition[0];
		PLY_Y = 100 + player.sprPosition[1];
		OPP_X = 100 + opponent.sprPosition[0];
		OPP_Y = 100 + opponent.sprPosition[1];

		playerGroup = new FlxSpriteGroup(PLY_X, PLY_Y);
		playerGroup.add(player);
		opponentGroup = new FlxSpriteGroup(OPP_X, OPP_Y);
		opponentGroup.add(opponent);
	}

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

		notePress();

		// playerDance();
	}

	var lastStepHit:Int = -1;

	override function stepHit()
	{
		super.stepHit();

		if (curStep == lastStepHit)
		{
			return;
		}

		lastStepHit = curStep;
	}

	var lastBeatHit:Int = -1;

	override function beatHit()
	{
		if (lastBeatHit >= curBeat)
		{
			trace('BEAT HIT: ' + curBeat + ', LAST HIT: ' + lastBeatHit);
			return;
		}

		charBopping(curBeat);

		super.beatHit();
		lastBeatHit = curBeat;
	}

	public function charBopping(beat:Int):Void
	{
		if (player != null && beat % player.charIdleBeat == 0 && !player.getAnimationName().startsWith('sing') && !player.stunned)
			player.dance();
	}
    
	public function playerDance():Void
	{
		var anim:String = player.getAnimationName();
		if (player.holdTimer > IMusicBeatSystem.stepCrochet * (0.0011 #if FLX_PITCH / FlxG.sound.music.pitch #end) * player.charSingingTime
			&& anim.startsWith('sing') && !anim.endsWith('miss'))
			player.dance();
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
