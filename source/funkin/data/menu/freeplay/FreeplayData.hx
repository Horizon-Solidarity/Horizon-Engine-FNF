package funkin.data.menu.freeplay;

// ____________________________________________ Metadata ____________________________________________
typedef FreeplayMetadata =
{
    var characterSelect:Bool;
    var playableCharacter:Array<FreeplayPlayable>;
}

typedef FreeplayPlayable =
{
    var name:String; // data/players/$name
    var categories:Array<String>; // data/states/freeplay/$name-$categories[i]
}

// ____________________________________________ Main Data ____________________________________________

typedef FreeplayCategoryData =
{
    var categoryData:String;
    var difficulty:Array<String>;
    var songs:Array<FreeplaySongData>;
}

typedef FreeplaySongData =
{
    var id:String;
    var includeDiffs:Array<String>;
    var rating:Array<Int>;
}