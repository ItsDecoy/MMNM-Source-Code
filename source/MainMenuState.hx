package;

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
		'story_mode',
		'extras',
		'options'
	];

	var artList:Array<String> = [
		'mx_mode',
		'all_stars',
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

	var ready:Bool = true;

	var xPos:Float = 0;

	override function create()
	{
		WeekData.loadTheFirstEnabledMod();

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

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenustuff/MMNM_MENU_BACKGROUND'));
		bg.scrollFactor.set(0, 0);
		bg.setGraphicSize(Std.int(bg.width * 1.025));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		pipes = new FlxTypedGroup<FlxSprite>();
		add(pipes);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 160 - (Math.max(optionShit.length, 4) - 4) * 80;
			var thingCursor2 = new FlxSprite(-100, (i * 125)  + offset).loadGraphic(Paths.image('mainmenustuff/MMNM_MENU_PIPE', 'preload'));
			thingCursor2.scrollFactor.set();
			
			pipes.add(thingCursor2);
			
			switch(i)
			{
				case 0:
					thingCursor2.y -= 10;
				case 1:
					thingCursor2.y -= 15;
				case 2:
					thingCursor2.y -= 10;
				case 3:
					thingCursor2.y -= 5;
			}
		}

		thingCursor = new FlxSprite().loadGraphic(Paths.image('mainmenustuff/MMNM_MENU_CURSOR', 'preload'));
		thingCursor.scrollFactor.set();
		add(thingCursor);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;

		for (i in 0...optionShit.length)
		{
			var offset:Float = 160 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(xPos, (i * 125)  + offset).loadGraphic(Paths.image('mainmenustuff/' + optionShit[i], 'preload'));
			if(i == 1)
			{
				menuItem.y -= 50;
			}
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.ID = i;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		/*var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);*/

		coverART2 = new FlxSprite(625, 100);
		coverART2.scrollFactor.set();
		ca_pos2 = new FlxPoint(coverART2.x, coverART2.y);
		add(coverART2);

		coverART = new FlxSprite(625, 100);
		coverART.scrollFactor.set();
		ca_pos = new FlxPoint(coverART.x, coverART.y);
		add(coverART);

		var logoTHING:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenustuff/MMNM_MENU_LOGO', 'preload'));
		logoTHING.scrollFactor.set();
		add(logoTHING);


		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
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

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
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
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new FreeplayState());
									case 'mx_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'extras':
										MusicBeatState.switchState(new ExtrasMenu());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
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
				coverART2.x = FlxMath.lerp(coverART2.x, ca_pos2.x, CoolUtil.boundTo(elapsed * 5, 0, 1));
				coverART2.y = FlxMath.lerp(coverART2.y, ca_pos2.y, CoolUtil.boundTo(elapsed * 5, 0, 1));

				coverART.loadGraphic(Paths.image('mainmenustuff/art/' + artList[spr.ID]));
				switch(spr.ID)
				{
					case 0:
						coverART.x = FlxMath.lerp(coverART.x, ca_pos.x + 6, CoolUtil.boundTo(elapsed * 5, 0, 1));
						coverART.y = FlxMath.lerp(coverART.y, ca_pos.y - 8, CoolUtil.boundTo(elapsed * 5, 0, 1));
					case 1:
						coverART.x = FlxMath.lerp(coverART.x, ca_pos.x, CoolUtil.boundTo(elapsed * 5, 0, 1));
						coverART.y = FlxMath.lerp(coverART.y, ca_pos.y, CoolUtil.boundTo(elapsed * 5, 0, 1));
					case 2:
						coverART.x = FlxMath.lerp(coverART.x, ca_pos.x + 6, CoolUtil.boundTo(elapsed * 5, 0, 1));
						coverART.y = FlxMath.lerp(coverART.y, ca_pos.y - 8, CoolUtil.boundTo(elapsed * 5, 0, 1));
					case 3:
						coverART.x = FlxMath.lerp(coverART.x, ca_pos.x, CoolUtil.boundTo(elapsed * 5, 0, 1));
						coverART.y = FlxMath.lerp(coverART.y, ca_pos.y, CoolUtil.boundTo(elapsed * 5, 0, 1));
				}


				spr.x = FlxMath.lerp(spr.x, xPos + 35, CoolUtil.boundTo(elapsed * 5, 0, 1));
				var addition = 0;
				switch(spr.ID)
				{
					case 0:
						addition = 20;
					case 1:
						addition = 70;
					case 2:
						addition = 25;
					case 3:
						addition = 30;

				}
				thingCursor.y = FlxMath.lerp(thingCursor.y, spr.y + addition, CoolUtil.boundTo(elapsed * 10, 0, 1));
				thingCursor.x = 410;
			}
			else
			{
				spr.x = FlxMath.lerp(spr.x, xPos, CoolUtil.boundTo(elapsed * 5, 0, 1));
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
					spr.centerOffsets();
				}
			});
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				ready = true;
			});
		}

	}
}
