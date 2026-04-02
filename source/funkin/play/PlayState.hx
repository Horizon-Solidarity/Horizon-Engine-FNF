package funkin.play;

import flixel.FlxState;
import flixel.util.typeLimit.NextState;

import funkin.api.scripting.ScriptManager;
import funkin.objects.Character;
import funkin.data.songs.SongData.ChartEventsData;
import funkin.data.songs.SongData.SongCharacterData;
import funkin.play.ui.UI;
import funkin.play.ui.notes.*;

class PlayState extends MusicBeatState
{
	// ___________________ Static Variables ___________________
	public static var playlist:Array<Song> = [];
	
	public static var instance:PlayState;
	public static var exitState:NextState;

	// public static var levelData:
	// public static var storyStats:Float = 0;

	// ___________________ Character Stuff ___________________
	public var characterObjects:Map<SongCharacterData, {vocal:FlxSound, character:Character, strumline:Strumline}> = [];

	public var player(get, never):Character;
	function get_player() return characterObjects.get(song.player).character;

	public var opponent(get, never):Character;
	function get_opponent() return characterObjects.get(song.opponent).character;

	public var spectator(get, never):Character;
	function get_spectator() return characterObjects.get(song.spectator).character;

	// ___________________ Camera Stuff ___________________
	public var camGame:FlxCamera;
	public var camHUD:FlxCamera;
	public var camOther:FlxCamera;

	// ___________________ Gameplay Stuff ___________________
	public var song(get, never):Song;
	function get_song() return playlist[0];

	public var events:Array<ChartEventsData> = [];

	public var ui:UI;

	public var instrumental:FlxSound;

	public var stage:Stage;

	public var skipCountdown:Bool = false;
	
	// ___________________ Script Stuff ___________________
	public var scripts:ScriptManager;

	override public function create()
	{
		super.create();
		instance = this;

		if (playlist.length == 0)
			playlist.push(Song.fromSongId("ugh", "hard", "pico"));

		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camOther = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.add(camOther, false);

		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		ui = new UI(song.uiStyle);
		ui.cameras = [camHUD];
		ui.scrollFactor.set();
		add(ui);

		instrumental = new FlxSound();
		instrumental.loadEmbedded(Paths.inst(song.id, song.variation));
		FlxG.sound.list.add(instrumental);
		instrumental.onComplete = endSong;

		stage = new Stage(song.stage);
		add(stage);

		var loadedVocals = [];

		for (characterData in song.characters)
		{
			var strumline = new Strumline(characterData.strumline.noteskin, true, false, song.scrollSpeed);
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

				loadedVocals.push(p);
			}
			
			var strumLineY:Float = ClientPrefs.data.downScroll ? (FlxG.height - 150) : 30;
			strumline.setPosition(characterData.strumline.offset[0], strumLineY + characterData.strumline.offset[1]);

			var character = new Character(characterData.id);
			stage.addCharacter(character, characterData.type);

			strumline.onNoteHit.add(function(n){
				playSingAnim(character, n);
			});

			if (characterData == song.player)
			{
				strumline.x += (FlxG.width / 2) + 50;
				strumline.botplay = false;

				strumline.onNoteHit.add(playerNoteHit);
				strumline.onNoteMiss.add(playerNoteMiss);

				character.flipX = !character.flipX;
			}
			else
				strumline.x += 25;

			characterObjects.set(characterData, {vocal: vocal, character: character, strumline: strumline});
		}

		scripts = new ScriptManager();
		scripts.loadFromFolder("scripts/play/", true);

		instrumental.play();
		for (obj in characterObjects)
		{
			if (obj.vocal.length > 0)
				obj.vocal.play();
		}

		camGame.focusOn(player.getPosition() - player.cameraOffset);
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

			for (obj in characterObjects)
			{
				if (obj.vocal.playing && (instrumental.time - obj.vocal.time) > 10)
					obj.vocal.time = instrumental.time;
			}
		}
	}

	override function stepHit(step:Int)
	{
		scripts.call("onStepHit", [step]);
	}

	override function beatHit(beat:Int)
	{
		scripts.call("onBeatHit", [beat]);
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

	function playerNoteHit(note:Note)
	{

	}

	function playerNoteMiss(note:Null<Note>)
	{

	}

	function endSong()
	{
		scripts.call("onEndSong");

		var currentSong = song;
		playlist.shift();

		if (playlist.length == 0)
		{
			// TODO: save score

			// levelData = null;
			// levelScore = 0;

			if (exitState != null)
			{
				FlxG.switchState(exitState);
			}
		}
		else
		{
			FlxG.switchState(PlayState.new);
		}
	}
	

	override public function destroy():Void
	{
		scripts.destroy();

		super.destroy();
	}
}
