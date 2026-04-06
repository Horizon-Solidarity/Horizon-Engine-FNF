package funkin.debug;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import lime.app.Application;
import openfl.system.System;
import flixel.util.FlxColor;

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

	public var memoryPeak:Float = 0;

	public function new()
	{
		super();

		this.x = 3;
		this.y = 3;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 14);
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
		text = '${currentFPS} FPS';
		text += '\n${flixel.util.FlxStringUtil.formatBytes(memoryMegas)} / ${flixel.util.FlxStringUtil.formatBytes(memoryPeak)}';
	}

	inline function get_memoryMegas():Float
	{
		if (System.totalMemoryNumber > memoryPeak)
			memoryPeak = System.totalMemoryNumber;
		return System.totalMemoryNumber;
	}
}