package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class BitmeDurumu extends FlxState
{
	override public function create():Void
	{
		super.create();
		Sys.println("DEBUG: BitmeDurumu durumuna geçildi.");
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);
	}
}