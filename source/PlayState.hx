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
import enemies.Enemy;
import flixel.group.FlxGroup;
import flixel.FlxObject;

class PlayState extends FlxState
{
	// Enemy variables
	public var enemyGroup:FlxTypedGroup<Enemy>;
	var boss:Enemy;
	var spawnTimer:Float = 0;
	var enemy:Enemy;
	var SECONDS_PER_ENEMY(default, never):Float = 1;

	// Player and Saw variables
	private var newSawTimer:FlxTimer = new FlxTimer();
	private var newSawDelay:Float = 10;
	var backdrop:FlxBackdrop;
	var bottomWall:FlxObject;
	var player:Player;
	var hud:Hud;
	var saw:Saw;
	var saw2:Saw;
	// Game Over condition(s)
	var ending:Bool = false;
	public var enemiesKilled:Int = 0;
	public var bossSpawned:Bool = false;

	override public function create()
	{
		// start music
		FlxG.sound.playMusic(AssetPaths.sawmain__wav, 0.8, true);

		// phase in
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		// call super
		super.create();

		// create backdrop
		backdrop = new FlxBackdrop(AssetPaths.stars__png, 0, 1, false, true, 0, 0);
		backdrop.velocity.set(0, 100);

		// create bottom wall
		bottomWall = new FlxObject(0, FlxG.height, FlxG.width, (FlxG.height - 10));
		bottomWall.immovable = true;

		// create player
		player = new Player(FlxG.width / 2, FlxG.height - 80);
		hud = new Hud(player, 22, 22);

		// generate first saw
		saw = new Saw(FlxG.width / 2, FlxG.height - 80, player, 0);
		saw2 = new Saw(FlxG.width / 2 + 15, FlxG.height - 80, player, 1);

		// add elements
		add(backdrop);
		add(bottomWall);
		add(player);
		add(saw);
		add(saw2);

		// Create the enemies
		add(enemyGroup = new FlxTypedGroup<Enemy>(20));
		add(boss = new Enemy(EnemyType.BOSS));

		// add hud
		add(hud);
	}

	// SpawnTimer of enemies, deals with just NORMY type enemies at the moment.
	override public function update(elapsed:Float)
	{
		spawnTimer += elapsed * 3; // Reduce this timer value to  make it take longer for ships to respawn, increase for opposite effect.
		if (spawnTimer > 1 && enemiesKilled < 15)
		{
			spawnTimer--;
			enemyGroup.add(enemyGroup.recycle(Enemy.new.bind(EnemyType.NORMY)));
		}
		if (enemiesKilled >= 15 && !bossSpawned)
		{
			FlxG.sound.playMusic(AssetPaths.sawboss__wav, 0.8, true);
			boss.revive();
			bossSpawned = true;
		}
		super.update(elapsed);

		// End anything else from happening if the game is ready to 'end'
		if (ending)
		{
			return;
		}

		// Bottom wall collision
		if (FlxG.collide(player, bottomWall))
		{
			player.velocity.y = 0;
		}

		// Enemy collision detection
		FlxG.overlap(player, enemyGroup, Enemy.overlapsWithPlayer);
		FlxG.overlap(player, boss, Enemy.overlapsWithPlayer);

		if (FlxG.overlap(saw, enemyGroup, Enemy.overlapsWithSaw))
		{
			hud.addScore(1);
			enemiesKilled++;
		}
		if (FlxG.overlap(saw2, enemyGroup, Enemy.overlapsWithSaw))
		{
			hud.addScore(1);
			enemiesKilled++;
		}
		if (FlxG.overlap(saw, boss, Enemy.overlapsWithSaw))
		{
			hud.addScore(1);
		}
		if (FlxG.overlap(saw2, boss, Enemy.overlapsWithSaw))
		{
			hud.addScore(1);
		}

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;

		// End the game if the player reaches 0 lives or health
		if (player.health <= 0)
		{
			FlxG.sound.play(AssetPaths.PlayerDeath__wav, 100);

			ending = true;
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function gameOver()
			{
				FlxG.switchState(new GameOverState());
			});
		}
	}
}
