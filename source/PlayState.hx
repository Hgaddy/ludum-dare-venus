package;

import flixel.system.debug.watch.WatchEntry;
import flixel.util.FlxTimer;
import player.Saw;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import player.Player;
import Hud;
import flixel.FlxCamera;
import enemies.Enemy;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	private var newSawTimer:FlxTimer = new FlxTimer();
	private var newSawDelay:Float = 10;

	var backdrop:FlxBackdrop;
	var player:Player;
	var hud:Hud;
	var saw:Saw;
	var saw2:Saw;

	var enemiesOne:FlxTypedGroup<Enemy>;
	var enemiesTwo:FlxTypedGroup<Enemy>;
	var enemiesThree:FlxTypedGroup<Enemy>;
	var enemy:Enemy;
	var boss:Enemy;
	var SECONDS_PER_ENEMY(default, never):Float = 1;

	var ending:Bool = false;

	override public function create()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		super.create();

		// create backdrop
		backdrop = new FlxBackdrop(AssetPaths.stars__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);

		// create player
		player = new Player(FlxG.width / 2, FlxG.height - 80);
		hud = new Hud(player, 22, 22);

		// generate first saw
		saw = new Saw(FlxG.width / 2, FlxG.height - 80, player, 0);

		// start saw timer
		newSawTimer.start(newSawDelay, setUpSaws, 1);

		add(backdrop);
		add(player);
		add(hud);
		add(saw);

		// create enemies
		// setUpEnemies();
		enemy = new Enemy(100, 0, NORMY);
		add(enemy);
	}

	private function setUpSaws(timer:FlxTimer)
	{
		saw2 = new Saw(FlxG.width / 4, FlxG.height / 4, player, 1);
		add(saw2);
	}

	private function setUpEnemies()
	{
		enemiesOne = new FlxTypedGroup<Enemy>();
		enemiesTwo = new FlxTypedGroup<Enemy>();
		enemiesThree = new FlxTypedGroup<Enemy>();
		for (i in 0...5)
		{
			var enemyOne = new Enemy(FlxG.random.float(0, FlxG.width), 0, NORMY);
			var enemyTwo = new Enemy(FlxG.random.float(0, FlxG.width), 0, NORMY);
			var enemyThree = new Enemy(FlxG.random.float(0, FlxG.width), 0, NORMY);
			enemyOne.kill();
			enemyTwo.kill();
			enemyThree.kill();
			enemiesOne.add(enemyOne);
			enemiesTwo.add(enemyTwo);
			enemiesThree.add(enemyThree);
		}

		add(enemiesOne);
		add(enemiesTwo);
		add(enemiesThree);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// End anything else from happening if the game is ready to 'end'
		if (ending)
		{
			return;
		}

		FlxG.overlap(player, enemy, Enemy.overlapsWithPlayer);
		// FlxG.overlap(saw, enemy, Enemy.overlapsWithSaw);
		// FlxG.overlap(saw2, enemy, Enemy.overlapsWithSaw2);
		// FlxG.overlap(player, enemiesTwo, Enemy.overlapsWithPlayer);
		// FlxG.overlap(player, enemiesThree, Enemy.overlapsWithPlayer);

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;

		// End the game if the player reaches 0 lives or health
		if (player.health <= 0)
		{
			ending = true;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function gameOver()
			{
				FlxG.switchState(new GameOverState());
			});
		}
	}
}
