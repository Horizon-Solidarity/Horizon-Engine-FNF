package funkin.play.events;

import flixel.tweens.FlxEase;

class CameraFocusEvent extends Event
{
    override public function call()
    {
        super.call();

        var target = game.characterObjects.get(game.song.characters[getArgValue("target")]).character;
        game.moveCamera(target.x + target.cameraOffset.x, target.y - target.cameraOffset.y, (Conductor.instance.stepCrochet / 1000) * getArgValue("duration"), Reflect.field(FlxEase, getArgValue("ease")));
    }

    override public function allowCallBeforeStart() return true;
}