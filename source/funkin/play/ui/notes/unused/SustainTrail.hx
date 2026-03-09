package funkin.play.ui.notes;

import flixel.graphics.tile.FlxDrawTrianglesItem.DrawData;
import funkin.data.songs.SongData.ChartNotesData;

class SustainTrail
{
    /**
     * The triangles corresponding to the hold, followed by the endcap.
     * `top left, top right, bottom left`
     * `top left, bottom left, bottom right`
     */
    static final TRIANGLE_VERTEX_INDICES:Array<Int> = [0, 1, 2, 1, 2, 3, 4, 5, 6, 5, 6, 7];
    
    public var noteData:Null<ChartNotesData>;

    public var scoreable:Bool = true;
    
    public var yOffset:Float = 0.0;
    
    public var vertices:DrawData<Float> = new DrawData<Float>();
    
    public var customVertexData:Bool = false;

    public var noteStyleOffsets:Array<Float>;

    var graphicWidth:Float = 0;
    var graphicHeight:Float = 0;

    public function new(value) {
        
    }
}