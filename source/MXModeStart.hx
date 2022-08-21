package;

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

class MXModeStart extends MusicBeatState
{
    static var mxModeSongList = ['Familiar', "Hero's Doom"];

    var path = 'mxstart/';

    var title:FlxSprite;
    var merio:FlxSprite;
    var playGame:FlxSprite;
    var spriteScale = 3;

    var tooLateForYou = false;

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

        playGame = new FlxSprite(title.x, title.y).loadGraphic(Paths.image(path + 'play_game', 'preload'));
        playGame.setGraphicSize(Std.int(playGame.width * spriteScale));
        playGame.updateHitbox();
        playGame.scrollFactor.set();
        playGame.x += 89 * spriteScale;
        playGame.y += 144 * spriteScale;
        add(playGame);

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
        var back = controls.BACK && !tooLateForYou;
        var accept = controls.ACCEPT && !tooLateForYou;

		if (back)
		{
			persistentUpdate = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

        if (accept)
        {
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

            playGame.color = FlxColor.YELLOW;

            FlxG.sound.playMusic(Paths.sound('mxModeStart'), 1, false);
            var dumbtime = FlxG.sound.music.length / 1000;

            FlxTween.tween(title, {alpha: 0.1}, dumbtime);
            FlxFlicker.flicker(playGame, dumbtime, 0.06, false, false, null);

            FlxG.sound.music.onComplete = function()
            {
                title.visible = false;
                merio.visible = false;
                new FlxTimer().start(1.5, function(timer:FlxTimer)
                {
                    LoadingState.loadAndSwitchState(new PlayState());
                });
            };

            new FlxTimer().start(2, function(timer:FlxTimer)
            {
                merio.loadGraphic(Paths.image(path + 'falsehero_stare', 'preload'));
            });

            tooLateForYou = true;
            FlxTransitionableState.skipNextTransIn = true;
        }

        super.update(elapsed);
    }
}