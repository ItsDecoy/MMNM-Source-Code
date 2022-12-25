package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}

		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['MMNM Team'],
			['Inferno',		'inferno',		'Creator, Director, Artist, Pixel Artist\nMade: MX, IHY Luigi, Coronation Peach, Pissed Goomba, Menus, Cutscene Sprites, and Icons',							'https://twitter.com/Inferno_Plumber',	'8B0000'],
			['Decoy',			'decoy',		'Charter and Coder\nCharted: Burning Hatred',						'https://twitter.com/Yoshinova_',		'663399'],
			['Elie',				'Elie',			'Beta Charter',					'https://twitter.com/Elie_EETHELI',			'279ADC'],
			['Comic',				'Comic_Icon',			'Charter and Coder\nCharted: A Grand Ol Time',	'https://twitter.com/ComicTheHero',			'f0d0a4'],
			['Fredrick',			'Fredrick',			'Charter and Coder\nCharted: Blinked, Pink Forest, Heros Doom, Familiar, Merry Massacre and Ground Zero',						'https://twitter.com/FredrickFunny',			'00CED1'],
			['willisaclown',		'Willisaclown',	'Composer and Charter\n Composed: Pink Forest, Heros Doom, aGoT, and Victimized\n Charted: Victimized, Cover-Up, and Pissed',								'https://twitter.com/willisaclown',	'FF1493'],
			['TeiCleM',				'teiclem',			'Coder',								'https://twitter.com/TeiClemus',		'4D5DBD'],
			['Polar Vortex',				'polar',			'Coder',								'https://twitter.com/_Polar_Vortex',		'4D5DBD'],
			['MorenoTheCappuccinoChugger',		'moreno',	"Coder",						'https://twitter.com/the_chugger',	'F73838'],
			['Ighby',		'ighby',	"\"Holy shit he's an awesome coder\"\nMade: Plumber BF sprites",							'https://twitter.com/Ighby_Guy',	'B22222'],
			['Chase Redding',			'Chase',			"Composer\nComposed: Burning Hatred and Merry Massacre",							'https://twitter.com/Chase_R_Music_',			'808080'],
			['ophomix24',			'Glowy',		"Musician\nComposed: Familiar, Blinked, Merry Massacre and Pissed\nCredit to @genesismobie for icon",							'https://twitter.com/ophomix241',		'808080'],
			['Frog',				'frog',			'Composer\n Composed: Ground Zero and Victimized',								'https://twitter.com/yoshi_epic',		'00CCFF'],
			['thesmallerestguy',				'Smallerest',			'Composer\n Composed: A Grand Ol Time, and many other misc sounds/songs',								'NA',		'191919'],
			['Mystica',				'Icon_Mystic',			'Composer\n Composed: Cover-Up',								'https://twitter.com/Mystic69691',		'4D5DBD'],
			['Scrumbo_',				'scrumbo-icon',			'Artist\n Made: False Hero, MX, Coronation Day, Victim, and IHY BGs',								'https://twitter.com/scrumbo_',		'FFC0CB'],
			['Nylox',				'Nylonic',			'Artist\n Made: False Hero, Dais-eye sprites, MMNM Logo',								'https://twitter.com/ArtNylonic',		'FF0000'],
			['Elias',				'Elias',			'Artist\n Made: Victim sprites',								'https://twitter.com/elias60985444',		'FFB6C1'],
			['Cattinscool1002',				'cattin',			'Artist and Animator\n Made: SH Mario sprites, Pissing Mario sprites\nAnimated: IHY, MX, Goomba, and Grand Dad',								'https://twitter.com/Cattinscool1001',		'4D5DBD'],
			['OscaRaczo',				'Icon_OscaRaczo-2',			'Artist\n Made: SH Mario Background, Plumber GF, Grand Dad, Grand Dad Background, and Victim Icons', 								'https://twitter.com/osca_raczo',		'FF0000'],
			['ScrubbDubb',				'scrubb',			'Artist\n Made: Most Icons *wouldnt give me icon so*',								'https://twitter.com/ScrubbDubb',		'BDB76B'],
			['SolarDaily',				'solar',			'Artist\n Made: Merry Massacre BG, MX Chair, and BG Merry Massacre Characters',								'https://twitter.com/Crocoboyo',		'ADFF2F'],
			['Akayo',				'Akayo',			'Artist\n Made: Note Splash',								'https://twitter.com/Akayo61',		'191919'],
			['DexCord',				'Dex',			'3D Moddeler\n Modled: Wario Head',								'',		'B8860B'],
			['mar.',				'Mar',			'3D Moddeler\n Modled: N64 Mario, BF, and the BG',								'https://twitter.com/YourOPlayz',		'4D5DBD'],
			['SlushyAnime',				'Slush',			'Helped with Ground Zero backround',								'https://twitter.com/Slushy_Anime',		'4D5DBD'],
			['AG_Coffee',				'AG',			'Animator\n Animated: Plumber GF, Backround characters in A Grand Ol Time, MX Clouds, and Podoboo gimmick',								'',		'556B2F'],
			['FuriousAntz',				'FuriousAntz',			'Antimator\n Animated: False Hero sprites, Lucas sprites, Cutscenes, Merry Massacre Characters',								'',		'FF1493'],
			['marky',				'Marky',			'Voice Actor\n Played: MX',								'',		'FFFF00'],
			['2ToriL',				'2tor',			'Voice Actor\n Played: Coronation Day Peach',								'',		'4D5DBD'],
			['mostrolavelocita',				'mostrolavelocita',			'Voice Actor\n Played: IHY Luigi',								'',		'32CD32'],
			['Sunset',				'Sunset',			'Voice Actor\n Played: MX',								'',		'8B0000'],
			['Ordna',				'ordna',			'Chromatic Maker\nMade: Grand Dad Chromatic',								'', 	'AA32FE'],
			['Anti',				'anti',			'Chromatic Maker',									'https://twitter.com/Antimation_real',			'DAA520'],
			[''],
			['Psych Engine Team'],
			['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',							'https://twitter.com/Shadow_Mario_',	'444444'],
			['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',						'https://twitter.com/RiverOaken',		'C30085'],
			['shubs',				'shubs',			'Additional Programmer of Psych Engine',					'https://twitter.com/yoshubs',			'279ADC'],
			[''],
			['Former Engine Members'],
			['bb-panzu',			'bb-panzu',			'Ex-Programmer of Psych Engine',							'https://twitter.com/bbsub3',			'389A58'],
			[''],
			['Engine Contributors'],
			['iFlicky',				'iflicky',			'Composer of Psync and Tea Time\nMade the Dialogue Sounds',	'https://twitter.com/flicky_i',			'AA32FE'],
			['SqirraRNG',			'gedehari',			'Chart Editor\'s Sound Waveform base',						'https://twitter.com/gedehari',			'FF9300'],
			['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',								'https://twitter.com/polybiusproxy',	'FFEAA6'],
			['Keoiki',				'keoiki',			'Note Splash Animations',									'https://twitter.com/Keoiki_',			'FFFFFF'],
			['Smokey',				'smokey',			'Spritemap Texture Support',								'https://twitter.com/Smokey_5_',		'4D5DBD'],
			[''],
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",						'https://twitter.com/ninja_muffin99',	'F73838'],
			['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",							'https://twitter.com/PhantomArcade3K',	'FFBB1B'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",							'https://twitter.com/evilsk8r',			'53E52C'],
			['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",							'https://twitter.com/kawaisprite',		'6475F3']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("Pixel_NES.otf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-1 * shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(1 * shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(controls.ACCEPT) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.isBold)
			{
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 12, 0, 1);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(lastX, item.x - 70, lerpVal);
					item.forceX = item.x;
				}
				else
				{
					item.x = FlxMath.lerp(item.x, 200 + -40 * Math.abs(item.targetY), lerpVal);
					item.forceX = item.x;
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}