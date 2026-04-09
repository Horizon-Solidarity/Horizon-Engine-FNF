package funkin.backend.game;

class ErrorState extends MusicBeatState
{
    final warningMessage:String;
    final continueCallback:Void->Void;

    public function new(message:String, callback:Void->Void)
    {
        this.warningMessage = message;
        this.continueCallback = callback;
        super();
    }

    override function create()
    {
        super.create();
    }
}