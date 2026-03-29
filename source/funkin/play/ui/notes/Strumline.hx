package funkin.play.ui.notes;

class Strumline
{
	public static final DEFAULT_SKIN:String = 'notes/noteStrumline';

	public function new(param:StrumlineParam) {

	}
}

typedef StrumlineParam =
{
	// var _skin:String;
	var keyLength:Int;
	var noteScale:Float;
	var noteDistance:Float;
	var noteOffsets:Array<Float>;
	var noteVisible:Bool;
	// @:optional var noteMoveType:T;
}