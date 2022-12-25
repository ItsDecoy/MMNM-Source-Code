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

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'mx_mode',
		'extras',
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	var thingCursor:FlxSprite;
	var pipes:FlxTypedGroup<FlxSprite>;
	var coverART:FlxSprite;
	var coverART2:FlxSprite;
	var ca_pos:FlxPoint;
	var ca_pos2:FlxPoint;

	var bg:FlxSprite;
	var blackSide:FlxSprite;
	var logoTHING:FlxSprite;

	var ready:Bool = true;

	var xPos:Float = 0;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		WeekData.loadTheFirstEnabledMod();
        WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(0, -120).loadGraphic(Paths.image('mainmenustuff/background'));
		bg.scrollFactor.set(0, 0.3);
		bg.setGraphicSize(Std.int(bg.width * 1.2));
		bg.updateHitbox();
		bg.screenCenter(X);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		coverART2 = new FlxSprite(645, 130);
		coverART2.scrollFactor.set();
		coverART2.antialiasing = ClientPrefs.globalAntialiasing;
		ca_pos2 = new FlxPoint(coverART2.x, coverART2.y);
		add(coverART2);

		coverART = new FlxSprite(645, 130);
		coverART.scrollFactor.set();
		coverART.antialiasing = ClientPrefs.globalAntialiasing;
		ca_pos = new FlxPoint(coverART.x, coverART.y);
		add(coverART);

		blackSide = new FlxSprite().loadGraphic(Paths.image('mainmenustuff/sideThing'));
		blackSide.scrollFactor.set(0, 0);
		blackSide.setGraphicSize(Std.int(blackSide.width * 1.025));
		blackSide.updateHitbox();
		blackSide.screenCenter();
		blackSide.x -= 800;
		blackSide.antialiasing = ClientPrefs.globalAntialiasing;
		add(blackSide);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		pipes = new FlxTypedGroup<FlxSprite>();
		add(pipes);

		/*if (Highscore.weekCompleted.exists(WeekData.weeksList[0]) || Highscore.weekCompleted.get(WeekData.weeksList[0]))
		{
			optionShit.insert(1, 'all_stars');
		}*/

		optionShit.insert(1, 'all_stars');

		for (i in 0...optionShit.length)
		{
			var offset = 130;
			var pipe = new FlxSprite(-100, 360 - (offset / 2) * (optionShit.length-1)).loadGraphic(Paths.image('mainmenustuff/MMNM_MENU_PIPE', 'preload'));
			pipe.y += offset * i;
			pipe.scrollFactor.set();
			pipes.add(pipe);
		}

		thingCursor = new FlxSprite(410, 0).loadGraphic(Paths.image('mainmenustuff/MMNM_MENU_CURSOR', 'preload'));
		thingCursor.scrollFactor.set();
		thingCursor.antialiasing = ClientPrefs.globalAntialiasing;
		add(thingCursor);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(xPos, pipes.members[i].y + pipes.members[i].height / 2).loadGraphic(Paths.image('mainmenustuff/' + optionShit[i], 'preload'));
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.updateHitbox();
			menuItem.y -= menuItem.height / 2;
			menuItem.scrollFactor.set(0, 0);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.ID = i;
			menuItems.add(menuItem);
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		/*var versionShit:FlxText = new FlxText(12, FlxG.height - 48, 0, "(NOTE: THIS FEATURE SHOULD BE REMOVED BEFORE THE FINAL RELEASE)\nPress 7 to unlock all stars automatically / Press 0 to close and erase data.\n", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);*/

		logoTHING = new FlxSprite(10, 0).loadGraphic(Paths.image('mainmenustuff/MMNM_MENU_LOGO', 'preload'));
		logoTHING.scrollFactor.set();
		logoTHING.antialiasing = ClientPrefs.globalAntialiasing;
		add(logoTHING);

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 1 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var curBeater:Int = 0;

	override public function beatHit()
	{
		super.beatHit();

		curBeater++;

		trace('this works!');

	}

	var selectedSomethin:Bool = false;
	var cheatTimer:FlxTimer = new FlxTimer();

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (FlxG.keys.justPressed.B)
		{
			cheatTimer.start(4, function(tmr:FlxTimer)
			{
				if (FlxG.keys.pressed.SHIFT)
				{
					FlxG.save.erase();
					System.exit(0);
				}
				else
				{
					if (!Highscore.weekCompleted.exists('week1'))
					{
						Highscore.weekCompleted.set('week1', true);
						FlxG.sound.play(Paths.sound('confirmMenu'), 0.8);
						MusicBeatState.switchState(new MainMenuState());
					}
				}
			});
		}
		else if (FlxG.keys.justReleased.B && cheatTimer != null)
		{
			cheatTimer.cancel();
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('MenuPipe'), 0.8);

					menuItems.forEach(function(spr:FlxSprite)
					{
						var lePipe:FlxSprite = pipes.members[spr.ID];
						var leStartDelay = 0.05 * spr.ID;
						if (curSelected == spr.ID)
						{
							FlxFlicker.flicker(thingCursor, 0.5, 0.06, false, false);
							FlxFlicker.flicker(spr, 1.1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];
								FlxTransitionableState.skipNextTransIn = true;

								switch (daChoice)
								{
									case 'mx_mode':
										MusicBeatState.switchState(new MXModeStart());
									case 'all_stars':
										MusicBeatState.switchState(new AllStarsState());
									case 'extras':
										MusicBeatState.switchState(new ExtrasMenu());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
							leStartDelay = 0.5;
						}

						// HOLY SHIT THIS ARE SO MANY TWEENS!!1114SDFSDAF
						FlxTween.tween(lePipe, {x: lePipe.x - 800}, 0.4, {ease: FlxEase.backIn, startDelay: leStartDelay});
						FlxTween.tween(spr, {x: spr.x - 800}, 0.4, {ease: FlxEase.backIn, startDelay: leStartDelay});
						FlxTween.tween(blackSide, {x: 0}, 0.5, {ease: FlxEase.expoIn, startDelay: 0.5});
						FlxTween.tween(logoTHING, {y: logoTHING.y - 300}, 0.5, {ease: FlxEase.expoIn, startDelay: 0.5});
						FlxTween.tween(bg.scale, {x: 1.3, y: 1.3}, 1, {ease: FlxEase.expoIn});
						FlxTween.tween(coverART.scale, {x: 2.5, y: 2.5}, 1, {ease: FlxEase.expoIn});
						FlxTween.tween(coverART, {angle: 4}, 1, {ease: FlxEase.expoIn});
						FlxTween.color(coverART, 1, FlxColor.WHITE, FlxColor.BLACK, {ease: FlxEase.expoIn});
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		menuItems.forEach(function(spr:FlxSprite){
			if(spr.ID == curSelected)
			{
				coverART2.y = FlxMath.lerp(coverART2.y, ca_pos2.y, CoolUtil.boundTo(elapsed * 8, 0, 1));

				coverART.loadGraphic(Paths.image('mainmenustuff/art/' + optionShit[spr.ID]));
				switch(spr.ID)
				{
					case 0:
						coverART.y = FlxMath.lerp(coverART.y, ca_pos.y - 8, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 1:
						coverART.y = FlxMath.lerp(coverART.y, ca_pos.y, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 2:
						coverART.y = FlxMath.lerp(coverART.y, ca_pos.y - 8, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 3:
						coverART.y = FlxMath.lerp(coverART.y, ca_pos.y, CoolUtil.boundTo(elapsed * 8, 0, 1));
				}
			}
		});
		
		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		if(ready)
		{
			ready = false;
			FlxG.sound.play(Paths.sound('scrollMenu'));
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;

			var pipe:FlxSprite = pipes.members[curSelected];
			FlxTween.tween(thingCursor, {y: pipe.y + (pipe.height / 2) - thingCursor.height / 2}, 0.2, {ease: FlxEase.sineOut});

			menuItems.forEach(function(spr:FlxSprite)
			{
				spr.updateHitbox();
				if (spr.ID == curSelected)
				{
					if(huh < 0)
					{
						coverART2.setPosition(coverART.x, coverART.y);
						ca_pos2.set(ca_pos.x, ca_pos.y + 750);
						coverART.y = ca_pos.y - 750;
						coverART2.loadGraphicFromSprite(coverART);
						
					}
					else
					{
						coverART2.setPosition(coverART.x, coverART.y);
						ca_pos2.set(ca_pos.x, ca_pos.y - 750);
						coverART.y = ca_pos.y + 750;
						coverART2.loadGraphicFromSprite(coverART);
					}
					FlxTween.tween(spr, {x: xPos + 32}, 0.2, {ease: FlxEase.sineOut});
					spr.centerOffsets();
					camFollow.y = spr.ID * 100;
				}
				else
				{
					FlxTween.tween(spr, {x: xPos}, 0.2, {ease: FlxEase.sineOut});
				}
			});
			new FlxTimer().start(0.15, function(tmr:FlxTimer)
			{
				ready = true;
			});
		}
	}
}
