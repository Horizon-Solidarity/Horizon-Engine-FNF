package funkin.play.ui.notes;

class NoteSprite
{
    /**
     * Default Note Color
     */
    public static final defaultNoteColor:Array<String> = ['purple', 'blue', 'green', 'red'];

    /**
     * Note Type (default)
     * @default ''
     * 
     * variations:
     * * Alt Animation: Playing '$AnimName-alt' Animation
     * * Hey!!: Playing 'hey' Animation
     * * Hurt Note: Misses Note
     * * Center Char Singing: Center Character Sing
     * * Non Anim Playing: Animation dose not play
     * * Non Scoreable: doesn't affect scores and ranks, or play miss animations.
     */
    public static final defaultNoteType:Array<String> = [
        '',
        'Alt Animation',
        'Hey!!',
        'Hurt Note',
        'Center Char Singing',
        'Non Anim Playing',
        'Non Scoreable'
    ];

    /**
     * Default Note Texture
     * in folder: states/play/ui/funkin/
     */
    public static var noteSkin(default, never):String = 'notes/NOTE_assets';

    /**
     * Notes ID
     * Opponent: 0 ~ 3
     * Player: 4 ~ 7
     */
    public var notesID:Int;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var texture(default, set):String = null;
	private function set_texture(value:String):String {
		if(texture != value) reloadNote(value);

		texture = value;
		return value;
	}

    public function new(strumTime:Float, noteData:Int, ?prevNote:NoteSprite, ?sustainNote:Bool = false, ?inEditor:Bool = false, ?createdFrom:Dynamic = null)
    {
		super();
        
		antialiasing = ClientPrefs.data.antialiasing;
    }
}