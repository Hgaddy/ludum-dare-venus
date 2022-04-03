package;

import flixel.util.FlxTimer;
import player.Saw;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import player.Player;
import Hud;
import flixel.FlxCamera;

class PlayState extends FlxState
{
	private var newSawTimer:FlxTimer = new FlxTimer();
	private var newSawDelay:Float = 10;

	var backdrop:FlxBackdrop;
	var player:Player;
	var hud:Hud;
	var saw:Saw;
	var saw2:Saw;

	override public function create()
	{
		// start music
		FlxG.sound.playMusic(AssetPaths.sawmain__wav, 1, true);

		// fase in
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		// call super
		super.create();

		// create backdrop
		backdrop = new FlxBackdrop(AssetPaths.stars__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);

		// create player
		player = new Player(FlxG.width / 4, FlxG.height / 4);
		hud = new Hud(player, 22, 22);

		// generate first saw
		saw = new Saw(FlxG.width / 4, FlxG.height / 4, player, 0);

		// start saw timer
		newSawTimer.start(newSawDelay, setUpSaws, 1);

		// add elements
		add(backdrop);
		add(player);
		add(hud);
		add(saw);
	}

	private function setUpSaws(timer:FlxTimer)
	{
		saw2 = new Saw(FlxG.width / 4, FlxG.height / 4, player, 1);
		add(saw2);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
