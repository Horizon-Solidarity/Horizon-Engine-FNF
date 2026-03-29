package funkin.play.ui;

import funkin.play.ui.notes.Strumline;

class UI extends FlxSpriteGroup
{
    public var noteStrumline:Strumline;

    // カメラを登録する
    public function setCamera(cam:FlxCamera):Void {
        forEach(function(member:FlxSprite) {
            member.scrollFactor.set(0, 0); // スクロール無効
            member.cameras = [cam]; // カメラを登録　
        });
    }

    // public function setHUD(skin:NoteSkinData, )
    public function setHUD()
    {
        /*
        noteStrumline = new Strumline({
            keyLength: ui.
        })
            */
    }
}