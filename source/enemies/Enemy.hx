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

	static var bossHealth = 5;
	var maxBossHealth:Int = 5;

	var invulnTimerMax:Float = .5;
	var invulnTimer:Float = 0;

	public function new(type:EnemyType)
	{
		super(x, y);
		velocity.y = SPEED; // Speed of enemies

		this.type = type;
		var graphic = if (type == BOSS) AssetPaths.boss__png else AssetPaths.enemy__png;
		if (type == BOSS)
		{
			velocity.x = 0;
			velocity.y = SPEED / 10;
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
		if (type == BOSS)
		{
			maxBossHealth++;
			bossHealth = maxBossHealth;
		}
		
		super.revive();
	}

	override public function update(elapsed:Float)
	{
		if (invulnTimer > 0) {
			invulnTimer -= elapsed;
		}
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
		FlxG.sound.play(AssetPaths.PlayerHurt__wav, .80);
		if (Enemy.type == BOSS)
		{
			// Do nothing
		}
		else
		{
			Enemy.kill();
		}
	}

	public static function overlapsWithSaw(saw:FlxObject, enemy:Enemy)
	{
		if (enemy.type == BOSS && enemy.invulnTimer <= 0)
		{
			bossHealth -= 1;
			FlxG.sound.play(AssetPaths.EnemyDeath__wav, .80);
			enemy.invulnTimer = enemy.invulnTimerMax;
			if (bossHealth <= 0)
			{
				cast (FlxG.state, PlayState).enemiesKilled = 0;
				cast (FlxG.state, PlayState).bossSpawned = false;
				cast (FlxG.state, PlayState).enemyGroup.forEachAlive((enemy:Enemy) -> {enemy.kill();});
				enemy.kill();
				SPEED += 15;
			}
		}
		if (enemy.type == NORMY)
		{
			enemy.kill();
			FlxG.sound.play(AssetPaths.EnemyDeath__wav, .80);
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
