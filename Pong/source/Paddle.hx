package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Paddle extends FlxSprite
{
    public function new(x:Float, y:Float, renk:FlxColor)
    {
        super(x, y);
        
        makeGraphic(10, 100, renk);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}