package player;

import flixel.math.FlxPoint;
import flixel.FlxSprite;
import player.Player;
import flixel.util.FlxColor;

/**
 * Saw that surrounds the player for defense
**/

class Saw extends FlxSprite
{
    
    public static var SPEED = 250;
    public var player_:Player;
    public var sawNum:Float;

    public function new(X:Float = 0, Y:Float = 0, player:Player, num:Float = 0)
    {
        super(X, Y);
        this.angularVelocity = 250;
        //this.acceleration.y = 10;
        player_ = player;
        this.sawNum = num;
        makeGraphic(15, 15, FlxColor.BROWN);
    }

    override public function update(elapsed:Float)
    {
        followPlayer();

        super.update(elapsed);
    }

    private function followPlayer()
    {
        var sawMidpoint = getMidpoint();
        var playerMidpoint = player_.getMidpoint();

        var angle = playerMidpoint.angleBetween(sawMidpoint);
        if (sawNum == 0)
        {
            this.velocity.set(SPEED, 0);
            this.velocity.rotate(FlxPoint.weak(0, 0), angle + 15);
        } else
        {
            this.velocity.set(-SPEED, 0);
            this.velocity.rotate(FlxPoint.weak(0, 0), angle - 15);
        }
        // if too far away
        if (playerMidpoint.distanceTo(sawMidpoint) > 450)
        {
            this.reset(player_.x, player_.y);
        }
        
        // this.x = player_.x + 75;
        // this.y = player_.y + 75;
        // use set position
    }
}