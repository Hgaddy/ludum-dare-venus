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
	static var SPEED:Float = 75;

	var type:EnemyType;

	static var bossHealth:Int = 6;

	public function new(type:EnemyType)
	{
		super(x, y);
		velocity.y = SPEED; // Speed of enemies

		this.type = type;
		var graphic = if (type == BOSS) AssetPaths.boss__png else AssetPaths.enemy__png;
		if (type == BOSS)
		{
			velocity.x = SPEED;
			velocity.y = 0;
			loadGraphic(graphic, true);
			this.width = 80;
			this.height = 120;
			this.offset.x = 20;
			this.offset.y = 10;
		}
		else
		{
			loadGraphic(graphic, true);
			this.width = 30;
			this.height = 45;
			this.offset.x = 10;
			this.offset.y = 5;
		}
		kill();
	}

	// Overriding the revive() function, sets position of where enemies spawn, and randomizes their spawn location after they hit the bottom and are
	override public function revive()
	{
		x = FlxG.random.int(0, Std.int(FlxG.width - width));
		y = -height;
		super.revive();
	}

	override public function update(elapsed:Float)
	{
		if (movedOffScreen())
		{
			kill();
		}

		screenWrapping();

		super.update(elapsed);
	}

	private function movedOffScreen()
	{
		return y + height < FlxG.camera.scroll.y;
	}

	public static function overlapsWithPlayer(player:FlxObject, Enemy:Enemy)
	{
		player.hurt(1);
		Enemy.kill();
	}

	public static function overlapsWithSaw(saw:FlxObject, Enemy:Enemy)
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

	private function screenWrapping()
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
