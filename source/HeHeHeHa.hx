package;

#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileCircle;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileSquare;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import options.GraphicsSettingsSubState;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

using StringTools;
typedef HeadData = //this took me like 20 m dont hurt me -nom
{
	headsShizz:Array<Array<Array<Float>>>;
}
class HeHeHeHa extends MusicBeatState
{
    var headGuys:HeadData; 
    var odds:Float=0.2500;
    var pathsArray:Array<Array<String>>;
    var theChosenOne:String;
    var coolHeads:FlxTypedGroup;
    var normieHeads:FlxTypedGroup;
    override function create()
        {
            super.create();
            headGuys.headsShizz = [
                ["MX", "heads/mx", "shared", 3],
                ["PEACH", "heads/peach", "shared", 3],
                ["WARIO", "heads/wario", "shared", 3],
                ["LUIGI", "heads/luigi", "shared", 3]
            ];

            theChosenOne = headGuys.headsShizz[FlxG.random.int(0,3)];
            //AAAAAHHHHH ANIMATION VS FNF REFERENCE??!??!?! 😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏😏

            if(theChosenOne == "MX")
                pathsArray == [
                    ["1","1","heads/peach"],
                    ["1","1","heads/wario"],
                    ["1","1","heads/luigi"]
                ];
            else if(theChosenOne == "PEACH")
                pathsArray == [
                    ["1","1","heads/MX"],
                    ["1","1","heads/wario"],
                    ["1","1","heads/luigi"]
                ];
            else if(theChosenOne == "WARIO")
                pathsArray == [
                    ["1","1","heads/MX"],
                    ["1","1","heads/peach"],
                    ["1","1","heads/luigi"]
                ];
            else if(theChosenOne == "LUIGI")
                pathsArray == [
                    ["1","1","heads/MX"],
                    ["1","1","heads/peach"],
                    ["1","1","heads/wario"]
                ];

            coolHeads = new FlxTypedGroup<FlxSprite>;
            add(coolHeads);

            normieHeads = new FlxTypedGroup<FlxSprite>;
            add(normieHeads)
            
            new FlxTimer().start(0.0001,function(tmr:FlxTimer){
                spawnHeads();
            },FlxG.random.int(10,15));

            spawnMainHead();

            super.create();
        }
    override function update(elapsed)
        {
            super.update(elapsed);

            coolHeads.forEach(function(spr:FlxSprite)
                {
                    if(FlxG.mouse.overlap(spr)){
                        //Sys.exit(0) //HAHAHAHSHDAHDAHDAHD NOOB GET OWNED F IN THE CHAT 2 SECONDS CHAT STICKY BM FNF REFERENCE
                        MusicBeatState.switchState(new MainMenuState());
                    }
                });

            super.update(elapsed);
        }
    function spawnHeads(){
        var oddsShit:Int;
        oddsShit = FlxG.random.int(0,3);
        var head:FlxSprite = new FlxSpr ite();
        //head.loadGraphic(headsShizz[oddsShit][0], headsShizz[oddsShit][1]); 
        //BRO I FORGOT THE PATHS.IMAGE IM SO DUM (O_O)
        head.loadGraphic(Paths.image(pathsArray[oddsShit][2]), "shared");
        head.scale.x = pathsArray[oddsShit][0];
        head.scale.y = pathsArray[oddsShit][0]; //never needed to use this smhhh
        head.x = FlxG.random.float(400, 1000);
        head.y = FlxG.random.float(400,800);
        normieHeads.add(head);
    }
    function spawnMainHead()
        {
            var head:FlxSprite = new FlxSprite();
            //head.loadGraphic(headsShizz[oddsShit][0], headsShizz[oddsShit][1]);
            head.loadGraphic(Paths.image('head/' + theChosenOne, "shared"));
            head.x = FlxG.random.float(400, 1000);
            head.y = FlxG.random.float(400,800);
            coolHeads.add(head);
        }
}