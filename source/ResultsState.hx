package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;

class ResultsState extends MusicBeatState
{
    private static var statsList:Array<SongStats> = [];

    var accepted = false;

    override public function create()
    {
        persistentUpdate = true;

        if (statsList.length == 0) // If there are no stats loaded, it creates a dummy Placeholder one to avoid a crash.
            statsList.push(new SongStats('Bopeebo', 69420, 0, 100, 'SFC'));

        var text:FlxText = new FlxText(0, FlxG.height * 0.9, FlxG.width, 'Funny Results:', 50, true);
        text.setFormat(Paths.font('Pixel_NES.otf'), 50, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        add(text);

        for (i in 0...statsList.length)
        {
            var result:FlxText = new FlxText(20 + (i * 300), 30, 0, '', 20, true);
            result.setFormat(Paths.font('Pixel_NES.otf'), 30, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
            result.text = statsList[i].songName + ":\n" +
            "Score: " + statsList[i].songScore +
            "\nMisses: " + statsList[i].songMisses +
            "\nRating: " + Highscore.floorDecimal(statsList[i].songAccuracy * 100, 2) +
            "%\nGrade: " + statsList[i].songGrade + "\n";
            add(result);
        }


        super.create();
    }

    override function update(elapsed:Float)
    {
        var back = controls.BACK && !accepted;
        var accept = controls.ACCEPT && !accepted;

        if (back || accept)
        {
            accepted = true;
            
            if (PlayState.isStoryMode)
                MusicBeatState.switchState(new MainMenuState());
            else
                MusicBeatState.switchState(new FreeplayState());

            statsList = [];
        }

        super.update(elapsed);
    }

    public static function AddSongStats(songName:String, songScore:Float, songMisses:Int, songAccuracy:Float, grade:String)
    {
        var stats:SongStats = new SongStats(songName, songScore, songMisses, songAccuracy, grade);
        statsList.push(stats);
    }
}

class SongStats
{
    public var songName:String;
    public var songScore:Float;
    public var songMisses:Int;
    public var songAccuracy:Float;
    public var songGrade:String;

    public function new(songName:String, songScore:Float, songMisses:Int, songAccuracy:Float, songGrade:String)
    {
        this.songName = songName;
        this.songScore = songScore;
        this.songMisses = songMisses;
        this.songAccuracy = songAccuracy;
        this.songGrade = songGrade;
    }
}