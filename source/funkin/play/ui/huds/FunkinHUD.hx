package funkin.play.ui.huds;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import funkin.play.ui.HealthIcon;

class FunkinHUD extends HUD
{
    var healthLerp:Float = 1;
    var healthBarBG:FlxSprite;
    var healthBar:FlxBar;

    var scoreLerp:Float = 0;
    var scoreText:FlxText;

    var iconP1:HealthIcon;
    var iconP2:HealthIcon;

    override public function load():Void
    {
        super.load();

        healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('ui/funkin/healthBar'));
        healthBarBG.screenCenter(FlxAxes.X);
        add(healthBarBG);

        healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, FlxBarFillDirection.RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), null, '', 0, 2);
        healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
        add(healthBar);

        iconP1 = new HealthIcon(game.characterObjects.get(game.song.player).character.data.healthIcon.id);
        iconP1.flipX = true;
        iconP1.y = healthBar.y - (iconP1.height / 2);
        add(iconP1);

        iconP2 = new HealthIcon(game.characterObjects.get(game.song.opponent).character.data.healthIcon.id);
        iconP2.y = healthBar.y - (iconP2.height / 2);
        add(iconP2);

        scoreText = new FlxText(healthBarBG.x + healthBarBG.width - 190, healthBarBG.y + 30, 0, '', 20);
        scoreText.setFormat(Paths.font('vcr'), 16, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreText.antialiasing = ClientPrefs.data.antialiasing;
        add(scoreText);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        healthLerp = FlxMath.lerp(healthLerp, game.health, 0.15);
        healthBar.value = healthLerp;

        scoreText.text = "Score: " + FlxStringUtil.formatMoney(game.stats.score, false, true);


        iconP1.x = healthBar.x
            + (healthBar.width * (FlxMath.remapToRange(healthBar.value, 0, 2, 100, 0) * 0.01) - 26);

        iconP2.x = healthBar.x
            + (healthBar.width * (FlxMath.remapToRange(healthBar.value, 0, 2, 100, 0) * 0.01))
            - (iconP2.width - 26);

        iconP1.scale.set(FlxMath.lerp(iconP1.data.scale[0], iconP1.scale.x, Math.exp(-elapsed * 9)), FlxMath.lerp(iconP1.data.scale[1], iconP1.scale.y, Math.exp(-elapsed * 9)));
        iconP2.scale.set(FlxMath.lerp(iconP2.data.scale[0], iconP2.scale.x, Math.exp(-elapsed * 9)), FlxMath.lerp(iconP2.data.scale[1], iconP2.scale.y, Math.exp(-elapsed * 9)));

        if (healthBar.percent < 20)
        {
            iconP1.playAnimation("losing");
            iconP2.playAnimation("winning");
        }
        else if (healthBar.percent > 80)
        {
            iconP1.playAnimation("winning");
            iconP2.playAnimation("losing");
        }
        else
        {
            iconP1.playAnimation("normal");
            iconP2.playAnimation("normal");
        }
    }

    override public function beatHit(beat:Int)
    {
        super.beatHit(beat);

        iconP1.scale.set(iconP1.data.scale[0] + 0.2, iconP1.data.scale[1] + 0.2);
        iconP2.scale.set(iconP2.data.scale[0] + 0.2, iconP2.data.scale[1] + 0.2);
    }
}