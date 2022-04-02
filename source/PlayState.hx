package;

import flixel.FlxG;
import flixel.FlxState;
import player.Player;

class PlayState extends FlxState
{
	var player:Player;

	override public function create()
	{
		super.create();

		// create player
		player = new Player(FlxG.width / 4, FlxG.height / 4);

		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
