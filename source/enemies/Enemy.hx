package enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;

enum EnemyType
{
	NORMY;
	BOSS;
}

class Enemy extends FlxSprite
{
	static inline var SPEED:Float = 120;

	var type:EnemyType;
	var bossHealth:Int = 6;

	public function new(x:Float = 0, y:Float = 0, type:EnemyType)
	{
		super();
		this.type = type;
		velocity.y = SPEED;
		var graphic = if (type == BOSS) AssetPaths.boss__png else AssetPaths.enemy__png;
		if (type == BOSS)
		{
			loadGraphic(graphic, true, 100, 140);
		}
		else
		{
			loadGraphic(graphic, true, 50, 55);
		}
	}

	override public function update(elapsed:Float)
	{
		if (movedOffScreen())
		{
			kill();
		}

		wallWrapping();

		super.update(elapsed);
	}

	private function movedOffScreen()
	{
		return y + height < FlxG.camera.scroll.y;
	}

	public static function overlapsWithPlayer(player:FlxObject, Enemy:Enemy)
	{
		player.kill();
	}

	public function overlapsWithSaw(saw:FlxObject, Enemy:Enemy)
	{
		if (Enemy.type == BOSS)
		{
			bossHealth -= 1;
			if (bossHealth <= 0)
			{
				Enemy.kill();
			}
		}
		if (Enemy.type == NORMY)
		{
			Enemy.kill();
		}
	}

	public function overlapsWithSaw2(saw2:FlxObject, Enemy:Enemy)
	{
		if (Enemy.type == BOSS)
		{
			bossHealth -= 1;
			if (bossHealth <= 0)
			{
				Enemy.kill();
			}
		}
		if (Enemy.type == NORMY)
		{
			Enemy.kill();
		}
	}

	private function wallWrapping()
	{
		if (y < 0 - height && type == NORMY)
		{
			y = FlxG.height;
		}
		if (y > FlxG.height && type == NORMY)
		{
			y = 0 - height;
		}
	}
}
