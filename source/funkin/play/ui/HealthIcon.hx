package funkin.play.ui;

import funkin.data.character.CharacterData;
import funkin.data.character.HealthIconData;
import flixel.graphics.frames.FlxImageFrame;

class HealthIcon extends funkin.objects.FunkinSprite
{
    public var id:String;
	public var data:HealthIconMetadata;

    public function new(id:String)
    {
        super();

        this.id = id;
        data = HealthIconMetadata.fromIconId(id);

        var iconSize:Int = data.hasWinning ? 3 : 2;

        switch(data.renderType)
		{
			default: //case Slice:
                var target = Paths.image("icons/" + id + "/icons");
				if (target == null)
                    target = Paths.image("icons/" + id);


			    loadGraphic(target); //Load stupidly first for getting the file size
			    loadGraphic(target, true, Math.floor(width / iconSize), Math.floor(height));

                animation.add("normal", [0]);
                animation.add("losing", [1]);
                if (data.hasWinning)
                    animation.add("winning", [2]);

			    animation.play("normal");
            case Multiple:
                loadGraphic(Paths.image("icons/" + id + "/normal"));
            case Sparrow:
                frames = FunkinAssets.getSparrow("icons/" + id + "/icons");
                for (anim in data.animations)
                {
                    addAnimationData(anim.name, anim);
                }
		}
    }

    override public function playAnimation(anim:String, force:Bool = false)
    {
        if (data.renderType == Multiple)
        {
            if (animationExists(anim))
                loadGraphic(Paths.image("icons/" + id + "/" + anim));
            return;
        }
        super.playAnimation(anim);
    }

    override public function animationExists(name:String)
    {
        if (data.renderType == Multiple)
            return Paths.image("icons/" + id + "/" + name) != null;
        return super.animationExists(name);
    }
}