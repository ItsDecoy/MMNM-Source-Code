package;

import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxSprite;
import openfl.filters.ShaderFilter;
import flixel.FlxG;

// Programmed by Ighby
class MarioSevenStart extends MusicBeatState
{
    var path = 'marioseven/';
    var spriteScale = 3;

    var options:Array<String> = ['Mario 3', 'Mario 5', 'Mario Missing', 'Mario 10', 'Mario 11', 'Mario 14', 'Mario 7'];
    var curSelect = 0;

    var caninteract:Bool = false;

    var title:FlxSprite;
    var SevCursor:FlxSprite;
    var defcursorY:Float = 0;

    override function create()
    {
        title = new FlxSprite().loadGraphic(Paths.image(path + 'mario7menu', 'preload'));
        title.setGraphicSize(Std.int(title.width * spriteScale));
        title.updateHitbox();
        title.scrollFactor.set();
        title.screenCenter();
        title.color = FlxColor.BLACK;
        add(title);

        SevCursor = new FlxSprite(title.x, title.y).loadGraphic(Paths.image(path + 'cursor', 'preload'));
        SevCursor.setGraphicSize(Std.int(SevCursor.width * spriteScale));
        SevCursor.updateHitbox();
        SevCursor.scrollFactor.set();
        SevCursor.x += 69 * spriteScale;
        SevCursor.y += 64 * spriteScale;
        defcursorY = SevCursor.y;
        SevCursor.visible = false;
        add(SevCursor);

        var tweenTime = 0.2;
        FlxTween.color(title, tweenTime/2, FlxColor.BLACK, FlxColor.ORANGE, {onComplete: function(twn:FlxTween)
        {
            FlxTween.color(title, tweenTime/2, FlxColor.ORANGE, FlxColor.WHITE, {onComplete: function(twn:FlxTween)
            {
                SevCursor.visible = true;
                caninteract = true;
            }});
        }});

        FlxG.camera.setFilters([new ShaderFilter(new CRTShader(1))]);
        super.create();
    }

    override function update(elapsed:Float)
    {
        var up = controls.UI_UP_P && caninteract;
        var down = controls.UI_DOWN_P && caninteract;
        var back = controls.BACK && caninteract;
        var accept = controls.ACCEPT && caninteract;
        var ctrl = FlxG.keys.justPressed.CONTROL && caninteract;

        if (up)
        {
            curSelect -= 1;
            if (curSelect < 0) curSelect = options.length - 1;
        }
        if (down)
        {
            curSelect += 1;
            if (curSelect >= options.length) curSelect = 0;
        }
        SevCursor.y = defcursorY + (curSelect * (16 * spriteScale));

		if (back)
		{
			persistentUpdate = false;
            FlxG.camera.visible = false;
			FlxG.sound.play(Paths.sound('Bump'));
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
			MusicBeatState.switchState(new AllStarsState());
		}

        if (accept)
        {
            switch (options[curSelect])
            {
                // At least these are funnier than NHJ
                case "Mario 3":
                    FlxG.sound.play(Paths.sound('funny/boom'));
                case "Mario 5":
                    FlxG.sound.play(Paths.sound('funny/ding'));
                case "Mario Missing":
                    FlxG.sound.play(Paths.sound('funny/mim'));
                case "Mario 10":
                    FlxG.sound.play(Paths.sound('funny/bruh'));
                case "Mario 11":
                    FlxG.sound.play(Paths.sound('funny/cartoon_run'));
                case "Mario 14":
                    FlxG.sound.play(Paths.sound('funny/boing'));
                
                    // "Mario 7? that's the one I played? well let's check it out-"
                case 'Mario 7':
                    PlayState.storyWeek = 8;
                    
                    var songArray:Array<String> = [];
                    var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[PlayState.storyWeek]).songs;
                    for (i in 0...leWeek.length) {
                        songArray.push(leWeek[i][0]);
                    }

                    PlayState.resetProperties();
                    PlayState.storyPlaylist = songArray;
                    PlayState.isStoryMode = true;

                    var diffic = CoolUtil.getDifficultyFilePath(1);
                    if(diffic == null) diffic = '';

                    PlayState.storyDifficulty = 1;
                    PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());


                    ClientPrefs.unlockedGrandDad = true;
                    FlxG.save.data.unlockedGrandDad = ClientPrefs.unlockedGrandDad;
                    FlxG.save.flush();
                    
                    caninteract = false;

                    FlxG.sound.list.forEachAlive(function(sound:FlxSound)
                    {
                        sound.stop();
                    });

                    FlxG.sound.play(Paths.sound('funny/marioseven'));
                    new FlxTimer().start(3.5, function(timer:FlxTimer)
                    {
                        SevCursor.visible = false;
                        var tweenTime = 0.2;
                        FlxTween.color(title, tweenTime/2, FlxColor.WHITE, FlxColor.ORANGE, {onComplete: function(twn:FlxTween)
                        {
                            FlxTween.color(title, tweenTime/2, FlxColor.ORANGE, FlxColor.BLACK, {onComplete: function(twn:FlxTween)
                            {
                                FlxTransitionableState.skipNextTransIn = true;
                                LoadingState.showLoading = false;
                                LoadingState.loadAndSwitchState(new PlayState());
                            }});
                        }});
                    });

            }
        }

		if(ctrl)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}

        super.update(elapsed);
    }
}