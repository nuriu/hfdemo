package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import haxe.ds.GenericStack;

class OyunDurumu extends FlxState
{
	public var ortaX : Float = FlxG.width / 2;
	public var ortaY : Float = FlxG.height / 2;

	private var ortaYigin : GenericStack<Kart> = new GenericStack<Kart>();

	override public function create():Void
	{
		//FlxG.debugger.visible = true;
		super.create();

		Sys.println("DEBUG: OyunDurumu durumuna geçildi.");
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);
	}
}