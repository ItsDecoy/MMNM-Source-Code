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

class Runlucasrun extends MusicBeatState
{
	var mx:FlxSprite;
	var lucas:FlxSprite;

	var chunks:FlxSprite;

	var leftchunk:FlxSprite;
	var startchunk:FlxSprite;
	var rightchunk:FlxSprite;

	var pixelZoom = 4;

	override public function create()
	{
		startchunk = new FlxSprite().loadGraphic(Paths.image('extrasmenu/minigames/runlucasrun/unknown (4)', 'preload'));
		startchunk.antialiasing = false;
		startchunk.setGraphicSize(Std.int(startchunk.width * pixelZoom));
		startchunk.screenCenter();
		add(startchunk);
		


		/*startchunk = new FlxSprite();
		startchunk.frames = Paths.getSparrowAtlas('extrasmenu/minigames/runlucasrun/map', 'preload');
		startchunk.animation.addByPrefix('');*/

		// -- //
		FlxG.camera.zoom = 0.8;

		mx = new FlxSprite().loadGraphic(Paths.image('extrasmenu/minigames/runlucasrun/mx', 'preload'));
		mx.flipX = true;
		mx.width = mx.width / 12;
		mx.loadGraphic(Paths.image('extrasmenu/minigames/runlucasrun/mx', 'preload'), true, Math.floor(mx.width), Math.floor(mx.height));
		mx.antialiasing = false;
		mx.setGraphicSize(Std.int(mx.width * pixelZoom));

		mx.animation.add('idle', [3], 24, false);
		mx.animation.add('run', [5, 4, 3], 18, true);
		mx.animation.add('jump1', [6], 18, false);
		mx.animation.add('jump2', [8], 18, false);
		mx.animation.add('crouch', [7], 18, false);
		mx.animation.add('appear', [0, 1, 9, 10, 11], 10, false);

		// -- //

		lucas = new FlxSprite().loadGraphic(Paths.image('extrasmenu/minigames/runlucasrun/lucas', 'preload'));
		lucas.flipX = true;
		lucas.width = lucas.width / 6;
		lucas.loadGraphic(Paths.image('extrasmenu/minigames/runlucasrun/lucas', 'preload'), true, Math.floor(lucas.width), Math.floor(lucas.height));
		lucas.antialiasing = false;
		lucas.setGraphicSize(Std.int(lucas.width * pixelZoom));

		lucas.animation.add('idle', [0], 24, false);
		lucas.animation.add('run', [3, 2, 1], 18, true);
		lucas.animation.add('jump', [4], 18, false);
		lucas.animation.add('crouch', [5], 18, false);

		mx.animation.play('run');
		lucas.animation.play('run');

		mx.screenCenter();
		mx.x -= 150;
		lucas.screenCenter();
		lucas.x += 150;

		add(mx);
		add(lucas);


	}
}
