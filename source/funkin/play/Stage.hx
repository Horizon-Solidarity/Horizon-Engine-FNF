package funkin.play;

import funkin.data.stages.StageData;

class Stage extends FlxTypedGroup<FunkinSprite>
{
    public var id:String = "";
    public var data:StageMetadata;

    public function new(id:String)
    {
        this.id = id;

        data = StageMetadata.fromStageId(id);

        
    }
}