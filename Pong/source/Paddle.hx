package;

import flixel.FlxSprite;
import flixel.FlxG;

class Paddle extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        makeGraphic(10, 100, 0xFFFFFFFF);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}