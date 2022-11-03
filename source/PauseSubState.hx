package;

import flixel.util.FlxTimer;
import flixel.group.FlxSpriteGroup;
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;

class PauseSubState extends MusicBeatSubstate
{
	public static var sprPath = 'pauseMenu/';
	static var maxItems:Int = 3;
	static var curPage:Int = 0;
	static var curSelected:Int = 0;

	var prefix = '';

	var grpMenuShit:FlxTypedGroup<PauseItem>;

	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = ['Continue', 'Try Again', 'Change Difficulty', 'Exit Course'];
	var difficultyChoices = [];

	var pauseMusic:FlxSound;

	// Elements
	var levelInfo:FlxText;
	var songAuthor:FlxText;
	var pauseSongCredit:FlxText;
	var blueballedTxt:FlxText;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var chartingText:FlxText;

	var curTime:Float = Math.max(0, Conductor.songPosition);
	var menu:FlxSpriteGroup;

	var bg:FlxSprite;

	var pageSprite:FlxSprite;
	var pageColorSprite:FlxSprite;

	var selectLeft:FlxSprite;
	var selectRight:FlxSprite;
	var arrowUp:FlxSprite;
	var arrowDown:FlxSprite;

	var selectTimer:Float = 0;
	var swagCounter:Int = 0;
	var closing:Bool = false;

	public static var songName:String = '';

	public function new(x:Float, y:Float)
	{
		super();
		if(CoolUtil.difficulties.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!
		if (PlayState.stageStyle != '') prefix = '_' + PlayState.stageStyle;

		menu = new FlxSpriteGroup();
		grpMenuShit = new FlxTypedGroup<PauseItem>();

		FlxG.sound.play(Paths.sound('pause' + prefix), 1);

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		pageSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(sprPath + 'page', 'preload'));
		pageSprite.scrollFactor.set();
		pageSprite.screenCenter();
		pageSprite.antialiasing = ClientPrefs.globalAntialiasing;
		menu.add(pageSprite);

		pageColorSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(sprPath + 'the_thingy', 'preload'));
		pageColorSprite.scrollFactor.set();
		pageColorSprite.screenCenter();
		pageColorSprite.antialiasing = ClientPrefs.globalAntialiasing;
		pageColorSprite.color = PlayState.getCharacterColor('dad');
		menu.add(pageColorSprite);

		levelInfo = new FlxText(pageSprite.x, pageSprite.y  + 20, 0, "", 55);
		levelInfo.text = PlayState.SONG.song.toUpperCase();
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("SuperMario.ttf"), 55);
		levelInfo.alignment = FlxTextAlign.CENTER;
		levelInfo.antialiasing = ClientPrefs.globalAntialiasing;
		levelInfo.updateHitbox();
		levelInfo.screenCenter(X);
		menu.add(levelInfo);

		songAuthor = new FlxText(levelInfo.x, levelInfo.y  + 40, 0, "", 24);
		songAuthor.text = 'By: ' + PlayState.songAuthor;
		songAuthor.scrollFactor.set();
		songAuthor.setFormat(Paths.font("Arial Rounded Bold.ttf"), 24);
		songAuthor.alignment = FlxTextAlign.CENTER;
		songAuthor.bold = true;
		songAuthor.antialiasing = ClientPrefs.globalAntialiasing;
		songAuthor.updateHitbox();
		songAuthor.screenCenter(X);
		menu.add(songAuthor);

		pauseSongCredit = new FlxText(pageSprite.x, pageSprite.y - 22, 0, "Pause Song By: willisaclown", 16);
		pauseSongCredit.scrollFactor.set();
		pauseSongCredit.setFormat(Paths.font("Arial Rounded Bold.ttf"), 16);
		pauseSongCredit.alignment = FlxTextAlign.CENTER;
		pauseSongCredit.bold = true;
		pauseSongCredit.antialiasing = ClientPrefs.globalAntialiasing;
		pauseSongCredit.updateHitbox();
		pauseSongCredit.screenCenter(X);
		menu.add(pauseSongCredit);

		blueballedTxt = new FlxText(0, pageSprite.y + pageSprite.height, 0, "", 62);
		blueballedTxt.text = "GAME OVERS: " + PlayState.deathCounter;
		blueballedTxt.scrollFactor.set();
		blueballedTxt.alignment = FlxTextAlign.CENTER;
		blueballedTxt.setFormat(Paths.font('SuperMario.ttf'), 62, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		blueballedTxt.antialiasing = ClientPrefs.globalAntialiasing;
		blueballedTxt.borderSize = 4;
		blueballedTxt.updateHitbox();
		blueballedTxt.screenCenter(X);
		menu.add(blueballedTxt);

		practiceText = new FlxText(20, 15 + 101, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('Arial Rounded Bold.ttf'), 32);
		practiceText.y = FlxG.height - (practiceText.height + 55);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.antialiasing = ClientPrefs.globalAntialiasing;
		practiceText.visible = PlayState.instance.practiceMode;
		add(practiceText);

		chartingText = new FlxText(20, 15 + 101, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('Arial Rounded Bold.ttf'), 32);
		chartingText.x = FlxG.width - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.antialiasing = ClientPrefs.globalAntialiasing;
		chartingText.visible = PlayState.chartingMode;
		add(chartingText);

		selectLeft = new FlxSprite(0, 0).loadGraphic(Paths.image(sprPath + 'select_left', 'preload'));
		selectLeft.scrollFactor.set();
		selectLeft.screenCenter();
		selectLeft.antialiasing = ClientPrefs.globalAntialiasing;
		menu.add(selectLeft);

		selectRight = new FlxSprite(0, 0).loadGraphic(Paths.image(sprPath + 'select_right', 'preload'));
		selectRight.scrollFactor.set();
		selectRight.screenCenter();
		selectRight.antialiasing = ClientPrefs.globalAntialiasing;
		menu.add(selectRight);

		arrowUp = new FlxSprite(0, pageSprite.y + 120).loadGraphic(Paths.image(sprPath + 'arrow', 'preload'));
		arrowUp.scrollFactor.set();
		arrowUp.screenCenter(X);
		arrowUp.antialiasing = ClientPrefs.globalAntialiasing;
		menu.add(arrowUp);

		arrowDown = new FlxSprite(0, pageSprite.y + pageSprite.height - 85).loadGraphic(Paths.image(sprPath + 'arrow', 'preload'));
		arrowDown.scrollFactor.set();
		arrowDown.screenCenter(X);
		arrowDown.flipY = true;
		arrowDown.antialiasing = ClientPrefs.globalAntialiasing;
		menu.add(arrowDown);

		if(PlayState.chartingMode)
		{
			menuItemsOG.insert(2, 'Leave Charting Mode');
			
			var num:Int = 0;
			if(!PlayState.instance.startingSong)
			{
				num = 1;
				menuItemsOG.insert(3, 'Skip Time');
			}
			menuItemsOG.insert(3 + num, 'End Song');
			menuItemsOG.insert(4 + num, 'Toggle Practice Mode');
			menuItemsOG.insert(5 + num, 'Toggle Botplay');
		}

		for (i in 0...CoolUtil.difficulties.length) {
			var diff:String = '' + CoolUtil.difficulties[i];
			difficultyChoices.push(diff);
		}
		difficultyChoices.push('BACK');

		pauseMusic = new FlxSound();
		if(songName != null) {
			pauseMusic.loadEmbedded(Paths.music(songName), true, true);
		} else if (songName != 'None') {
			pauseMusic.loadEmbedded(Paths.music(Paths.formatToSongPath('Funky Mario Three')), true, true);
		}

		changePage(0);
		changeSelection(0);

		pauseMusic.volume = 0;
		pauseMusic.play(false, 0);

		FlxG.sound.list.add(pauseMusic);

		pauseSongCredit.alpha = 0;
		blueballedTxt.alpha = 0;

		levelInfo.alpha = 0;
		songAuthor.alpha = 0;

		arrowUp.alpha = 0;
		arrowDown.alpha = 0;

		menu.y -= 800;

		FlxTween.tween(bg, {alpha: 0.75}, 0.8, {ease: FlxEase.quartInOut});
		FlxTween.tween(pauseMusic, {volume: 0.25}, 2, {ease: FlxEase.linear});
		FlxTween.tween(menu, {y: menu.y + 800}, 0.15, {ease: FlxEase.quartOut, onComplete:
		function (twn:FlxTween)
		{
			levelInfo.y += 20;
			songAuthor.y += 20;
			pauseSongCredit.y += 3;
			arrowUp.y -= 5;
			arrowDown.y += 5;
			blueballedTxt.y -= 10;

			FlxTween.tween(levelInfo, {alpha: 1, y: levelInfo.y - 20}, 0.3, {ease: FlxEase.quartInOut});
			FlxTween.tween(pauseSongCredit, {alpha: 0.6, y: pauseSongCredit.y - 3}, 0.3, {ease: FlxEase.quartInOut});
			FlxTween.tween(pauseSongCredit, {alpha: 0, y: pauseSongCredit.y + 3}, 0.3, {ease: FlxEase.quartInOut, startDelay: 2});
			FlxTween.tween(songAuthor, {alpha: 1, y: songAuthor.y - 20}, 0.3, {ease: FlxEase.quartInOut, startDelay: 0.1});
			FlxTween.tween(arrowUp, {alpha: 1, y: arrowUp.y + 5}, 0.3, {ease: FlxEase.quartInOut, startDelay: 0.15});
			FlxTween.tween(arrowDown, {alpha: 1, y: arrowDown.y - 5}, 0.3, {ease: FlxEase.quartInOut, startDelay: 0.15});
			FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 10}, 0.3, {ease: FlxEase.quartInOut, startDelay: 0.2});
		}
		});

		add(menu);

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		selectTimer += 1 * elapsed;

		super.update(elapsed);

		var upP = closing ? false : controls.UI_UP_P;
		var downP = closing ? false : controls.UI_DOWN_P;
		var accepted = closing ? false : controls.ACCEPT;

		if (upP) if (changeSelection(-1)) FlxG.sound.play(Paths.sound('scrollMenu' + prefix), 1);
		if (downP) if (changeSelection(1)) FlxG.sound.play(Paths.sound('scrollMenu' + prefix), 1);

		selectLeft.x = pageSprite.x + 70 - selectLeft.width + (Math.sin(selectTimer * 7) * 3);
		selectRight.x = pageSprite.x + pageSprite.width - 70 - (Math.sin(selectTimer * 7) * 3);

		var daSelected:String = menuItems[curSelected];
		switch (daSelected)
		{
			case 'Skip Time':
				if (controls.UI_LEFT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu' + prefix), 1);
					curTime -= 1000;
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu' + prefix), 1);
					curTime += 1000;
					holdTime = 0;
				}

				if(controls.UI_LEFT || controls.UI_RIGHT)
				{
					holdTime += elapsed;
					if(holdTime > 0.5)
					{
						curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);
					}

					if(curTime >= FlxG.sound.music.length) curTime -= FlxG.sound.music.length;
					else if(curTime < 0) curTime += FlxG.sound.music.length;
					updateSkipTimeText();
				}
		}

		if (skipTimeText != null) skipTimeText.visible = daSelected == 'Skip Time';

		if (accepted)
		{
			if (menuItems == difficultyChoices)
			{
				if(menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {
					var name:String = PlayState.SONG.song;
					var poop = Highscore.formatSong(name, curSelected);
					PlayState.SONG = Song.loadFromJson(poop, name);
					PlayState.storyDifficulty = curSelected;
					MusicBeatState.resetState();
					FlxG.sound.music.volume = 0;
					PlayState.changedDifficulty = true;
					PlayState.chartingMode = false;
					return;
				}

				menuItems = menuItemsOG;
				regenMenu();
			}

			switch (daSelected)
			{
				case "Continue":
					FlxG.sound.play(Paths.sound('pause' + prefix), 1);

					FlxTween.cancelTweensOf(menu);
					FlxTween.cancelTweensOf(levelInfo);
					FlxTween.cancelTweensOf(pauseSongCredit);
					FlxTween.cancelTweensOf(songAuthor);
					FlxTween.cancelTweensOf(arrowDown);
					FlxTween.cancelTweensOf(arrowUp);
					FlxTween.cancelTweensOf(blueballedTxt);
					FlxTween.cancelTweensOf(pauseMusic);

					FlxTween.tween(menu, {y: menu.y - 800}, 0.15, {ease: FlxEase.quartIn});
					FlxTween.tween(pauseMusic, {volume: 0}, 0.5, {ease: FlxEase.linear});
					if (PlayState.instance.startingSong || !ClientPrefs.pauseCountdown)
					{
						FlxTween.tween(bg, {alpha: 0}, 0.2, {ease: FlxEase.quartInOut});
						new FlxTimer().start(0.3, function(tmr:FlxTimer) { close(); });
					}
					else startCountdown();
					closing = true;
				case 'Change Difficulty':
					menuItems = difficultyChoices;
					regenMenu();
				case 'Toggle Practice Mode':
					PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
					PlayState.changedDifficulty = true;
					practiceText.visible = PlayState.instance.practiceMode;
				case "Try Again":
					restartSong();
					curPage = 0;
					curSelected = 0;
				case "Leave Charting Mode":
					restartSong();
					PlayState.chartingMode = false;
				case 'Skip Time':
					if(curTime < Conductor.songPosition)
					{
						PlayState.startOnTime = curTime;
						restartSong(true);
					}
					else
					{
						if (curTime != Conductor.songPosition)
						{
							PlayState.instance.clearNotesBefore(curTime);
							PlayState.instance.setSongTime(curTime);
						}
						close();
					}
				case "End Song":
					close();
					PlayState.instance.finishSong(true);
				case 'Toggle Botplay':
					PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
					PlayState.changedDifficulty = true;
					PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
					PlayState.instance.botplayTxt.alpha = 1;
					PlayState.instance.botplaySine = 0;
				case "Exit Course":
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;
					if(PlayState.isStoryMode) {
						MusicBeatState.switchState(new MainMenuState());
					} else {
						MusicBeatState.switchState(new AllStarsState());
					}
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					PlayState.resetProperties();
					curPage = 0;
					curSelected = 0;
			}
		}
	}

	public function startCountdown()
	{
		FlxTween.tween(bg, {alpha: 0}, Conductor.crochet / 200, {ease: FlxEase.sineOut});
		new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', 'set', 'go']);
			introAssets.set('pixel', ['pixelUI/ready-pixel', 'pixelUI/set-pixel', 'pixelUI/date-pixel']);
			var introSoundsSuffix:String = '';

			var introAlts:Array<String> = introAssets.get('default');
			var antialias:Bool = ClientPrefs.globalAntialiasing;

			if(PlayState.isPixelStage) {
				introSoundsSuffix = '-pixel';
				introAlts = introAssets.get('pixel');
				antialias = false;
			}

			switch (swagCounter)
			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3' + introSoundsSuffix), 0.6);
				case 1:
					var countdownReady = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					countdownReady.scrollFactor.set();
					countdownReady.updateHitbox();

					if (PlayState.isPixelStage)
						countdownReady.setGraphicSize(Std.int(countdownReady.width * PlayState.daPixelZoom));

					countdownReady.screenCenter();
					countdownReady.antialiasing = antialias;
					add(countdownReady);

					FlxTween.tween(countdownReady, {alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							remove(countdownReady);
							countdownReady.destroy();
						}
					});

					FlxG.sound.play(Paths.sound('intro2' + introSoundsSuffix), 0.6);
				case 2:
					var countdownSet = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					countdownSet.scrollFactor.set();

					if (PlayState.isPixelStage)
						countdownSet.setGraphicSize(Std.int(countdownSet.width * PlayState.daPixelZoom));

					countdownSet.screenCenter();
					countdownSet.antialiasing = antialias;
					add(countdownSet);

					FlxTween.tween(countdownSet, {alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							remove(countdownSet);
							countdownSet.destroy();
						}
					});

					FlxG.sound.play(Paths.sound('intro1' + introSoundsSuffix), 0.6);
				case 3:
					var countdownGo = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					countdownGo.scrollFactor.set();

					if (PlayState.isPixelStage)
						countdownGo.setGraphicSize(Std.int(countdownGo.width * PlayState.daPixelZoom));

					countdownGo.updateHitbox();
					countdownGo.screenCenter();
					countdownGo.antialiasing = antialias;
					add(countdownGo);

					FlxTween.tween(countdownGo, {alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							remove(countdownGo);
							countdownGo.destroy();
						}
					});

					FlxG.sound.play(Paths.sound('introGo' + introSoundsSuffix), 0.6);
				case 4:
					close();
			}
			swagCounter += 1;
		}, 5);
	}

	public static function restartSong(noTrans:Bool = false)
	{
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		}
		else
		{
			MusicBeatState.resetState();
		}
	}

	override function destroy()
	{
		FlxTween.cancelTweensOf(pauseMusic);
		pauseMusic.destroy();

		super.destroy();
	}

	function loadItems():Void
	{
		menuItems = [];

		for (j in 0...maxItems)
		{
			var itemId:Int = j + (curPage * maxItems);

			if (itemId < menuItemsOG.length)
			{
				menuItems.push(menuItemsOG[itemId]);
			}
		}
	}

	function changePage(change:Int = 0):Void
	{
		curPage += change;
		loadItems();
		regenMenu();

		arrowUp.visible = curPage > 0;
		arrowDown.visible = (curPage * maxItems) + maxItems < menuItemsOG.length;
	}

	function changeSelection(change:Int = 0):Bool
	{
		curSelected += change;

		if (((curSelected + (curPage * maxItems)) >= menuItemsOG.length) || ((curSelected + (curPage * maxItems)) < 0))
		{
			curSelected -= change;
			return false;
		}
		
		if (curSelected < 0)
		{
			changePage(-1);
			curSelected = maxItems - 1;
		}
		if (curSelected >= menuItems.length)
		{
			changePage(1);
			curSelected = 0;
		}

		for (item in grpMenuShit.members)
		{
			item.selected = item.ID == curSelected;
			if (item.selected)
			{
				selectLeft.y = item.y + 5;
				selectRight.y = item.y + 5;
				selectTimer = 0;
			}

		}
		return true;
	}

	function regenMenu():Void {
		for (i in 0...grpMenuShit.members.length) {
			var obj = grpMenuShit.members[0];
			obj.kill();
			grpMenuShit.remove(obj, true);
			obj.destroy();
		}

		for (i in 0...menuItems.length)
		{
			var item = new PauseItem(menuItems[i]);
			item.y = pageSprite.y + 170 + (100 * i);
			item.ID = i;
			item.screenCenter(X);
			menu.add(item);
			grpMenuShit.add(item);

			if(menuItems[i] == 'Skip Time' && skipTimeText == null)
			{
				skipTimeText = new FlxText(0, 0, 0, '', 70);
				skipTimeText.setFormat(Paths.font("SuperMario.ttf"), 70, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				skipTimeText.scrollFactor.set();
				skipTimeText.antialiasing = ClientPrefs.globalAntialiasing;
				skipTimeText.borderSize = 3;
				skipTimeText.screenCenter();
				skipTimeText.x += 10 + pageSprite.width / 2;
				add(skipTimeText);
				updateSkipTimeText();
			}
		}
	}

	function updateSkipTimeText()
	{
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}

class PauseItem extends FlxSpriteGroup
{
	public var selected(default, set):Bool = false;

	var itemSprite:FlxSprite;
	var text:FlxText;

	public function new(textIn:String)
	{
		super();

		itemSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(PauseSubState.sprPath + 'button', 'preload'));
		itemSprite.scrollFactor.set();
		itemSprite.antialiasing = ClientPrefs.globalAntialiasing;
		add(itemSprite);

		text = new FlxText(0, 22, itemSprite.width, textIn, 30);
		text.scrollFactor.set();
		text.setFormat(Paths.font('Arial Rounded Bold.ttf'), 30);
		text.alignment = FlxTextAlign.CENTER;
		text.bold = true;
		text.color = FlxColor.BLACK;
		text.updateHitbox();
		text.antialiasing = ClientPrefs.globalAntialiasing;
		add(text);

		selected = false;
	}

	function set_selected(value:Bool):Bool
	{
		if (value)
		{
			text.alpha = 1;
			text.color = FlxColor.WHITE;
			itemSprite.color = PlayState.getCharacterColor('dad');
		}
		else
		{
			text.alpha = 0.8;
			text.color = FlxColor.BLACK;
			itemSprite.color = FlxColor.WHITE;
		}
		return selected = value;
	}
}