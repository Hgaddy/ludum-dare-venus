package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import player.Player;

class PlayState extends FlxState
{
	var backdrop:FlxBackdrop;
	var player:Player;

	override public function create()
	{
		super.create();

		// create backdrop
		backdrop = new FlxBackdrop(AssetPaths.stars__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);

		// create player
		player = new Player(FlxG.width / 4, FlxG.height / 4);

		add(backdrop);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
	}
}
