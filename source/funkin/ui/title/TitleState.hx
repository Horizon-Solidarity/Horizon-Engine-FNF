package funkin.ui.title;

import funkin.backend.game.MusicBeatState;
import funkin.data.menu.init.InitData;

class TitleState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	public static var initialized:Bool = false;

	var credGroup:FlxGroup = new FlxGroup();
	var textGroup:FlxGroup = new FlxGroup();
	var blackScreen:FlxSprite;
	var credTextShit:Alphabet;
	var ngSpr:FlxSprite;
	
	var titleTextColors:Array<FlxColor> = [0xFF33FFFF, 0xFF3333CC];
	var titleTextAlphas:Array<Float> = [1, .64];

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;
    
    public function create():Void
    {
		Paths.clearStoredMemory();
        super.create();
		Paths.clearUnusedMemory();

        startIntro();
    }
    
	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;
	var swagShader:ColorSwap = null;

    function startIntro()
    {
		// persistentUpdate = true;
		if (!initialized && FlxG.sound.music == null)
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

		Conductor.bpm = musicBPM;
        
        initJson(Paths.json('data/states/title/title_metadata'));
    }

	// JSON data
	var characterImage:String = 'gfDanceTitle';
	var animationName:String = 'gfDance';

	var gfPosition:FlxPoint = FlxPoint.get(512, 40);
	var logoPosition:FlxPoint = FlxPoint.get(-150, -100);
	var enterPosition:FlxPoint = FlxPoint.get(100, 576);
	
	var useIdle:Bool = false;
	var musicBPM:Float = 102;
	var danceLeftFrames:Array<Int> = [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29];
	var danceRightFrames:Array<Int> = [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

    // _______________________________ HORIZON TITLE CUSTOMIZABLE in JSON _______________________________
    var associatedImage:String = '';

    var jsonCharacters:Array<String> = [];

    var tCharMain:FlxSprite;
    var tCharVisible:Bool = true;
    var tCharAssets:String = '';
    var tCharAnimation:Array<TitleCharAnim>;

	var useIdle:Bool = false;

    var tCharAnimName:String;

    var isTextYee:Array<InitVisibleData>;

    // ____________________________________________________________________________________

    function initJson(json:InitMetadata)
    {
        var newGroundsImage = json.titleData.introImagePath;

        associatedImage = Paths.image('states/titles/' + newGroundsImage);

        // _______________________________________ Json Character Setting _______________________________________
        jsonCharacters = json.titleData.characters;
        for (i in 0...jsonCharacters.length)
        {
            if (jsonCharacters != null && jsonCharacters.length > 0)
            {
                var titleChar:TitleCharData = Json.parse(Assets.getText(Paths.json('data/states/title/chars/' + jsonCharacters[i])));

                tCharVisible = titleChar.visible;

                if (tCharVisible)
                {
                    tCharAssets = Paths.getSparrowAtlas('states/titles/' + titleChar.assetPath);
                    tCharMain = new FlxSprite();
                    tCharMain.antialiasing = true;
                    tCharMain.frames = tCharAssets;
                    tCharMain.offsets.set(titleChar.position[0], titleChar.position[1]);

                    tCharAnimation = titleChar.animation;
                    if (tCharAnimation != null && tCharAnimation.length > 0)
                    {
                        for (anim in tCharAnimation)
                        {
                            var animName:String = '' + anim.name;
                            var animPref:String = '' + anim.prefix;
                            var animFps:Int = anim.frameRate ?? 24;
                            var animLoop:Bool = !!anim.looped;
                            var animIndc:Array<Int> = anim.indices;

                            if (animIndc != null && animIndc.length > 0)
                            {
                                tCharMain.animation.addByIndices(animName, animPref, animIndc, "", animFps, animLoop);
                            }
                            else
                            {
                                tCharMain.animation.addByPrefix(animName, animPref, animFps, animLoop);
                            }

                            if(tCharAnimName.startsWith('dance'))
                                tCharMain.animation.play('danceRight');
                            else
                                tCharMain.animation.play('idle');
                            
                            tCharAnimName = animName;
                        }
                    }
                }
            }
        }

        isTextYee = json.initHandler;
    }
}