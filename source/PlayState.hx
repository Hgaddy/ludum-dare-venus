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
		player = new Player(FlxG.width / 2, FlxG.height - 80);
		hud = new Hud(player, 22, 22);

		// generate first saw
		saw = new Saw(FlxG.width / 2, FlxG.height - 80, player, 0);
		saw2 = new Saw(FlxG.width / 4, FlxG.height / 4, player, 1);

		// add elements
		add(backdrop);
		add(player);
		add(hud);
		add(saw);
		add(saw2);

		// create enemies
		// setUpEnemies();
		enemy = new Enemy(100, 0, NORMY);
		add(enemy);
	}

	private function setUpEnemies()
	{
		enemiesOne = new FlxTypedGroup<Enemy>();
		enemiesTwo = new FlxTypedGroup<Enemy>();
		enemiesThree = new FlxTypedGroup<Enemy>();
		for (i in 0...5)
		{
			var enemyOne = new Enemy(0, 0, NORMY);
			var enemyTwo = new Enemy(150, 0, NORMY);
			var enemyThree = new Enemy(300, 0, NORMY);
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

		if (!enemy.isOnScreen())
		{
			var enemyBoss = new Enemy(250, 0, BOSS);
			add(enemyBoss);
		}
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
		FlxG.overlap(saw, enemy, Enemy.overlapsWithSaw);
		FlxG.overlap(saw2, enemy, Enemy.overlapsWithSaw);
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
