package player;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public static var SPEED(default, never):Int = 150;

	public var maxHealth:Int = 3;

	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
		makeGraphic(16, 16, FlxColor.RED);
		health = maxHealth;
	}

	override public function update(elapsed:Float)
	{
		setSpeed();

		super.update(elapsed);
	}

	private function setSpeed()
	{
		if (x < 4 || x > FlxG.width - width)
		{
			velocity.x = 0;
		}

		if (FlxG.keys.justPressed.UP)
		{
			velocity.y = -SPEED;
		}

		if (FlxG.keys.pressed.LEFT && x > 4)
		{
			velocity.x = -(SPEED * 1.4);
		}

		if (FlxG.keys.pressed.RIGHT && x < FlxG.width - width)
		{
			velocity.x = SPEED;
		}

		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y = SPEED;
		}

		if (FlxG.keys.pressed.RIGHT && FlxG.keys.pressed.LEFT)
		{
			// cancel out
			velocity.x = 0;
		}

		if (FlxG.keys.pressed.UP && FlxG.keys.pressed.DOWN)
		{
			// cancel out
			velocity.y = 0;
		}

		if (FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.RIGHT)
		{
			velocity.x = 0;
		}

		if (FlxG.keys.justReleased.UP || FlxG.keys.justReleased.DOWN)
		{
			velocity.y = 0;
		}
	}

	override function kill()
	{
		reset(FlxG.width / 2, FlxG.height - 80);
		health -= 1;
		// currentPower.inUse = false;
		// currentPower.usable = true;
		// cast(FlxG.state, PlayState).resetScore();
	}
}