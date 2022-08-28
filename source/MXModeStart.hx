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

class MXModeStart extends MusicBeatState
{
    static var mxModeSongList = ['Familiar', "Hero's Doom"];

    var path = 'mxstart/';

    var options:Array<String> = ['Play Game', 'Exit'];
    var optionSprGroup:FlxSpriteGroup;
    var curSelect = 0;
    var title:FlxSprite;
    var mushcursor:FlxSprite;
    var merio:FlxSprite;
    var spriteScale = 3;

    var acceptedYourFate = false;

    override function create()
    {
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
        WeekData.reloadWeekFiles(false);

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

    override function update(elapsed:Float)
    {
        var up = controls.UI_UP_P && !acceptedYourFate;
        var down = controls.UI_DOWN_P && !acceptedYourFate;
        var back = controls.BACK && !acceptedYourFate;
        var accept = controls.ACCEPT && !acceptedYourFate;

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
                    PlayState.storyPlaylist = mxModeSongList;
                    PlayState.isStoryMode = true;
                    PlayState.chartingMode = false;

                    var diffic = CoolUtil.getDifficultyFilePath(1);
                    if(diffic == null) diffic = '';

                    PlayState.storyDifficulty = 1;

                    PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
                    PlayState.campaignScore = 0;
                    PlayState.campaignMisses = 0;

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
                    
                    FlxG.sound.music.onComplete = function()
                    {
                        FlxG.camera.visible = false;
                        new FlxTimer().start(1.5, function(timer:FlxTimer)
                        {
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

        super.update(elapsed);
    }
}