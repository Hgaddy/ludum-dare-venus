package;

import lime.system.System;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.addons.ui.FlxButtonPlus;

class GameOverState extends FlxState
{
	var titleText:FlxText;
	var titleText2:FlxText;
	var endMessage:FlxText;
	var endMessage2:FlxText;
	var tryAgainButton:FlxButtonPlus;
	#if desktop
	var exitButton:FlxButtonPlus;
	#end

	override public function create()
	{
		#if FLX_MOUSE
		FlxG.mouse.visible = true;
		#end

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

		// Game Over messages
		endMessage = new FlxText(0, 0, 0, "The Earth has inevitably been destroyed! ", 22);
		endMessage.screenCenter();
		add(endMessage);
		endMessage2 = new FlxText((FlxG.width / 2) - 140, (FlxG.height / 2) + 20, 0, "Game Over...or is it?!", 22);
		add(endMessage2);
		// Play again button
		tryAgainButton = new FlxButtonPlus(0, 0, tryAgain, "Try Again?", 200, 50);
		// PlayButton.onUp.sound = FlxG.sound.load(AssetPaths.start__wav);
		tryAgainButton.x = (FlxG.width / 2) - (0.5 * tryAgainButton.width);
		tryAgainButton.y = FlxG.height - tryAgainButton.height - 10;
		add(tryAgainButton);
		// Exit the game button
		#if desktop
		exitButton = new FlxButtonPlus(FlxG.width - 90, 8, clickExit, "X", 80, 20);
		// exitButton.loadGraphic(AssetPaths.button__png, true, 20, 20);
		add(exitButton);
		#end

		super.create();
	}

	private function tryAgain()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}

	private function clickExit()
	{
		System.exit(0);
	}
}
