package enemies;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import enemies.Enemy;

@:generic
class EnemyGenerator<T:Enemy> extends FlxBasic
{
	public var enemies(default, null):FlxTypedGroup<T>;

	private var spawnTimer:FlxTimer = new FlxTimer();

	public var spawnDelay(default, set):Float;

	public function new(spawnDelay:Float, obstacles:FlxTypedGroup<T>)
	{
		super();
		this.spawnDelay = spawnDelay;
		spawnTimer.start(spawnDelay, generateEnemy, 0);
	}

	public function setSpawnDelay(spawnDelay:Float):Float
	{
		this.spawnDelay = spawnDelay;
		if (spawnTimer.active == true)
		{
			spawnTimer.time = this.spawnDelay;
		}
		return this.spawnDelay;
	}

	public function generateEnemy(timer:FlxTimer)
	{
		var recycled:Enemy = enemies.recycle();
	}
}
