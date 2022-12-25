package;

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

class ExtrasMenu extends MusicBeatState
{
    static var path:String = 'extrasmenu/';
    var bg:FlxBackdrop;

    static var curSelect:Int = 0;

    var options:Array<String> = ['credits'];
    var optionSprites:FlxSpriteGroup;

    //IM ADDING THIS IN DO NOT WORRY, Hi I'm paul :)
    override function create()
    {
        optionSprites = new FlxSpriteGroup();

        bg = new FlxBackdrop(Paths.image('allstars/loopingback','preload'), 1, 1, true, true);
        bg.scrollFactor.set();
        bg.antialiasing = false;
        add(bg);

        for (i in 0...options.length)
        {
            // ñ
            var offset = 170;
            var opt = new FlxSprite().loadGraphic(Paths.image(path + options[i] + '_idle', 'preload'));
            opt.setGraphicSize(Std.int(opt.width * 0.9));
            opt.antialiasing = ClientPrefs.globalAntialiasing;
            opt.screenCenter();
            opt.y += (offset * i) - ((offset / 2) * (options.length-1));
            opt.ID = i;
            optionSprites.add(opt);
        }

        add(optionSprites);
        changeSelection(0);

        super.create();
    }

    override function update(elapsed:Float)
    {
        if(bg != null)
            bg.velocity.set(25, 0);

        if (controls.UI_UP_P)
        {
            changeSelection(-1);
            FlxG.sound.play(Paths.sound('scrollMenu'), 0.8);
        }
        if (controls.UI_DOWN_P)
        {
            changeSelection(1);
            FlxG.sound.play(Paths.sound('scrollMenu'), 0.8);
        }

        if (controls.ACCEPT)
        {
            switch (options[curSelect])
            {
                case 'minigames':
                    trace('nothing lol');
                    FlxG.sound.play(Paths.sound('scrollMenu'), 0.8);
                    FlxTransitionableState.skipNextTransIn = true;
                    FlxTransitionableState.skipNextTransOut = true;
                    MusicBeatState.switchState(new Runlucasrun());
                case 'credits':
                    FlxG.sound.play(Paths.sound('scrollMenu'), 0.8);
                    FlxTransitionableState.skipNextTransIn = true;
                    FlxTransitionableState.skipNextTransOut = true;
                    MusicBeatState.switchState(new CreditsState());
            }
        }

		if (controls.BACK)
		{
			persistentUpdate = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

        super.update(elapsed);
    }

    private function changeSelection(int:Int)
    {
        curSelect += int;
        if (curSelect >= options.length) curSelect = 0;
        if (curSelect < 0) curSelect = options.length-1;

        optionSprites.forEachAlive(function(spr:FlxSprite)
        {
            if (spr.ID == curSelect) spr.loadGraphic(Paths.image(path + options[spr.ID] + '_select', 'preload'));
            else spr.loadGraphic(Paths.image(path + options[spr.ID] + '_idle', 'preload'));
        });
    }
}