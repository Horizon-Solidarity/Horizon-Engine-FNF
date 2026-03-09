package funkin.data.news;

typedef NewsMetadata =
{
    var head:NewsHeaderData;
    var body:Array<NewsBodyData>;
}

typedef NewsHeaderData =
{
    var title:String;
    var date:String;
    var version:String;
    var iconPath:String;
    var headerPath:String;
}

typedef NewsBodyData =
{
    var type:String;
    var data:Dynamic;
}