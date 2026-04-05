package funkin.play;

import funkin.data.stages.StageData;
import funkin.data.songs.SongData;
import funkin.objects.FunkinSprite;
import funkin.objects.Character;
import funkin.api.scripting.ScriptManager;

class Stage extends FlxTypedGroup<FunkinSprite>
{
    public var id:String = "";
    public var data:StageMetadata;

    public var props:Map<String, FunkinSprite> = [];

    public function new(id:String)
    {
        super();

        this.id = id;

        data = StageMetadata.fromStageId(id);

        for (prop in data.props)
        {
            var assetPath = haxe.io.Path.join([data.directory, prop.assetPath]);
            var sprite = new FunkinSprite(prop.position[0], prop.position[1]);

            switch(prop.renderType)
            {
                default: //case Image:
                    sprite.loadGraphic(Paths.image(assetPath));
                case Sparrow:
                    sprite.frames = FunkinAssets.getSparrow(assetPath);
            }

            for (anim in prop.animations)
                sprite.addAnimationData(anim.name, anim);
            if (prop.animations.length > 0)
                sprite.playAnimation(prop.animations[0].name);

            sprite.zIndex = prop.zIndex;
            sprite.antialiasing = (ClientPrefs.data.antialiasing && prop.antialiasing);
            sprite.scale.set(prop.scale[0], prop.scale[1]);
            sprite.scrollFactor.set(prop.scrollFactor[0], prop.scrollFactor[1]);
            sprite.flipX = prop.flipX;
            sprite.flipY = prop.flipY;
            sprite.alpha = prop.alpha;

            props.set(prop.name, sprite);
            add(sprite);
        }

        for (ext in ScriptManager.LUA_EXTENSIONS.concat(ScriptManager.HSCRIPT_EXTENSIONS))
        {
            var script = PlayState.instance.scripts.loadFromFile("scripts/play/stages/" + id + "." + ext, this, true, false);

            if (script != null)
            {
                script.set("add", add);
                script.set("remove", remove);
                script.set("members", members);
                script.set("insert", insert);

                script.call("onLoad");
            }
        }
    }

    public function addCharacter(character:Character, type:CharacterType)
    {
        var targetProp:StageCharacterData = null;
        switch(type)
        {
            default:
                targetProp = data.characters.player;
            case OPPONENT:
                targetProp = data.characters.opponent;
            case SPECTATOR:
                targetProp = data.characters.spectator;
        }

        character.zIndex = targetProp.zIndex;
        character.x = character.data.offset[0] + targetProp.position[0] - character.characterOrigin.x;
        character.y = character.data.offset[1] + targetProp.position[1] - character.characterOrigin.y;

        character.scale.x = character.data.scale[0] * targetProp.scale[0];
        character.scale.y = character.data.scale[1] * targetProp.scale[1];

        character.cameraOffset = FlxPoint.get(character.data.cameraOffset[0], character.data.cameraOffset[1]);
        character.cameraOffset.x += targetProp.cameraOffset[0];
        character.cameraOffset.y += targetProp.cameraOffset[1];

        add(character);

        sortByZIndex();
    }

    public function sortByZIndex()
    {
        sort(function(i, a, b)
		{
            if (a.zIndex > b.zIndex)
                return 1;
            else
                return -1;
		});
    }
}