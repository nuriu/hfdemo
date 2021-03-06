package;

import flixel.FlxG;
import flixel.FlxSprite;

class Kart extends FlxSprite
{
	public var tur : String;
	public var deger : Int;
	public var puanDegeri : Int;


    public function new(kartTuru : String, kartDegeri : Int, kartPuanDegeri : Int)
    {
        super();

        this.tur = kartTuru;
        this.deger = kartDegeri;
        this.puanDegeri = kartPuanDegeri;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}