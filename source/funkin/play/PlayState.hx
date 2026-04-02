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
	public var characters:Array<Character> = [];

	public var player(get, never):Character;
	function get_player() return characters[0];

	public var opponent(get, never):Character;
	function get_opponent() return characters[1];

	public var spectator(get, never):Character;
	function get_spectator() return characters[2];

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

		for (characterData in song.characters)
		{
			var strumline = new Strumline(song.uiStyle, true, false, song.scrollSpeed);
			strumline.scrollFactor.set();
			strumline.cameras = [camHUD];
			add(strumline);

			for (receptor in strumline.receptors)
			{
				receptor.scale.x *= characterData.strumline.scale;
				receptor.scale.y *= characterData.strumline.scale;
			}

			strumline.visible = characterData.strumline.visible;
			strumline.mania = characterData.strumline.keys;

			for (note in characterData.strumline.notes)
				strumline.addNoteQueue(note);

			var p = Paths.voice(song.id, characterData.vocalSuffix, song.variation);
			var vocal = new FlxSound(); // To match the index with other arrays, we put in empty instances even if they don't have a vocal file.

			if (p != null && !loadedVocals.contains(p))
			{
				vocal.loadEmbedded(p);
				FlxG.sound.list.add(vocal);
				voices.push(vocal);

				loadedVocals.push(p);
			}
			
			var strumLineY:Float = ClientPrefs.data.downScroll ? (FlxG.height - 150) : 30;
			strumline.setPosition(characterData.strumline.offset[0], strumLineY + characterData.strumline.offset[1]);

			var character = new Character(0, 0, "bf");
			add(character);
			characters.push(character);

			strumline.onNoteHit.add(function(n){
				playSingAnim(character, n);
			});

			if (characterData == song.player)
			{
				strumline.x += (FlxG.width / 2) + 50;
				strumline.botplay = false;
			}
			else
				strumline.x += 25;

			characters.push(character);
			strumlines.push(strumline);
		}

		scripts = new ScriptManager();
		scripts.loadFromFolder("scripts/play/", true);

		instrumental.play();
		for (voice in voices)
		{
			if (voice.length > 0)
				voice.play();
		}
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
				if (voice.playing && (instrumental.time - voice.time) > 10)
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
    
	function playSingAnim(character:Character, note:Note)
	{
		character.playAnimation(character.singAnimations[note.data.lane] + note.animSuffix, true);
		character.lastSingBeat = conductor.curBeat;
	}

	function playMissAnim(character:Character, direction:Int, suffix:String = "")
	{
		character.playAnimation(character.singAnimations[direction] + suffix + "-miss", true);
	}
}
