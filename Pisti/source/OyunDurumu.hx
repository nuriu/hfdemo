package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class OyunDurumu extends FlxState
{
	override public function create():Void
	{
		FlxG.debugger.visible = true;
		super.create();

		Sys.println("DEBUG: OyunDurumu durumuna geçildi.");

		// örnek kart
		var d = new Deste();
		d.deste[13].x = 10;
		add(d.deste[13]);
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);
	}
}
