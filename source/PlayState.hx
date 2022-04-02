package;

import flixel.FlxG;
import flixel.FlxState;
import player.Player;
import Hud;
import flixel.FlxCamera;

class PlayState extends FlxState
{
	var player:Player;
	var hud:Hud;

	override public function create()
	{
		super.create();

		// create player
		player = new Player(FlxG.width / 4, FlxG.height / 4);
		hud = new Hud(player, 22, 22);


		add(player);
		add(hud);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
