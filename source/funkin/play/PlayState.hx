package funkin.play;

import flixel.FlxState;
import funkin.api.scripting.ScriptManager;
import funkin.objects.Character;
import funkin.play.ui.UI;
import funkin.play.ui.notes.*;

class PlayState extends MusicBeatState
{
	public static var instance:PlayState;

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

	// ___________________ Gameplay Stuff ___________________
	public var song:Song;

	public var ui:UI;

	public var strumlines:Array<Strumline> = [];

	public var instrumental:FlxSound;
	public var voices:Array<FlxSound> = [];

	public var skipCountdown:Bool = false;
	
	// ___________________ Script Stuff ___________________
	public var scripts:ScriptManager;

	override public function create()
	{
		super.create();
		instance = this;

		if (song == null)
			song = Song.fromSongId("ugh", "hard", "pico");

		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camOther = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.add(camOther, false);

		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		ui = new UI();
		ui.cameras = [camHUD];
		ui.scrollFactor.set();
		add(ui);

		instrumental = new FlxSound();
		instrumental.loadEmbedded(Paths.inst(song.id, song.variation));
		FlxG.sound.list.add(instrumental);

		var loadedVocals = [];

		for (character in song.characters)
		{
			var strumline = new Strumline(song.uiStyle, true, false, song.scrollSpeed);
			strumline.scrollFactor.set();
			strumline.cameras = [camHUD];
			add(strumline);

			for (receptor in strumline.receptors)
			{
				receptor.scale.x *= character.strumline.scale;
				receptor.scale.y *= character.strumline.scale;
			}

			strumline.visible = character.strumline.visible;
			strumline.mania = character.strumline.keys;

			for (note in character.strumline.notes)
				strumline.addNoteQueue(note);

			var p = Paths.voice(song.id, character.vocalSuffix, song.variation);
			if (p != null && !loadedVocals.contains(p))
			{
				var vocal = new FlxSound();
				vocal.loadEmbedded(p);
				FlxG.sound.list.add(vocal);
				voices.push(vocal);

				loadedVocals.push(p);
			}
			
			var strumLineY:Float = ClientPrefs.data.downScroll ? (FlxG.height - 150) : 30;
			strumline.setPosition(character.strumline.offset[0], strumLineY + character.strumline.offset[1]);
			// TODO: setup actual characters here


			if (character == song.player)
			{
				strumline.x += (FlxG.width / 2) + 50;
				strumline.botplay = false;
			}
			if (character == song.opponent)
			{
				strumline.x += 25;
			}
		}

		scripts = new ScriptManager();
		scripts.loadFromFolder("scripts/play/", true);


		setupCharacter();

		instrumental.play();
		for (voice in voices)
			voice.play();
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

		// Psych Sync shit (stole from TE)
		conductor.songPosition += elapsed * 1000;
		if (instrumental.playing)
		{
			conductor.songPosition = FlxMath.lerp(instrumental.time, conductor.songPosition, Math.exp(-elapsed * 5));
			var timeDiff:Float = Math.abs(instrumental.time - conductor.songPosition);
			if (timeDiff > 1000)
				conductor.songPosition = conductor.songPosition + 1000 * FlxMath.signOf(timeDiff);

			// who let me cook (syncing vocals)
			for (voice in voices)
			{
				if ((instrumental.time - voice.time) > 10)
					voice.time = instrumental.time;
			}
		}
	}

	override function stepHit(step:Int)
	{

	}

	override function beatHit(beat:Int)
	{
	}

	public function charBopping(beat:Int):Void
	{
		if (player != null && beat % player.charIdleBeat == 0 && !player.getAnimationName().startsWith('sing') && !player.stunned)
			player.dance();
	}
    
	public function playerDance():Void
	{
		var anim:String = player.getAnimationName();
		if (player.holdTimer > conductor.stepCrochet * (0.0011 #if FLX_PITCH / FlxG.sound.music.pitch #end) * player.charSingingTime
			&& anim.startsWith('sing') && !anim.endsWith('miss'))
			player.dance();
	}
}
