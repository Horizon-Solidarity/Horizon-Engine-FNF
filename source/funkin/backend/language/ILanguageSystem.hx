package funkin.backend.language;

class ILanguageSystem
{
    public static final DEFAULT_LANGUAGE:String = 'English (US)';
    
	private static var phrases:Map<String, String> = [];

    public static function reloadPhrases()
    {
        var langFile:String = ClientPrefs.data.language;
        var fileLoad:String = Paths.getPath('data/languages/$langFile.lang')
    }
}