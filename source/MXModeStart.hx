package;

import flixel.group.FlxGroup;
import flixel.effects.FlxFlicker;
import flixel.graphics.FlxGraphic;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets as OpenFlAssets;
import editors.ChartingState;
import editors.CharacterEditorState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Note.EventNote;
import openfl.events.KeyboardEvent;
import flixel.util.FlxSave;
import Achievements;
import flixel.addons.display.FlxBackdrop;

using StringTools;

// Programmed by Ighby
class MXModeStart extends MusicBeatState
{
    var path = 'mxstart/';

    var options:Array<String> = ['Play Game', 'Exit'];
    var optionSprGroup:FlxSpriteGroup;
    var bfScoreGroup:FlxSpriteGroup;
    var highscoreGroup:FlxSpriteGroup;
    var curSelect = 0;
    var title:FlxSprite;
    var mushcursor:FlxSprite;
    var merio:FlxSprite;
    var boyfriendTxt:FlxSprite;
    var spriteScale = 3;

    var acceptedYourFate = false;

    override function create()
    {
        title = new FlxSprite().loadGraphic(Paths.image(path + 'title', 'preload'));
        title.setGraphicSize(Std.int(title.width * spriteScale));
        title.updateHitbox();
        title.scrollFactor.set();
        title.screenCenter();
        add(title);

        optionSprGroup = new FlxSpriteGroup();
        add(optionSprGroup);

        mushcursor = new FlxSprite(title.x, title.y).loadGraphic(Paths.image(path + 'cursor', 'preload'));
        mushcursor.setGraphicSize(Std.int(mushcursor.width * spriteScale));
        mushcursor.updateHitbox();
        mushcursor.scrollFactor.set();
        mushcursor.x += 72 * spriteScale;
        add(mushcursor);

        boyfriendTxt = new FlxSprite(title.x, title.y).loadGraphic(Paths.image(path + 'boyfriend', 'preload'));
        boyfriendTxt.setGraphicSize(Std.int(boyfriendTxt.width * spriteScale));
        boyfriendTxt.updateHitbox();
        boyfriendTxt.scrollFactor.set();
        boyfriendTxt.x += 24 * spriteScale;
        boyfriendTxt.y += 16 * spriteScale;
        add(boyfriendTxt);

        var highscore = Highscore.getWeekScore('week1', 1);
        bfScoreGroup = makeNumbers(title.x + (24 * spriteScale), title.y + (24 * spriteScale), 0, 6);
        highscoreGroup = makeNumbers(title.x + (129 * spriteScale), title.y + (184 * spriteScale), highscore, 7);
        add(bfScoreGroup);
        add(highscoreGroup);

        for (i in 0...options.length)
        {
            var name:String = options[i].toLowerCase().replace(' ', '_');
            var spr = new FlxSprite(title.x, title.y).loadGraphic(Paths.image(path + name, 'preload'));
            spr.setGraphicSize(Std.int(spr.width * spriteScale));
            spr.updateHitbox();
            spr.scrollFactor.set();
            spr.x += 88 * spriteScale;
            spr.y += (144 + (15 * i)) * spriteScale;
            spr.ID = i;
            optionSprGroup.add(spr);
        }

        mushcursor.y = optionSprGroup.members[0].y;

        merio = new FlxSprite(title.x, title.y).loadGraphic(Paths.image(path + 'falsehero_sprite', 'preload'));
        merio.setGraphicSize(Std.int(merio.width * spriteScale));
        merio.updateHitbox();
        merio.scrollFactor.set();
        merio.x += 48 * spriteScale;
        merio.y += 176 * spriteScale;
        add(merio);

        FlxG.camera.setFilters([new ShaderFilter(new CRTShader(1))]);

        super.create();
    }

    private function makeNumbers(x:Float, y:Float, num:Float, maxDig:Int):FlxSpriteGroup
    {
        var spriteGroup:FlxSpriteGroup = new FlxSpriteGroup(x, y);
		for (i in 0...maxDig)
		{
			var dibb:Float = 1;
            for (j in 1...maxDig - i)
                dibb *= 10;

            var num:Int = Std.int(Math.floor(num / dibb) % 10);

            var numSpr:FlxSprite = new FlxSprite(0 + (i * 8 * spriteScale), 0);
            numSpr.loadGraphic(Paths.image(path + 'nums'));
            numSpr.loadGraphic(Paths.image(path + 'nums'), true, Math.floor(numSpr.width / 10), Math.floor(numSpr.height));

            for (k in 0...10)
                numSpr.animation.add(Std.string(k), [k], 0, false);

            numSpr.animation.play(Std.string(num));
            numSpr.setGraphicSize(Std.int(numSpr.width * spriteScale));
            numSpr.updateHitbox();
            numSpr.scrollFactor.set();
            spriteGroup.add(numSpr);
		}
        return spriteGroup;
    }

    override function update(elapsed:Float)
    {
        var up = controls.UI_UP_P && !acceptedYourFate;
        var down = controls.UI_DOWN_P && !acceptedYourFate;
        var back = controls.BACK && !acceptedYourFate;
        var accept = controls.ACCEPT && !acceptedYourFate;
        var ctrl = FlxG.keys.justPressed.CONTROL && !acceptedYourFate;

        if (up)
        {
            curSelect -= 1;
            if (curSelect < 0) curSelect = optionSprGroup.length - 1;
            FlxG.sound.play(Paths.sound('scrollMenu_nes'));
            mushcursor.y = optionSprGroup.members[curSelect].y;
        }
        if (down)
        {
            curSelect += 1;
            if (curSelect >= optionSprGroup.length) curSelect = 0;
            FlxG.sound.play(Paths.sound('scrollMenu_nes'));
            mushcursor.y = optionSprGroup.members[curSelect].y;
        }

		if (back)
		{
			persistentUpdate = false;
            FlxG.camera.visible = false;
			FlxG.sound.play(Paths.sound('Bump'));
			MusicBeatState.switchState(new MainMenuState());
		}

        if (accept)
        {
            switch (options[curSelect])
            {
                case 'Play Game':
                    PlayState.storyWeek = 0;
                    
                    // We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
                    var songArray:Array<String> = [];
                    var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[0]).songs;
                    for (i in 0...leWeek.length) {
                        songArray.push(leWeek[i][0]);
                    }

                    // Nevermind that's stupid lmao
                    PlayState.resetProperties();
                    PlayState.storyPlaylist = songArray;
                    PlayState.isStoryMode = true;

                    var diffic = CoolUtil.getDifficultyFilePath(1);
                    if(diffic == null) diffic = '';

                    PlayState.storyDifficulty = 1;
                    PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
                    AllStarsState.destroyFreeplayVocals();

                    FlxG.sound.playMusic(Paths.sound('mxModeStart'), 1, false);
                    var dumbtime = FlxG.sound.music.length / 1000;

                    var dark = FlxColor.fromString('0x1A1A1A');
                    FlxTween.color(title, dumbtime, FlxColor.WHITE, dark);

                    for (spr in optionSprGroup)
                    {
                        if (spr.ID == curSelect)
                        {
                            spr.color = FlxColor.YELLOW;
                            FlxFlicker.flicker(spr, dumbtime, 0.06, false, false, null);
                        }
                        else
                        {
                            FlxTween.color(spr, dumbtime, FlxColor.WHITE, dark);
                        }
                    }

                    FlxTween.color(boyfriendTxt, dumbtime, FlxColor.WHITE, dark);
                    for (spr in bfScoreGroup)
                        FlxTween.color(spr, dumbtime, FlxColor.WHITE, dark);
                    for (spr in highscoreGroup)
                        FlxTween.color(spr, dumbtime, FlxColor.WHITE, dark);
                    
                    FlxG.sound.music.onComplete = function()
                    {
                        FlxG.camera.visible = false;
                        new FlxTimer().start(1, function(timer:FlxTimer)
                        {
                            LoadingState.loadingImage = 'loadingscreen-1';
                            LoadingState.loadAndSwitchState(new PlayState());
                        });
                    };

                    new FlxTimer().start(2, function(timer:FlxTimer)
                    {
                        merio.loadGraphic(Paths.image(path + 'falsehero_stare', 'preload'));
                    });

                    acceptedYourFate = true;
                    FlxTransitionableState.skipNextTransIn = true;
                case 'Exit':
                    persistentUpdate = false;
                    FlxG.camera.visible = false;
                    FlxG.sound.play(Paths.sound('Bump'));
                    MusicBeatState.switchState(new MainMenuState());
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