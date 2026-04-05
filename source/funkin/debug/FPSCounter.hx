package funkin.debug;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
class FPSCounter extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	/**
		The current memory usage (WARNING: this is NOT your total program memory usage, rather it shows the garbage collector memory)
	**/
	public var memoryMegas(get, never):Float;

	public function new()
	{
		super();

		this.x = 3;
		this.y = 3;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat(Paths.font("vcr"), 14);
		autoSize = LEFT;
		multiline = true;
		textColor = 0xFFFFFFFF;
		text = "FPS: ";
	}

	var deltaTimeout:Float = 0.0;

	// Event Handlers
	private override function __enterFrame(deltaTime:Float):Void{
		deltaTimeout += deltaTime;
		if (deltaTimeout >= 16) {
			currentFPS = Math.floor(1000 / deltaTime);
			updateText();
			deltaTimeout = 0.0;
		}
	}

	public dynamic function updateText():Void { // so people can override it in hscript
		text = 'FPS: ${currentFPS} • Memory: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)}';
	}

	inline function get_memoryMegas():Float
		return System.totalMemoryNumber;
}