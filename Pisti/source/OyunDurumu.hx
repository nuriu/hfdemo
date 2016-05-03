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

	private var deste : Deste;
	private var ortaYigin : GenericStack<Kart> = new GenericStack<Kart>();
	private var oyuncular : Array<Oyuncu> = new Array<Oyuncu>();

	override public function create():Void
	{
		//FlxG.debugger.visible = true;
		super.create();

		Sys.println("DEBUG: OyunDurumu durumuna geçildi.");

		deste = new Deste();

		var yz1 : YZOyuncu = new YZOyuncu(); oyuncular.push(yz1);
		var yz2 : YZOyuncu = new YZOyuncu(); oyuncular.push(yz2);
		var yz3 : YZOyuncu = new YZOyuncu(); oyuncular.push(yz3);
		var oyuncu : Oyuncu = new Oyuncu(); oyuncular.push(oyuncu);

		ortayaKartDagit();
		kartDagit();
		oyuncuElleriniYazdir();
		YZoyuncuKartlariniCiz();
		oyuncununEliniCiz();
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);
	}

	private function ortayaKartDagit() : Void
	{
		for (i in 0 ... 4) {
			ortaYigin.add(deste.karisikDeste.pop());
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
		Sys.println("|----------------");
		Sys.println("| Oyuncu Elleri:|");
		Sys.println("|----------------");
		for (i in 0 ... 4) {
			oyuncular[i].EliYazdir();
			Sys.println("|---------------|");
		}
	}

	private function YZoyuncuKartlariniCiz() : Void
	{ // TODO: not: dizi çalışmadı, iyileştirme yap

		var k = new Array<FlxSprite>();

		for (i in 1 ... 5) {
			k[i - 1] = new FlxSprite();
			k[i - 1].loadGraphic("assets/images/arkaMavi.png");
			k[i - 1].setPosition(25, 100 + ((k[i - 1].width / 2) * i));
			k[i - 1].angle = 90;
			add(k[i - 1]);
		}

		for (i in 5 ... 9) {
			k[i - 1] = new FlxSprite();
			k[i - 1].loadGraphic("assets/images/arkaKirmizi.png");
			k[i - 1].setPosition(175 + ((k[i - 1].height / 2) * (i / 1.5)), 15);
			add(k[i - 1]);
		}

		for (i in 9 ... 13) {
			k[i - 1] = new FlxSprite();
			k[i - 1].loadGraphic("assets/images/arkaYesil.png");
			k[i - 1].setPosition(FlxG.width - k[i - 1].height + 25, 100 + (k[i - 1].width / 2) * (i - 8));
			k[i - 1].angle = 90;
			add(k[i - 1]);
		}
	}

	private function oyuncununEliniCiz() : Void 
	{
		for (i in 0 ... oyuncular[3].El.length) {
			oyuncular[3].El[i].setPosition(480 + (oyuncular[3].El[i].width / 2) * i, FlxG.height - oyuncular[3].El[i].height);
			add(oyuncular[3].El[i]);
		}
	}
}