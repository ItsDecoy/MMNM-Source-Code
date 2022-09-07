package;

import flixel.group.FlxSpriteGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;

class ResultsState extends MusicBeatState
{
    var path = 'resultScreen/';

    private static var statsList:Array<SongStats> = [];
    public static var cutscene:String = '';

    var accepted = false;

    var titleCharList:FlxSpriteGroup;

    var timeElapsed:Float;

    override public function new()
    {
        FlxTransitionableState.skipNextTransOut = true;
        super();
    }

    override public function create()
    {
        persistentUpdate = true;

        if (statsList.length == 0) // If there are no stats loaded, it creates a dummy Placeholder one to avoid a crash.
            statsList.push(new SongStats('Bopeebo', 69420, 0, 100, 'SFC'));

        var wall = new FlxSprite().loadGraphic(Paths.image(path + 'score_wall', 'preload'));
        wall.setGraphicSize(Std.int(FlxG.width));
        wall.updateHitbox();
        wall.antialiasing = ClientPrefs.globalAntialiasing;
        wall.screenCenter();
        wall.x += wall.width;
        add(wall);

        titleCharList = new FlxSpriteGroup(FlxG.width/2, 0);
        add(titleCharList);

        var leText = 'RESULTS:';

        for (i in 0...leText.length)
        {
            var letter:FlxText = new FlxText(300 + i * 60, 20, 0, ' ' + leText.charAt(i) + ' ', 110, true);
            letter.setFormat(Paths.font('SuperMario.ttf'), 110, FlxColor.RED, CENTER, OUTLINE, FlxColor.BLACK);
            letter.borderSize = 3;
            letter.ID = i;
            letter.alpha = 0;
            letter.antialiasing = ClientPrefs.globalAntialiasing;
            FlxTween.tween(letter, {x: titleCharList.x + letter.x - 320, alpha: 1}, 0.5, {ease: FlxEase.expoOut, startDelay: 0.2 + letter.ID * 0.03});
            titleCharList.add(letter);
        }

        for (i in 0...statsList.length)
        {
            var result:FlxText = new FlxText(FlxG.width/2, 120, 0, '', 20, true);
            result.setFormat(Paths.font('Pixel_NES.otf'), 30, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
            result.antialiasing = ClientPrefs.globalAntialiasing;
            result.text = statsList[i].songName + ":\n" +
            "Score: " + statsList[i].songScore +
            "\nMisses: " + statsList[i].songMisses +
            "\nRating: " + Highscore.floorDecimal(statsList[i].songAccuracy * 100, 2) +
            "%\nGrade: " + statsList[i].songGrade + "\n";
            add(result);
        }

        FlxTween.tween(wall, {x: wall.x - wall.width}, 1, {ease: FlxEase.expoOut, startDelay: 0.2});

        super.create();
    }

    var colorsArray = [
        FlxColor.fromRGB(215, 14, 0),
        FlxColor.fromRGB(184, 12, 0),
        FlxColor.fromRGB(159, 11, 0),
        FlxColor.fromRGB(102, 7, 0),
        FlxColor.fromRGB(88, 6, 0),
        FlxColor.fromRGB(102, 7, 0),
        FlxColor.fromRGB(159, 11, 0),
        FlxColor.fromRGB(184, 12, 0),
    ];

    override function update(elapsed:Float)
    {
        timeElapsed += elapsed;

        var back = controls.BACK && !accepted;
        var accept = controls.ACCEPT && !accepted;

        titleCharList.forEachAlive(function(letter:FlxSprite)
        {
            letter.color = colorsArray[(Std.int(timeElapsed * 7) + letter.ID) % colorsArray.length];
            letter.y = 20 + Math.sin((timeElapsed * 5) - letter.ID) * 5;
        });

        if (back || accept)
        {
            accepted = true;

            if (cutscene != '')
            {
                FlxG.camera.visible = false;
                (new FlxVideo(Paths.video(cutscene))).finishCallback = function()
                {
                    moveOn();
                }
                cutscene = '';
            }
            else
                moveOn();
        }

        super.update(elapsed);
    }

    public function moveOn()
    {
        FlxG.sound.playMusic(Paths.music('freakyMenu'));

        if (PlayState.isStoryMode)
            MusicBeatState.switchState(new MainMenuState());
        else
            MusicBeatState.switchState(new FreeplayState());

        statsList = [];
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