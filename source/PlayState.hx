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
	// Enemy variables
	var enemyGroup:FlxTypedGroup<Enemy>;
	var spawnTimer:Float = 0;
	var enemy:Enemy;
	//	var boss:Enemy;
	var SECONDS_PER_ENEMY(default, never):Float = 1;

	// Player and Saw variables
	private var newSawTimer:FlxTimer = new FlxTimer();
	private var newSawDelay:Float = 10;

	var backdrop:FlxBackdrop;
	var player:Player;
	var hud:Hud;
	var saw:Saw;
	var saw2:Saw;

	var ending:Bool = false;

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

		// create player
		player = new Player(FlxG.width / 2, FlxG.height - 80);
		hud = new Hud(player, 22, 22);

		// generate first saw
		saw = new Saw(FlxG.width / 2, FlxG.height - 80, player, 0);
		saw2 = new Saw(FlxG.width / 2 + 15, FlxG.height - 80, player, 1);

		// add elements
		add(backdrop);
		add(player);
		add(hud);
		add(saw);
		add(saw2);

		// Create the enemies
		add(enemyGroup = new FlxTypedGroup<Enemy>(20));
	}

	// SpawnTimer of enemies, deals with just NORMY type enemies at the moment.
	override public function update(elapsed:Float)
	{
		spawnTimer += elapsed * 3;	//Reduce this timer value to  make it take longer for ships to respawn, increase for opposite effect.
		if (spawnTimer > 1)
		{
			spawnTimer--;
			enemyGroup.add(enemyGroup.recycle(Enemy.new.bind(EnemyType.NORMY)));
		}
		super.update(elapsed);

		// End anything else from happening if the game is ready to 'end'
		if (ending)
		{
			return;
		}

		// Enemy collision detection
		FlxG.overlap(player, enemyGroup, Enemy.overlapsWithPlayer);
		FlxG.overlap(saw, enemyGroup, Enemy.overlapsWithSaw);
		FlxG.overlap(saw2, enemyGroup, Enemy.overlapsWithSaw);

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
