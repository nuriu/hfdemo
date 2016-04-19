package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class OyunDurumu extends FlxState
{
	private var oyuncu:Paddle;
	private var oyuncu2:Paddle;
	private var top:Top;
	public static var oyuncuSkor:Float = 0;
	public static var oyuncu2Skor:Float = 0;

	override public function create():Void
	{
		super.create();

		if (FlxG.sound.music == null)
			FlxG.sound.playMusic(AssetPaths.arkaplan__ogg, 0.25, true);

		// birinci oyuncu
		oyuncu = new Paddle(10, 10, FlxColor.WHITE);
		add(oyuncu);

		// ikinci oyuncu
		oyuncu2 = new Paddle(620, 10, FlxColor.RED);
		add(oyuncu2);

		// top
		top = new Top(FlxG.stage.stageWidth / 2, FlxG.stage.stageHeight / 2, FlxColor.YELLOW);
		add(top);

		// skor değerleri
		var orta:Float = FlxG.stage.stageWidth / 2;
		var oyuncuSkorMetni:FlxText = new FlxText(orta - 100, 20, 100, "" + oyuncuSkor, 24);
		var oyuncu2SkorMetni:FlxText = new FlxText(orta + 100, 20, 100, "" + oyuncu2Skor, 24);

		add(oyuncuSkorMetni);
		add(oyuncu2SkorMetni);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// çarpma durumunda ilgili fonksiyonu çağır
		if (FlxG.overlap(top, oyuncu))
			oyuncuyaCarpma(top, oyuncu);
		else if (FlxG.overlap(top, oyuncu2))
			oyuncuyaCarpma(top, oyuncu2);
		

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

	public function oyuncuyaCarpma(buTop:Top, buOyuncu:Paddle):Void
	{
		// ilgili topun hızını ters çevirme fonksiyonunu çağır
		buTop.sekme(buOyuncu);
	}
}
