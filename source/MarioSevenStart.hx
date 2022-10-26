package;

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
			MusicBeatState.switchState(new FreeplayState());
		}

        if (accept)
        {
            switch (options[curSelect])
            {
                // "Mario 7? that's the one I played? well let's check it out-"
                case 'Mario 7':
                    PlayState.storyWeek = 8;
                    
                    var songArray:Array<String> = [];
                    var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[PlayState.storyWeek]).songs;
                    for (i in 0...leWeek.length) {
                        songArray.push(leWeek[i][0]);
                    }

                    PlayState.storyPlaylist = songArray;
                    PlayState.isStoryMode = false;
                    PlayState.chartingMode = false;

                    var diffic = CoolUtil.getDifficultyFilePath(1);
                    if(diffic == null) diffic = '';

                    PlayState.storyDifficulty = 1;

                    PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
                    PlayState.campaignScore = 0;
                    PlayState.campaignMisses = 0;

                    caninteract = false;

                    FreeplayState.destroyFreeplayVocals();
                    FlxTransitionableState.skipNextTransIn = true;
                    LoadingState.loadAndSwitchState(new PlayState());
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