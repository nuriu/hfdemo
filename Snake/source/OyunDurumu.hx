package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class OyunDurumu extends FlxState
{
	private var skorMetni:FlxText;
	private var skor:Int = 0;

	override public function create():Void
	{
		#if desktop
		FlxG.mouse.visible = false;
		#end
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
