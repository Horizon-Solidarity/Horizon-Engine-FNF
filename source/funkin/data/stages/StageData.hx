package funkin.data.stages;

typedef StageMetadata =
{
    var directory:String;
    var name:String;
    var cameraSpeed:Float;
    var character:StageCharacterMetadata;
    // var props:Array<StagePropsData>;
}

typedef StageCharacterMetadata =
{
    var player:StageCharacterData;
}

typedef StageCharacterData =
{
    var zIndex:Int;
    var position:Array<Float>;
    var cameraPos:Array<Float>;
}