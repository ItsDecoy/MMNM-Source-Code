package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import openfl.filters.ShaderFilter;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;

// Coded by Ighby
class ThanksState extends MusicBeatState
{
    var text1:FlxText;
    var text2:FlxText;
    var soLong:FlxSprite;

    var canPress = false;

    var timeElapsed:Float = 0;

    override function create()
    {
        persistentUpdate = true;

        FlxG.sound.playMusic(Paths.music('endMusic'));

        text1 = new FlxText(0, 10, FlxG.width, 'THANKS FOR PLAYING', 50);
        text1.setFormat(Paths.font('Pixel_NES.otf'), 50, FlxColor.WHITE, CENTER);
        add(text1);

        text2 = new FlxText(0, 70, FlxG.width,
        "THANKS FOR PLAYING MARIO'S MONDAY NIGHT\nMASSACRE V1. THE MMNM TEAM APPRECIATES IT! WE\nALSO THANK THE COMMUNITY THAT HAS BEEN WITH\nUS EVER SINCE THE BEGINNING. THE DEV TEAM\nCOULDN'T BE MORE GRATEFUL TO HAVE SUCH AN\nAMAZING FANBASE!\n\nMAKE SURE TO FOLLOW @MMNM_FNF ON TWITTER TO GET FUTURE UPDATES\nON THE MOD, AS MX WILL RETURN WITH NEW FRIENDS TO PLAY WITH."
        , 18);
        text2.setFormat(Paths.font('Pixel_NES.otf'), 18, FlxColor.fromString('0xDD9C83'), CENTER);
        add(text2);

        soLong = new FlxSprite(0, FlxG.height * 0.45).loadGraphic(Paths.image('soLongBoyfriend', 'preload'));
        soLong.setGraphicSize(Std.int(soLong.width * 0.7));
        soLong.updateHitbox();
        soLong.screenCenter(X);
        add(soLong);

        var black:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(black);

        var fadeTime = 2.5;
        var fadeTicks = 7;

        FlxG.sound.music.fadeIn(fadeTime, 0, 1);

        new FlxTimer().start(fadeTime / fadeTicks, function(tmr:FlxTimer)
        {
            black.alpha -= 1 / fadeTicks;
        }, fadeTicks);

        new FlxTimer().start(fadeTime, function(tmr:FlxTimer)
        {
            canPress = true;
        });

        FlxG.camera.setFilters([new ShaderFilter(new CRTShader(1))]);

        super.create();
    }

    override function update(elapsed:Float)
    {
        timeElapsed += elapsed;
        
        if (FlxG.keys.pressed.ANY && canPress)
        {
            canPress = false;
            FlxG.camera.visible = false;
            FlxG.sound.play(Paths.sound('Bump'));
            FlxG.sound.music.stop();
            new FlxTimer().start(1.5, function(tmr:FlxTimer)
            {
                FlxTransitionableState.skipNextTransIn = true;
                FlxG.sound.playMusic(Paths.music('freakyMenu'));
                MusicBeatState.switchState(new MainMenuState());
            });
        }

        soLong.angle = Std.int(Math.sin(timeElapsed * 0.95) * 3);
        super.update(elapsed);
    }
}