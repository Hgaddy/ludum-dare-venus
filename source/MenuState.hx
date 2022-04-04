package;

import flixel.system.debug.interaction.tools.Pointer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import player.Saw;
import flixel.addons.ui.FlxButtonPlus;
import flixel.util.FlxColor;
import lime.system.System;
import flixel.FlxSprite;

class MenuState extends FlxState
{
	var titleText:FlxText;
	var titleText2:FlxText;
	var logosaw:Saw;
	var playButton:FlxButtonPlus;
	#if desktop
	var exitButton:FlxButtonPlus;
	#end

	override public function create()
	{
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			// start music
			FlxG.sound.playMusic(AssetPaths.sawintro__wav, 0.8, true);
		}

		// first part of title
		titleText = new FlxText(20, 0, 0, "Space Saw", 35);
		titleText.alignment = CENTER;
		titleText.screenCenter(X);
		add(titleText);

		// second part of title
		titleText2 = new FlxText(20, 60, 0, "Defense", 35);
		titleText2.alignment = CENTER;
		titleText2.screenCenter(X);
		add(titleText2);

		// Add spinning saw logo cover
		var logosaw = new FlxSprite();
		logosaw.loadGraphic(AssetPaths.titlesaw__png, false);
		logosaw.screenCenter();
		add(logosaw);
		logosaw.angularVelocity = 500;

		// add play button
		playButton = new FlxButtonPlus(0, 0, clickPlay, "Play", 200, 50);
		// PlayButton.onUp.sound = FlxG.sound.load(AssetPaths.start__wav);
		playButton.x = (FlxG.width / 2) - (0.5 * playButton.width);
		playButton.y = FlxG.height - playButton.height - 50;
		add(playButton);

		// add exit button
		#if desktop
		exitButton = new FlxButtonPlus(FlxG.width - 90, 8, clickExit, "X", 80, 20);
		// exitButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
		add(exitButton);
		#end

		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();
	}

	private function clickPlay()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.sound.music.stop();
			FlxG.switchState(new PlayState());
		});
	}

	#if desktop
	private function clickExit()
	{
		System.exit(0);
	}
	#end

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
		{
			FlxG.sound.play(AssetPaths.MenuClick__wav, 100); // MenuClick sound
		}

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
