package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import haxe.ds.GenericStack;

class OyunDurumu extends FlxState
{
	public static inline var EN : Int = 140;
	public static inline var BOY : Int = 190;

	public var ortaX : Float = FlxG.width / 2;
	public var ortaY : Float = FlxG.height / 2;

	private var deste : Deste;
	private var ortaYigin : Array<Kart> = new Array<Kart>();
	private var oyuncular : Array<Oyuncu> = new Array<Oyuncu>();

	override public function create():Void
	{
		//FlxG.debugger.visible = true;
		super.create();

		FlxG.camera.bgColor = FlxColor.GREEN;

		Sys.println("\nDEBUG: OyunDurumu durumuna geçildi.");

		deste = new Deste();

		var yz1 : YZOyuncu = new YZOyuncu(); oyuncular.push(yz1);
		var yz2 : YZOyuncu = new YZOyuncu(); oyuncular.push(yz2);
		var yz3 : YZOyuncu = new YZOyuncu(); oyuncular.push(yz3);
		var oyuncu : Oyuncu = new Oyuncu(); oyuncular.push(oyuncu);

		ortayaKartDagit();
		kartDagit();

		oyuncuElleriniYazdir();
		ortakiKartlariYazdir();

		ortadakiSonKartiCiz();
		YZoyuncuKartlariniCiz();
		oyuncununEliniCiz();
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);

		if (FlxG.mouse.justReleased) {
			for (i in 0 ... oyuncular[3].El.length) 
			{
				if (oyuncular[3].El[i] != null) 
				{
					if ((FlxG.mouse.x > oyuncular[3].El[i].x && FlxG.mouse.x < oyuncular[3].El[i].x + EN) && 
						(FlxG.mouse.y > oyuncular[3].El[i].y && FlxG.mouse.y < oyuncular[3].El[i].y + BOY)) 
					{
						Sys.println("DEBUG: " + oyuncular[3].El[i].tur + " " + oyuncular[3].El[i].deger + " kartı oynandı.");

						ortaYigin[ortaYigin.length - 1].destroy();
						oyuncular[3].El[i].setPosition(ortaYigin[ortaYigin.length - 1].x,
													   ortaYigin[ortaYigin.length - 1].y);

						ortaYigin.push(oyuncular[3].El[i]);
						oyuncular[3].El.remove(oyuncular[3].El[i]);

						// DEBUG
						oyuncular[3].EliYazdir();
						ortakiKartlariYazdir(); 
					} else 
						continue;
				}
			}
		}
	}

	private function ortayaKartDagit() : Void
	{
		for (i in 0 ... 4) {
			ortaYigin.push(deste.karisikDeste.pop());
		}
	}

	private function kartDagit() : Void 
	{
		for (i in 0 ... oyuncular.length) {
			for (j in 0 ... 4) {
				// TODO: deste bittiyse oyunu bitir.
				oyuncular[i].El.push(deste.karisikDeste.pop());
			}
		}
	}

	private function oyuncuElleriniYazdir() : Void
	{
		Sys.println("");
		Sys.println("|---------------|");
		Sys.println("| Oyuncu Elleri:|");
		Sys.println("|---------------|");
		for (i in 0 ... 4) {
			oyuncular[i].EliYazdir();
			Sys.println("|---------------|");
		}
		Sys.println("");
	}

	private function YZoyuncuKartlariniCiz() : Void
	{ // TODO: iyileştirme yap (iç içe döngü denenebilir)

		var k = new Array<FlxSprite>();

		for (i in 1 ... 5) {
			k[i - 1] = new FlxSprite();
			k[i - 1].loadGraphic("assets/images/arkaMavi.png");
			k[i - 1].setPosition(40, 100 + ((EN / 2) * i));
			k[i - 1].angle = 90;
			add(k[i - 1]);
		}

		for (i in 5 ... 9) {
			k[i - 1] = new FlxSprite();
			k[i - 1].loadGraphic("assets/images/arkaKirmizi.png");
			k[i - 1].setPosition(175 + ((BOY / 2) * (i / 1.5)), 15);
			add(k[i - 1]);
		}

		for (i in 9 ... 13) {
			k[i - 1] = new FlxSprite();
			k[i - 1].loadGraphic("assets/images/arkaYesil.png");
			k[i - 1].setPosition(FlxG.width - BOY + 10, 100 + (EN / 2) * (i - 8));
			k[i - 1].angle = 90;
			add(k[i - 1]);
		}
	}

	private function oyuncununEliniCiz() : Void 
	{
		for (i in 0 ... oyuncular[3].El.length) {
			oyuncular[3].El[i].setPosition((ortaX - (EN*2)) + EN * i, FlxG.height - BOY - 20);
			add(oyuncular[3].El[i]);
		}
	}

	private function ortadakiSonKartiCiz() : Void
	{
		ortaYigin[ortaYigin.length - 1].setPosition(ortaX - (ortaYigin[ortaYigin.length - 1].width / 2),
													ortaY - (ortaYigin[ortaYigin.length - 1].height / 2));
		add(ortaYigin[ortaYigin.length - 1]);
	}

	private function ortakiKartlariYazdir() : Void 
	{
		Sys.println("");
		Sys.println("|-------------------|");
		Sys.println("| Ortadaki Kartlar: |");
		Sys.println("|-------------------|");
		for (i in 0 ... ortaYigin.length) {
			Sys.println("| " + ortaYigin[i].tur + ": \t" + ortaYigin[i].deger + "\t\t|");
		}
		Sys.println("|-------------------|");
		Sys.println("");
	}
}