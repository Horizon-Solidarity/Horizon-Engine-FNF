package funkin.util;

import lime.app.Application;

class APIUtil
{
    public static var API_VERSION:String = '';

    public static function apiInit()
    {
        API_VERSION = Application.current.meta.get('version');
    }
}