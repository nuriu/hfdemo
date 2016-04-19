package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuDurumu extends FlxState
{
	var oyuncu:Paddle;
	override public function create():Void
	{
		super.create();

		// birinci paddle
		oyuncu = new Paddle(10, 10);
		add(oyuncu);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// birinci paddle hareketleri
		if (FlxG.keys.pressed.UP)
		{
			oyuncu.y -= 5;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			oyuncu.y += 5;
		}

		// ekrandan dışarı çıkmasını önleme
		if (oyuncu.y < 0)
		{
			oyuncu.y = 0;
		}
		if (oyuncu.y > FlxG.stage.stageHeight - oyuncu.height)
		{
			oyuncu.y = FlxG.stage.stageHeight - oyuncu.height;
		}
	}
}
