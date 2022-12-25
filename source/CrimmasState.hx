package;

import openfl.system.System;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;

using StringTools;


class CrimmasState extends MusicBeatState
{
    var image:FlxSprite;
    var selected = false;
    var curPos:FlxPoint;
    var text:FlxText;

    override function create()
    {
        if(FlxG.sound.music != null)
        {
            FlxG.sound.playMusic(Paths.music('chrimsas', 'shared'), 0);

            FlxG.sound.music.fadeIn(2, 0, 1);
        }

        selected = true;
        image = new FlxSprite().loadGraphic(Paths.image('happyholidays', 'shared'));
        image.screenCenter();
        curPos = image.getPosition();
        image.y += FlxG.height * 2;
        image.angle = 7;
        add(image);

        text = new FlxText(0,0,0, "MERRY CHRISTMAS!", 64);
        text.setFormat(Paths.font('Pixel_NES.otf'), 64, FlxColor.RED, CENTER);
        text.screenCenter();
        text.y += FlxG.height * 0.35;
        text.alpha = 0;
        add(text);
        FlxTween.tween(image, {x: curPos.x, y: curPos.y, angle: 0}, 3, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
            FlxTween.tween(text, {alpha: 1}, 1.5, {ease: FlxEase.quintOut, onComplete: function(twn2:FlxTween){
                selected = false;
            }});
        }});

        super.create();
    }

    override function update(elapsed:Float)
    {
        var accept = controls.ACCEPT;
        var back = controls.BACK;

        if(!selected && (accept || back))
        {
            selected = true;
            FlxG.sound.music.fadeOut(1, 0, function(twn:FlxTween)
            {
                FlxG.sound.music.stop();
            });

            FlxTween.tween(text, {alpha: 0}, 2, {ease: FlxEase.quintOut});
            FlxTween.tween(image, {y: curPos.y - FlxG.height * 2, angle: -7}, 3, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
                FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
				FlxG.sound.music.fadeIn(4, 0, 0.7);

                if(accept)
                    MusicBeatState.switchState(new AllStarsState());
                else if (back)
                    MusicBeatState.switchState(new MainMenuState());
            }});
        }

        super.update(elapsed);
    }
}