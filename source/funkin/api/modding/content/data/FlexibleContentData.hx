package funkin.api.modding.content.data;

typedef ContentMetadata =
{
    var modName:String;
    var description:String;
    var iconPath:String;
    var headerPath:String;
    var contributor:Array<ModsContributor>;
    var warningsStartSetting:ModsWarningSetting;
    var mod_version:String;
    var apiChanger:ModsAPIChanger;
    var dependencies:Array<Map<Map<String, String>, ModsDependencies>>;
    var api_version:Bool;
    var license:String;
    var global:Bool;
    var reload:Bool;
}

typedef ModsContributor =
{
    var name:String;
    var about:String;

    /**
     * @default [""]
     */
    @:optional var icons:String;

    /**
     * @default [""]
     */
    @:optional var role:String;

    /**
     * @default [""]
     */
    @:optional var workList:String;

    /**
     * @default [""]
     */
    @:optional var email:String;

    /**
     * @default [""]
     */
    @:optional var website:String;

    /**
     * @default [""]
     */
    @:optional var description:String;
}

typedef ModsWarningSetting =
{
    var settingStateVisible:Bool;

    /**
     * @default [true]
     */
    @:optional var flashing:Bool;

    /**
     * @default [false]
     */
    @:optional var lowQuality:Bool;

    /**
     * @default [true]
     */
    @:optional var richPresence:Bool;

    /**
     * @default [en-US]
     */
    @:optional var language:String;
}

typedef ModsAPIChanger = 
{
    /**
     * @default is Default Window Title
     */
    @:optional var windowTitle:String;

    /**
     * @default is Horizon's Discord ID
     */
    @:optional var discordClientID:String;

    /**
     * @default is Default Window Icon
     */
    @:optional var iconFilePath:String;
}

typedef ModsDependencies =
{
    /**
     * @default [false]
     */
    @:optional var optional:Bool;
}