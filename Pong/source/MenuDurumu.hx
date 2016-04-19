package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class MenuDurumu extends FlxState
{
	private var oyuncu:Paddle;
	private var oyuncu2:Paddle;

	override public function create():Void
	{
		super.create();

		// birinci oyuncu
		oyuncu = new Paddle(10, 10, FlxColor.WHITE);
		add(oyuncu);

		// ikinci oyuncu
		oyuncu2 = new Paddle(620, 10, FlxColor.RED);
		add(oyuncu2);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// birinci oyuncu hareketleri
		if (FlxG.keys.pressed.W)
			oyuncu.y -= 5;

		if (FlxG.keys.pressed.S)
			oyuncu.y += 5;

		// birinci oyuncunun ekrandan dışarı çıkmasını önleme
		if (oyuncu.y < 0)
			oyuncu.y = 0;

		if (oyuncu.y > FlxG.stage.stageHeight - oyuncu.height)
			oyuncu.y = FlxG.stage.stageHeight - oyuncu.height;

		// ikinci oyuncu hareketleri
		if (FlxG.keys.pressed.UP)
			oyuncu2.y -= 5;

		if (FlxG.keys.pressed.DOWN)
			oyuncu2.y += 5;

		// ikinci oyuncunun ekrandan dışarı çıkmasını önleme
		if (oyuncu2.y < 0)
			oyuncu2.y = 0;
		
		if (oyuncu2.y > FlxG.stage.stageHeight - oyuncu2.height)
			oyuncu2.y = FlxG.stage.stageHeight - oyuncu2.height;
	}
}
