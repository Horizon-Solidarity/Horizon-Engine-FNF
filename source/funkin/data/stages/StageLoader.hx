package funkin.data.stages;

import funkin.data.stages.StageData;

class StageLoader
{
    public static function dummy():StageMetadata
    {
        return {
            directory: "",
            name: ""
            cameraSpeed: 1,
            character: {
                player: {
                    zIndex: 0,
                    position: [770, 100],
                    cameraPos: [0, 0]
                }
            }
        }
    }

	public static function getStageFile(stage:String):StageFile {
		try
		{
			var path:String = Paths.getPath('stages/' + stage + '.json', TEXT, null, true);
			#if MODS_ALLOWED
			if(FileSystem.exists(path))
				return cast tjson.TJSON.parse(File.getContent(path));
			#else
			if(Assets.exists(path))
				return cast tjson.TJSON.parse(Assets.getText(path));
			#end
		}
		return dummy();
	}
}