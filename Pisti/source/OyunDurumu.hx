package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import haxe.ds.GenericStack;

class OyunDurumu extends FlxState
{
	public static inline var EN 	: 	Int = 140;
	public static inline var BOY 	: 	Int = 190;
	public static var ortaYigin 	: 	Array<Kart> = new Array<Kart>();
	public static var sonKazanan;
	public static var kazananOyuncu :	Oyuncu;

	public var ortaX 				: 	Float = FlxG.width / 2;
	public var ortaY 				: 	Float = FlxG.height / 2;

	private var deste 				: 	Deste;
	private var oyuncular 			: 	Array<Oyuncu> = new Array<Oyuncu>();
	private var oyunEli 			: 	Int = 0;

	override public function create():Void
	{
		//FlxG.debugger.visible = true;
		super.create();

		Sys.println("\nDEBUG: OyunDurumu durumuna geçildi.");

		deste = new Deste();

		// oyuncuları oluşturma
		var yz1 	: Oyuncu = new Oyuncu(1); oyuncular.push(yz1);
		var yz2 	: Oyuncu = new Oyuncu(2); oyuncular.push(yz2);
		var yz3 	: Oyuncu = new Oyuncu(3); oyuncular.push(yz3);
		var oyuncu 	: Oyuncu = new Oyuncu(4); oyuncular.push(oyuncu);

		// kart dağıtma işlemleri
		ortayaKartDagit();
		kartDagit();

		// debug bilgileri yazdırma işlemleri
		oyuncuElleriniYazdir();
		ortadakiKartlariYazdir();

		// çizdirme işlemleri
		ortadakiSonKartiCiz();
		YZoyuncuKartlariniCiz();
		oyuncununEliniCiz();

		oyunEli = 1;
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);

		// oyuncunun kart oynama durumu
		if (FlxG.mouse.justReleased)
		{
			for (i in 0 ... oyuncular[3].El.length) 
			{
				if (oyuncular[3].El[i] != null) 
				{
					if ((FlxG.mouse.x > oyuncular[3].El[i].x && FlxG.mouse.x < oyuncular[3].El[i].x + EN) && 
						(FlxG.mouse.y > oyuncular[3].El[i].y && FlxG.mouse.y < oyuncular[3].El[i].y + BOY)) 
					{
						oyuncular[3].KartiOyna(i);

						for (i in 0 ... 3)
							oyuncular[i].YZKartOyna();

						ortadakiSonKartiCiz();
					}
					else 
						continue;
				}
			}
		}

		// oyuncunun kartlarının bitmesi durumu
		if (oyuncular[3].El.length < 1 || oyuncular[3].El == null)
		{
			oyunEli++;

			Sys.println("\nDEBUG: Yeni El İçin Kartlar Dağıtıldı!");
			Sys.println("\nDEBUG: EL: " + oyunEli);
			Sys.println("\nDEBUG: Son Kazanan Oyuncu: " + OyunDurumu.sonKazanan);

			kartDagit();
			oyuncununEliniCiz();

			oyuncuElleriniYazdir();
			OyunDurumu.ortadakiKartlariYazdir();
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
		if (deste.karisikDeste.isEmpty())
		{
			// ortada kart kaldı ise kartları son kazanan alır
			if (ortaYigin.length > 0)
				oyuncular[sonKazanan - 1].KartlariTopla();

			oyuncuToplananKartlariYazdir();
			oyuncuPuanlariniHesapla();
			FlxG.switchState(new BitmeDurumu());
		}
		else
		{
			for (i in 0 ... oyuncular.length)
			{
				for (j in 0 ... 4)
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

		for (i in 0 ... 4)
			oyuncular[i].EliYazdir();

		Sys.println("");
	}

	public function oyuncuToplananKartlariYazdir() : Void
	{
		for (i in 0 ... 4)
		{
			oyuncular[i].ToplananKartlariYazdir();	
		}
	}

	private function YZoyuncuKartlariniCiz() : Void
	{ // TODO: iyileştirme yap ve kartları yz oyunculara ata

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
		if (oyuncular[3].El.length > 0)
		{
			for (i in 0 ... oyuncular[3].El.length) 
			{
				oyuncular[3].El[i].setPosition((ortaX - (EN*2)) + EN * i, FlxG.height - BOY - 20);
				add(oyuncular[3].El[i]);
			}
		}
	}

	private function ortadakiSonKartiCiz() : Void
	{
		if (ortaYigin.length > 0)
		{
			ortaYigin[ortaYigin.length - 1].setPosition(ortaX - (ortaYigin[ortaYigin.length - 1].width / 2),
														ortaY - (ortaYigin[ortaYigin.length - 1].height / 2));
			add(ortaYigin[ortaYigin.length - 1]);
		}
	}

	public static function ortadakiKartlariYazdir() : Void 
	{
		if (ortaYigin.length > 0)
		{
			Sys.println("");
			Sys.println("|-------------------|");
			Sys.println("| Ortadaki Kartlar: |");
			Sys.println("| Kart Sayısı: " + ortaYigin.length + "\t|");
			Sys.println("|-------------------|");

			for (i in 0 ... ortaYigin.length)
				Sys.println("| " + ortaYigin[i].tur + ": \t" + ortaYigin[i].deger + "\t\t|");

			Sys.println("|-------------------|");
			Sys.println("");	
		}
		else
		{
			Sys.println("");
			Sys.println("|-------------------|");
			Sys.println("|--Ortada Kart Yok--|");
			Sys.println("|-------------------|");
			Sys.println("");
		}
	}

	public function oyuncuPuanlariniHesapla() : Void
	{
		var enCokKart : Int = 0;
		var enCokKartaSahipOyuncu : Int = 0;

		for (i in 0 ... oyuncular.length)
		{
			oyuncular[i].PuanHesapla();

			if (oyuncular[i].ToplananKartlar.length >= enCokKart)
				enCokKartaSahipOyuncu = i;
		}

		oyuncular[enCokKartaSahipOyuncu].Puan += 3;

		var enYuksekPuan : Int = 0;

		for (i in 0 ... oyuncular.length)
		{
			if (oyuncular[i].Puan >= enYuksekPuan)
			{
				enYuksekPuan = oyuncular[i].Puan;
				kazananOyuncu = oyuncular[i];
			}
		}
	}
}