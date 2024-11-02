package options;

#if desktop
import Discord.DiscordClient;
#end
import openfl.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import openfl.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import haxe.Json;
import haxe.format.JsonParser;

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
    var noteSkinList:Array<String> = CoolUtil.coolTextFile(StorageUtil.getStorageDirectory() + Paths.getPreloadPath('images/NoteSkin/DataSet/noteSkinList.txt'));
    
	public function new()
	{
		title = 'Visuals and UI Settings';
		rpcTitle = 'Visuals and UI Settings Menu'; //for Discord Rich Presence
		noteSkinList.unshift('original');
		
		var option:Option = new Option('Freeplay Menu Style:',
			"Choose your Freeplay Menu Style",
			'FreeplayStyle',
			'string',
			['Psych', 'NovaFlare', 'NF']);
		addOption(option);
		
		var option:Option = new Option('Main Menu Style:',
			"Choose your Main Menu Style",
			'MainMenuStyle',
			'string'
			['1.0', 'NovaFlare', '0.6.3', 'Extended']);
		addOption(option);
		
		var option:Option = new Option('Pause Menu Style:',
			"Choose your Pause Menu Style",
			'PauseMenuStyle',
			'string'
			['Psych', 'NovaFlare']);
		addOption(option);
		
		var option:Option = new Option('Transition Style:',
			"Choose your Transition Style",
			'TransitionStyle',
			'string'
			['Psych', 'NovaFlare', 'Extended']);
		addOption(option);
		
		var option:Option = new Option('Note Skin:',
			"Choose Note Skin",
			'NoteSkin',
			'string'
			noteSkinList);	
		option.showNote = true;
		addOption(option);
		option.onChange = onChangeNoteSkin;
		
		#if (!INDIECROSS_FORCED && INDIECROSS_ASSETS)
		var option:Option = new Option('Indie Cross Menus',
			'If unchecked, Indie Cross Mods not using Custom Menus (if you have any bug disable this).',
			'IndieCrossMenus',
			'bool');
		addOption(option);
		option.onChange = changeIndieCrossMenus;
		#end

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool');
		addOption(option);

		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool');
		addOption(option);
		
		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool');
		addOption(option);

		var option:Option = new Option('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool');
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit',
			"If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom',
			'bool');
		addOption(option);

		var option:Option = new Option('Health Bar Transparency',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			'percent');
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			'bool');
		addOption(option);
		option.onChange = onChangeFPSCounter;

		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		var option:Option = new Option('Main Menu Song:',
			"What song do you prefer for the Main Menu?",
			'FreakyMenu',
			'string',
			['Extended', 'Psych']);
		addOption(option);
		option.onChange = onChangeMenuMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			'bool');
		addOption(option);
		#end

		var option:Option = new Option('Combo Stacking',
			"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
			'comboStacking',
			'bool');
		addOption(option);

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.data.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));

		changedMusic = true;
	}
	
	function onChangeMenuMusic()
	{
		FlxG.sound.playMusic(Paths.music('freakyMenu'));
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}
	
	function changeIndieCrossMenus()
	{
	    if (!TitleState.IndieCrossEnabled && Paths.currentModDirectory.startsWith('Indie Cross'))
            TitleState.IndieCrossEnabled = true;
        else if (TitleState.IndieCrossEnabled)
	        TitleState.IndieCrossEnabled = ClientPrefs.data.IndieCrossMenus;
	}

	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.data.showFPS;
	}
	
	function onChangeNoteSkin()
	{
		remove(grpNote);

		grpNote = new FlxTypedGroup<FlxSprite>();
		add(grpNote);
		
		for (i in 0...ClientPrefs.data.arrowHSV.length) {
			var notes:FlxSprite = new FlxSprite((i * 125), 100);
			if (ClientPrefs.data.NoteSkin == 'original')
			    notes.frames = Paths.getSparrowAtlas('NOTE_assets');
			else
			    notes.frames = Paths.getSparrowAtlas('NoteSkin/' + ClientPrefs.data.NoteSkin);
			var animations:Array<String> = ['purple0', 'blue0', 'green0', 'red0'];
			notes.animation.addByPrefix('idle', animations[i]);
			notes.animation.play('idle');
			notes.scale.set(0.8, 0.8);
			notes.x += 700;
			notes.antialiasing = ClientPrefs.data.antialiasing;
			grpNote.add(notes);
			
			var newShader:ColorSwap = new ColorSwap();
			notes.shader = newShader.shader;
			newShader.hue = ClientPrefs.data.arrowHSV[i][0] / 360;
			newShader.saturation = ClientPrefs.data.arrowHSV[i][1] / 100;
			newShader.brightness = ClientPrefs.data.arrowHSV[i][2] / 100;	    
		}
	}
}
