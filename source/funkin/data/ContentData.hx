package funkin.data;

typedef ContentMetadata =
{
    var name:String;

    var description:String;
    @:default([])
    var contributors:Array<ModContributor>;
    var version:String;

    @:default(false)
    var global:Bool;


    @:optional var icon:String;
    @:optional var discordRpc:String;
}

typedef ModContributor =
{
    var name:String;

    /**
     * @default [""]
     */
    
    @:optional var icon:String;

    /**
     * @default [""]
     */
    @:default("")
    @:optional var role:String;

    /**
     * @default [null]
     */
    @:optional var url:String;
}