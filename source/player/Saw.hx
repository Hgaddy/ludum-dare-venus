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
        this.angularVelocity = 1000;
        //this.acceleration.y = 10;
        player_ = player;
        this.sawNum = num;
        makeGraphic(15, 15, FlxColor.GRAY);
    }

    override public function update(elapsed:Float)
    {
        followPlayer();

        super.update(elapsed);
    }

    private function followPlayer()
    {
        var sawMidpoint = getMidpoint();
        var playerHighMidpoint = player_.getMidpoint();
        var playerLowMidpoint = player_.getMidpoint();
        
        if (sawNum == 0)
        {
            playerHighMidpoint.x = player_.x - 30;
            var angle1 = playerHighMidpoint.angleBetween(sawMidpoint);
            this.velocity.set(SPEED, 0);
            this.velocity.rotate(FlxPoint.weak(0, 0), angle1 + 15);
        } else
        {
            playerLowMidpoint.x = player_.x + 45;
            var angle2 = playerLowMidpoint.angleBetween(sawMidpoint);
            this.velocity.set(-SPEED, 0);
            this.velocity.rotate(FlxPoint.weak(0, 0), angle2 - 15);
        }
        // if too far away
        var playerMidpoint = player_.getMidpoint();
        if (playerMidpoint.distanceTo(sawMidpoint) > 450)
        {
            this.reset(player_.x, player_.y);
        }
        
        // this.x = player_.x + 75;
        // this.y = player_.y + 75;
        // use set position
    }
}