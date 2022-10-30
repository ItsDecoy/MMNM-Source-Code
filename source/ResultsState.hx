package;

import flixel.addons.display.FlxBackdrop;
import flixel.math.FlxMath;
import flixel.FlxBasic;
import flixel.util.FlxTimer;
import flixel.group.FlxSpriteGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;

// Coded by Ighby
class ResultsState extends MusicBeatState
{
    var path = 'resultScreen/';

    private static var statsList:Array<SongStats> = [];
    public static var cutscene:String = '';
    public static var showThanksScreen = false;

    var bg:FlxBackdrop;
    
    var accepted = false;

    var titleCharList:FlxSpriteGroup;
    var timeElapsed:Float;

    var songStatsTexts:Map<String, Array<ScoreText>> = new Map<String, Array<ScoreText>>();
    var songStatsIcons:Map<String, HealthIcon> = new Map<String, HealthIcon>();
    var songStatsRatingSprite:Map<String, FlxSprite> = new Map<String, FlxSprite>();

    var skippedSequence = false;

    override public function new()
    {
        FlxTransitionableState.skipNextTransOut = true;
        super();
    }

    override public function create()
    {
        persistentUpdate = true;

        if (statsList.length == 0)
            // If there are no stats loaded, it just loads familiar but with dummy info
            // It's basically just to prevent a crash
            statsList.push(new SongStats('Familiar', 69420, 0, 100, 'SFC', 'fh'));

		bg = new FlxBackdrop(Paths.image(path + 'bg_pattern', 'preload'), 1, 1, true, true);
		bg.scrollFactor.set();
		bg.antialiasing = false;
        bg.velocity.set(-40, -40);
        bg.alpha = 0;
        FlxTween.tween(bg, {alpha: 1}, 1, {startDelay: 0.5});
		add(bg);

        var wall = new FlxSprite().loadGraphic(Paths.image(path + 'score_wall', 'preload'));
        wall.setGraphicSize(Std.int(FlxG.width));
        wall.updateHitbox();
        wall.antialiasing = ClientPrefs.globalAntialiasing;
        wall.screenCenter();
        wall.x += wall.width;
        add(wall);

        Conductor.changeBPM(135);

        FlxG.sound.playMusic(Paths.sound('results/victoryTheme'), 0.9, false);

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
            FlxTween.tween(letter, {x: titleCharList.x + letter.x - 360, alpha: 1}, 0.5, {ease: FlxEase.expoOut, startDelay: 0.2 + letter.ID * 0.03});
            titleCharList.add(letter);
        }

        for (i in 0...statsList.length)
        {
            var txtheight:Float = 0;
            var textList:Array<ScoreText> = [];

            var icon:HealthIcon = new HealthIcon(statsList[i].songIcon, false);
            icon.x = FlxG.width*0.32;
            icon.y = 150 + (i * 160);
            add(icon);

            var tweenShit = FlxG.width - icon.x;

            songStatsIcons.set(statsList[i].songName, icon);

            for (j in 0...4)
            {
                var txtsize = j == 0 ? 42 : 30;
                var texto:FlxText;

                if (j == 0) // The song name
                {
                    var title:FlxText = new FlxText(icon.x + icon.width, icon.y + txtheight - 15, 0, statsList[i].songName, txtsize, true);
                    title.color = FlxColor.RED;
                    texto = title;
                }
                else // the actual score
                {
                    var stat:String = 'Score';
                    var targetVal:Float = statsList[i].songScore;
                    switch (j)
                    {
                        case 2:
                            stat = 'Misses';
                            targetVal = statsList[i].songMisses;
                        case 3:
                            stat = 'Accuracy';
                            targetVal = statsList[i].songAccuracy * 100;
                    }
                    var result:ScoreText = new ScoreText(icon.x + icon.width, icon.y + txtheight - 15, 0, stat, txtsize, true, 0);
                    result.color = FlxColor.WHITE;
                    texto = result;
                    textList.push(result);

                    FlxTween.tween(result, {scoreValue: targetVal}, 1, {startDelay: (Conductor.crochet / 1000)});
                }
                
                texto.setFormat(Paths.font('Pixel_NES.otf'), txtsize, texto.color, LEFT, OUTLINE, FlxColor.BLACK);
                texto.borderSize = texto.size / 10;
                add(texto);

                texto.x += tweenShit;
                FlxTween.tween(texto, {x: texto.x - tweenShit}, 0.5, {startDelay: (Conductor.crochet / 1000) + (i * 0.05) + (j * 0.05), ease: FlxEase.expoOut});

                txtheight += texto.size;
            }

            var rating:FlxSprite = new FlxSprite();
            rating.frames = Paths.getSparrowAtlas(path + 'ratings/' + statsList[i].songGrade.toUpperCase() + '_assets');
            rating.animation.addByPrefix('invisible', statsList[i].songGrade.toUpperCase() + '_animation0000', 24, false);
            rating.animation.addByPrefix('anim', statsList[i].songGrade.toUpperCase() + '_animation', 24, false);
            rating.animation.play('invisible', true);
            rating.antialiasing = ClientPrefs.globalAntialiasing;
            rating.setGraphicSize(Std.int(rating.width * (statsList.length == 1 ? 1 : 0.7)));
            rating.updateHitbox();
            rating.x = statsList.length == 1 ? FlxG.width * 0.65 : FlxG.width * 0.85;
            rating.y = statsList.length == 1 ? FlxG.height * 0.68 : icon.y + icon.height/2;
            rating.x -= rating.width / 2;
            rating.y -= rating.height / 2;
            add(rating);

            new FlxTimer().start((Conductor.crochet / 1000) * 2.85, function(tmr:FlxTimer)
            {
                if (!skippedSequence) rating.animation.play('anim', true);
            });

            icon.x += tweenShit;
            FlxTween.tween(icon, {x: icon.x - tweenShit}, 0.4, {startDelay: (Conductor.crochet / 1000) + i * 0.05, ease: FlxEase.expoOut});
            songStatsTexts.set(statsList[i].songName, textList);
        }
        
        FlxTween.tween(wall, {x: wall.x - wall.width}, 0.8, {ease: FlxEase.expoOut, startDelay: 0.2});

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

        if (FlxG.sound.music != null)
        {
            Conductor.songPosition = FlxG.sound.music.time;
        }

        var back = controls.BACK && !accepted;
        var accept = controls.ACCEPT && !accepted;

        titleCharList.forEachAlive(function(letter:FlxSprite)
        {
            letter.color = colorsArray[(Std.int(timeElapsed * 7) + letter.ID) % colorsArray.length];
            letter.y = 20 + Math.sin((timeElapsed * 5) - letter.ID) * 5;
        });

        if (back || accept)
        {
            if (!skippedSequence)
            {
                finishSequence();
            }
            else
            {
                accepted = true;
                FlxG.sound.play(Paths.sound('results/Clear', 'preload'), 1);

                new FlxTimer().start(0.6, function(timer:FlxTimer) // Screens turns black
                {
                    FlxG.camera.visible = false;

                    new FlxTimer().start(0.6, function(timer2:FlxTimer) // the rest of the shit
                    {
                        if (cutscene != '')
                        {
                            Main.fpsVar.visible = false;
                            (new FlxVideo(Paths.video(cutscene))).finishCallback = function()
                            {
                                Main.fpsVar.visible = ClientPrefs.showFPS;
                                moveOn();
                            }
                            cutscene = '';
                        }
                        else
                            moveOn();
                    });
                });
            }
        }

        super.update(elapsed);
    }

    public function moveOn()
    {
        if (showThanksScreen)
        {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
            MusicBeatState.switchState(new ThanksState());
            showThanksScreen = false;
        }
        else
        {
            FlxG.sound.playMusic(Paths.music('freakyMenu'));

            if (PlayState.isStoryMode)
                MusicBeatState.switchState(new MainMenuState());
            else
                MusicBeatState.switchState(new FreeplayState());
        }

        statsList = [];
    }

    private function finishSequence():Void
    {
        this.forEachAlive(function(spr:FlxBasic)
        {
            FlxTween.completeTweensOf(spr);
        });

        for (i in 0...statsList.length)
        {
            var grade = statsList[i].songGrade;
            if (grade == 'FC' || grade == 'GFC' || grade == 'SFC')
            {
                songStatsIcons.get(statsList[i].songName).animation.curAnim.curFrame = 1;
            }
        }
        FlxG.camera.flash(FlxColor.WHITE, 0.3);
        FlxG.sound.play(Paths.sound('results/Powerup', 'preload'), 0.7);
        skippedSequence = true;
    }

    override function beatHit()
	{
		super.beatHit();
        switch (curBeat)
        {
            case 1:
                if (!skippedSequence)
                {
                    FlxG.sound.play(Paths.sound('results/countdown', 'preload'), 0.7);
                }
            case 4:
                if (!skippedSequence) finishSequence();
        }
    }

    public static function AddSongStats(songName:String, songScore:Float, songMisses:Int, songAccuracy:Float, grade:String, icon:String = 'bf')
    {
        var stats:SongStats = new SongStats(songName, songScore, songMisses, songAccuracy, grade, icon);
        statsList.push(stats);
    }
}

class ScoreText extends FlxText
{
    public var scoreValue(default, set):Float;
    public var scoreText(default, set):String;

    public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true, value:Float = 0)
    {
        super(X, Y, FieldWidth, Text, EmbeddedFont);
        scoreText = Text;
        scoreValue = value;
    }

    private function updateScoreText(textIn:String, valueIn:Float)
    {
        if (textIn.toLowerCase() == 'accuracy') text = textIn + ': ' + Highscore.floorDecimal(valueIn, 2) + '%';
        else text = textIn + ': ' + Math.round(valueIn);
    }

	function set_scoreValue(value:Float):Float
    {
		updateScoreText(scoreText, value);
        return scoreValue = value;
	}

	function set_scoreText(value:String):String
    {
		updateScoreText(value, scoreValue);
        return scoreText = value;
	}
}

class SongStats
{
    public var songName:String;
    public var songScore:Float;
    public var songMisses:Int;
    public var songAccuracy:Float;
    public var songGrade:String;
    public var songIcon:String;

    public function new(songName:String, songScore:Float, songMisses:Int, songAccuracy:Float, songGrade:String, songIcon:String)
    {
        this.songName = songName;
        this.songScore = songScore;
        this.songMisses = songMisses;
        this.songAccuracy = songAccuracy;
        this.songGrade = songGrade;
        this.songIcon = songIcon;
    }
}