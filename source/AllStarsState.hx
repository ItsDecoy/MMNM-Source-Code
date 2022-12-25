package;

import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxEase;
#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import flixel.addons.display.FlxBackdrop;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class AllStarsState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];
	var path = 'allstars/';

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = 1;
	private static var lastDifficultyName:String = '';

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxBackdrop;
	var intendedColor:Int;
	var colorTween:FlxTween;

	
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var arts:FlxTypedGroup<FlxSprite>;
	var artsSelect:FlxTypedGroup<FlxSprite>;
	var locks:FlxTypedGroup<FlxSprite>;
	var nameArt:FlxSprite;

	var gradeSprites:FlxSpriteGroup;

	var timeElapsed:Float = 0;

	var grandDadWeek:String;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...WeekData.weeksList.length) {
			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			var weekIsLocked = weekIsLocked(WeekData.weeksList[i]);

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			var christmas:Bool = true;

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				var formatName:String = Highscore.formatSong(song[0], 1);
				if(christmas)
				{
					addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]), false);
				}
				else
				{
					if (formatName == "a-grand-ol'-time")
					{
						grandDadWeek = WeekData.weeksList[i];
						if (ClientPrefs.unlockedGrandDad)
						{
							addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]), false);
						}
					}
					else
					{
						addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]), weekIsLocked);
					}
				}
			}
		}
		WeekData.loadTheFirstEnabledMod();

		bg = new FlxBackdrop(Paths.image(path + 'loopingback', 'preload'), 1, 1, true, true);
		bg.scrollFactor.set();
		bg.antialiasing = false;
		add(bg);
		
		arts = new FlxTypedGroup<FlxSprite>();
		add(arts);

		artsSelect = new FlxTypedGroup<FlxSprite>();
		add(artsSelect);

		locks = new FlxTypedGroup<FlxSprite>();
		add(locks);
		
		for(i in 0...songs.length)
		{
			trace(path + 'art/' + songs[i].songName.toLowerCase() + '_idle');

			var songArtThing:String = songs[i].songName.toLowerCase();

			if(songs[i].songName.toLowerCase() == 'merry massacre' && (FlxG.save.data.merryMX != null && FlxG.save.data.merryMX == true))
			{
				songArtThing = 'merryCompleted';
			}

			var artCover = new FlxSprite().loadGraphic(Paths.image(path + 'art/' + songArtThing + '_idle', 'preload'));
			artCover.scrollFactor.set();
			artCover.screenCenter();
			artCover.ID = i;
			artCover.x += (i + curSelected) * 575;
			artCover.antialiasing = ClientPrefs.globalAntialiasing;
			arts.add(artCover);
			
			var artCoverSelect = new FlxSprite(artCover.x, artCover.y).loadGraphic(Paths.image(path + 'art/' + songArtThing + '_select', 'preload'));
			artCoverSelect.scrollFactor.set();
			artCoverSelect.ID = i;
			artCoverSelect.antialiasing = false;
			artsSelect.add(artCoverSelect);

			var lock = new FlxSprite(artCover.x, artCover.y).loadGraphic(Paths.image(path + 'art/lock', 'preload'));
			lock.scrollFactor.set();
			lock.ID = i;
			lock.antialiasing = ClientPrefs.globalAntialiasing;
			locks.add(lock);
			lock.visible = songs[i].locked;

			if (songs[i].locked)
			{
				artCover.color = FlxColor.BLACK;
				artCoverSelect.color = FlxColor.BLACK;
			}
		}

		var select = new FlxSprite().loadGraphic(Paths.image(path + 'select', 'preload'));
		select.screenCenter();
		select.scrollFactor.set();
		add(select);

		nameArt = new FlxSprite().loadGraphic(Paths.image(path + 'names/familiar_name'));
		nameArt.scrollFactor.set();
		nameArt.setGraphicSize(Std.int(nameArt.width * 0.6));
		nameArt.updateHitbox();
		nameArt.screenCenter();
		nameArt.y += FlxG.height * 0.4;
		add(nameArt);

		gradeSprites = new FlxSpriteGroup();
		add(gradeSprites);

		for (i in 0...songs.length)
		{
			var grade:String = Highscore.getGrade(songs[i].songName, 1).toLowerCase();

			var spr:FlxSprite = new FlxSprite((FlxG.width * 0.80) + 100 * (i - curSelected), 10);

			if (grade != '---') spr.loadGraphic(Paths.image(path + 'rating/' + grade));
			else
			{
				spr.loadGraphic(Paths.image(path + 'rating/clear'));
				spr.visible = false;
			}

			spr.scrollFactor.set();
			spr.setGraphicSize(Std.int(spr.width * 0.6));
			spr.updateHitbox();
			spr.antialiasing = ClientPrefs.globalAntialiasing;
			spr.ID = i;
			gradeSprites.add(spr);
		}


		leftArrow = new FlxSprite(nameArt.x, nameArt.y + 10).loadGraphic(Paths.image(path + 'allstarsleftarrowbig', 'preload'));
		add(leftArrow);
		
		rightArrow = new FlxSprite(nameArt.x + nameArt.frameWidth, leftArrow.y).loadGraphic(Paths.image(path + 'allstarsrightarrowbig', 'preload'));
		add(rightArrow);

		WeekData.setDirectoryFromWeek();

		if(curSelected >= songs.length) curSelected = 0;

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		changeSelection(0, false);
		changeDiff();
		super.create();
	}

	override function closeSubState()
	{
		changeSelection(0, false);

		// REFRESHES THE RATING ICON
		var grade:String = Highscore.getGrade(songs[curSelected].songName, 1).toLowerCase();

		if (grade != '---') gradeSprites.members[curSelected].loadGraphic(Paths.image(path + 'rating/' + grade));
		else
		{
			gradeSprites.members[curSelected].loadGraphic(Paths.image(path + 'rating/clear'));
			gradeSprites.members[curSelected].visible = false;
		}
		
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int, locked:Bool)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color, locked));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!Highscore.weekCompleted.exists(leWeek.weekBefore) || !Highscore.weekCompleted.get(leWeek.weekBefore)));
	}

	var instPlaying:Int = -1;
	private static var vocals:FlxSound = null;
	var holdTime:Float = 0;


	override function update(elapsed:Float)
	{
		timeElapsed += 1 * elapsed;

		if(bg != null)
			bg.velocity.set(25, 0);

		var speed = 12;
		arts.forEach(function(spr:FlxSprite)
		{
			var x:Float = ((FlxG.width / 2) - spr.frameWidth / 2) + (575 * (spr.ID - curSelected));
			
			if(spr.ID == curSelected)
			{
				spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * speed, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * speed, 0, 1));
				spr.y = Math.sin(timeElapsed * 3) * 8;
			}
			else
			{
				spr.scale.x = FlxMath.lerp(spr.scale.x, 0.75, CoolUtil.boundTo(elapsed * speed, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 0.75, CoolUtil.boundTo(elapsed * speed, 0, 1));
				spr.y = 0;
			}

			spr.x = FlxMath.lerp(spr.x, x, CoolUtil.boundTo(elapsed * speed, 0, 1));

			var gradeTargetX = FlxG.width * 0.80;
			var gradeX = gradeTargetX + 100 * (spr.ID - curSelected);
			gradeSprites.members[spr.ID].x = FlxMath.lerp(gradeSprites.members[spr.ID].x, gradeX, CoolUtil.boundTo(elapsed * speed * 2, 0, 1));
			
			var gradeTargetAlpha = gradeSprites.members[spr.ID].x - gradeTargetX;
			gradeTargetAlpha = Math.max(gradeTargetAlpha, -gradeTargetAlpha);
			gradeSprites.members[spr.ID].alpha = Math.max(0, 1 - gradeTargetAlpha * 0.01);

			artsSelect.members[spr.ID].x = spr.x;
			artsSelect.members[spr.ID].y = spr.y;
			artsSelect.members[spr.ID].scale.set(spr.scale.x, spr.scale.y);

			locks.members[spr.ID].x = spr.x;
			locks.members[spr.ID].y = spr.y;
			locks.members[spr.ID].scale.set(spr.scale.x, spr.scale.y);
		});

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		var leftP = controls.UI_LEFT_P;
		var rightP = controls.UI_RIGHT_P;
		var leftR = controls.UI_LEFT_R;
		var rightR = controls.UI_RIGHT_R;

		var leftHold = controls.UI_LEFT;
		var rightHold = controls.UI_RIGHT;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if (FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if (songs.length > 1)
		{
			if (leftHold || rightHold)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if (holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (leftHold ? -shiftMult : shiftMult));
					//changeDiff();
				}
			}
			else holdTime = 0;
		}

		if (leftP)
		{
			//changeDiff(-1);
			changeSelection(-1);
			leftArrow.loadGraphic(Paths.image(path + 'allstarsleftarrowsmall', 'preload'));
		}
		else if (leftR) leftArrow.loadGraphic(Paths.image(path + 'allstarsleftarrowbig', 'preload'));

		if (rightP)
		{
			//changeDiff(1);
			changeSelection(1);
			rightArrow.loadGraphic(Paths.image(path + 'allstarsrightarrowsmall', 'preload'));
		}
		else if (rightR) rightArrow.loadGraphic(Paths.image(path + 'allstarsrightarrowbig', 'preload'));

		if (controls.BACK)
		{
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(ctrl)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		else if(space)
		{
			if(instPlaying != curSelected && !songs[curSelected].locked)
			{
				#if PRELOAD_ALL
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				Paths.currentModDirectory = songs[curSelected].folder;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				if (PlayState.SONG.needsVoices)
					vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
				else
					vocals = new FlxSound();

				FlxG.sound.list.add(vocals);
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
				vocals.play();
				vocals.persist = true;
				vocals.looped = true;
				vocals.volume = 0.7;
				instPlaying = curSelected;
				#end
			}
		}

		if (FlxG.keys.justPressed.SEVEN && WeekData.AllWeeksCompleted([grandDadWeek]))
		{
			FlxG.sound.play(Paths.sound('Bump'));
			FlxG.camera.visible = false;
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.sound.music.stop();
			destroyFreeplayVocals();
			MusicBeatState.switchState(new MarioSevenStart());
		}

		else if (accepted)
		{
			if (!songs[curSelected].locked)
			{
				persistentUpdate = false;
				var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
				var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
				trace(poop);

				PlayState.resetProperties();
				PlayState.SONG = Song.loadFromJson(poop, songLowercase);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;
				PlayState.storyWeek = songs[curSelected].week;

				// HARDCODING BECAUSE IM STUPID AS HELL - ighby
				var loadImage:String = 'loadingscreen-1';
				switch (poop)
				{
					case 'pissed':
						loadImage = 'lodaing';
				}
				LoadingState.loadingImage = loadImage;

				trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
				if(colorTween != null) {
					colorTween.cancel();
				}
				
				if (FlxG.keys.pressed.SHIFT){
					LoadingState.loadAndSwitchState(new ChartingState());
				}else{
					LoadingState.loadAndSwitchState(new PlayState());
				}

				FlxG.sound.music.volume = 0;
						
				destroyFreeplayVocals();
			}
			else
				FlxG.sound.play(Paths.sound('wrong'), 1);
		}
		else if (controls.RESET && !songs[curSelected].locked)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		arts.forEach(function(spr:FlxSprite){

			if(curSelected == spr.ID)
			{
				if (songs[curSelected].locked)
					nameArt.loadGraphic(Paths.image(path + 'names/question_name'));
				else
					nameArt.loadGraphic(Paths.image(path + 'names/' + songs[spr.ID].songName.toLowerCase() + '_name'));
				nameArt.updateHitbox();
				nameArt.screenCenter();
				nameArt.y += FlxG.height * 0.4;

				for(i in 0...artsSelect.members.length)
				{
					if(spr.ID == artsSelect.members[i].ID)
					{
						artsSelect.members[i].visible = true;
					}
					else
					{
						artsSelect.members[i].visible = false;
					}
				}

				spr.visible = false;
			}
			else
			{
				spr.visible = true;
			}
		});
		leftArrow.screenCenter(X);
		leftArrow.x -= (nameArt.width / 2) + 40;

		rightArrow.screenCenter(X);
		rightArrow.x += (nameArt.width / 2) + 40;
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";
	public var locked:Bool = false;

	public function new(song:String, week:Int, songCharacter:String, color:Int, locked:Bool)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.locked = locked;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}