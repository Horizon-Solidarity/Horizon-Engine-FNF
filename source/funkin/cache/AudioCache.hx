package funkin.cache;

import openfl.media.Sound;

class AudioCache
{
    public static var cache:Map<String, Sound> = [];

    public static function get(key:String):Sound
        return cache.get(key);
    public static function exists(key:String):Bool
        return cache.exists(key);

    public static function load(key:String):Sound
    {
        cache.set(key, Sound.fromFile(key));
        return cache.get(key);
    }
}