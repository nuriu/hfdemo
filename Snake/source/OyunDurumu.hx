package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxSpriteGroup;

class OyunDurumu extends FlxState
{
	private var skorMetni : FlxText;
	public static var skor : Int = 0;

	private var yilanBas : FlxSprite;
	private var yilanGovde : FlxSpriteGroup;

	private var toplanabilir : FlxSprite;

	private var basPozisyonlari : Array <FlxPoint>;
	
	private var hareketAraligi : Float = 8;

	private var simdikiYon = FlxObject.UP;
	private var sonrakiYon = FlxObject.UP;

	private static inline var KAREBOYUTU : Int = 8;
	private static inline var ARALIK : Float = 2;

	override public function create() : Void
	{
		super.create();

		// platform masaüstü (bilgisayar) ise fareyi gizle
		#if desktop
		FlxG.mouse.visible = false;
		#end

		// skor metni
		skorMetni = new FlxText(5, 5, 200, "Skor: " + skor);
		add(skorMetni);

		// ekranın ortasının koordinatları
		var ortaX:Int = Math.floor(FlxG.width / 2);
		var ortaY:Int = Math.floor(FlxG.height / 2);

		// yılanın başındaki kare
		yilanBas = new FlxSprite(ortaX - KAREBOYUTU * 2, ortaY);
		yilanBas.makeGraphic(KAREBOYUTU - 2, KAREBOYUTU - 2, FlxColor.LIME);
		offsetSprite(yilanBas);

		// baş karenin son pozisyonları
		basPozisyonlari = [FlxPoint.get(yilanBas.x, yilanBas.y)];

		// yılanın geri kalan gövdesi
		yilanGovde = new FlxSpriteGroup();
		add(yilanGovde);

		// bir gövde ekle ve hareket ettir
		govdeEkle();
		hareketEttir();

		// baş kareyi en son ekle en üstte olsun 
		add(yilanBas);

		// toplanabilir kareler
		toplanabilir = new FlxSprite();
		toplanabilir.makeGraphic(KAREBOYUTU - 2, KAREBOYUTU - 2, FlxColor.RED);
		rastgeleToplanabilirUret();
		offsetSprite(toplanabilir);
		add(toplanabilir);

		// hareket zamanlayıcısını sıfırla
		zamanlayiciyiSifirla();
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);

		// skor metni için geçiş efekti
		if (skorMetni.alpha < 1)
		{
			skorMetni.alpha += 0.01;
		}

		// yılan kontrolleri
		if (FlxG.keys.anyPressed([W, UP]) && simdikiYon != FlxObject.DOWN) 
		{
			sonrakiYon = FlxObject.UP;
		}
		else if (FlxG.keys.anyPressed([S, DOWN]) && simdikiYon != FlxObject.UP) 
		{
			sonrakiYon = FlxObject.DOWN;
		}
		else if (FlxG.keys.anyPressed([A, LEFT]) && simdikiYon != FlxObject.RIGHT) 
		{
			sonrakiYon = FlxObject.LEFT;
		}
		else if (FlxG.keys.anyPressed([D, RIGHT]) && simdikiYon != FlxObject.LEFT) 
		{
			sonrakiYon = FlxObject.RIGHT;
		}
	}

	private function metniGuncelle(YeniMetin : String) : Void
	{
		skorMetni.text = YeniMetin;
		skorMetni.alpha = 0;
	}

	private function offsetSprite(Sprite : FlxSprite) : Void
	{
		Sprite.offset.set(1, 1);
		Sprite.centerOffsets();
	}

	private function govdeEkle() : Void
	{
		var kare : FlxSprite = new FlxSprite(-20, -20);
		kare.makeGraphic(KAREBOYUTU - 2, KAREBOYUTU - 2, FlxColor.WHITE);
		yilanGovde.add(kare);
	}

	private function hareketEttir() : Void
	{
		basPozisyonlari.unshift(FlxPoint.get(yilanBas.x, yilanBas.y));

		// gövde parçalarından çok baş pozisyonu tutuluyorsa eksilt
		if (basPozisyonlari.length > yilanGovde.members.length)
		{
			basPozisyonlari.pop();
		}

		// toplanabilir ile temasta ilgili fonksiyon çağrılacak
		FlxG.overlap(yilanBas, toplanabilir, toplanabiliriTopla);
		// kendine çarpması durumunda oyunu bitir
		FlxG.overlap(yilanBas, yilanGovde, oyunuBitir);

		// baş karenin yönünü ayarla
		switch (sonrakiYon)
		{
			case FlxObject.LEFT: yilanBas.x -= KAREBOYUTU;
			case FlxObject.RIGHT: yilanBas.x += KAREBOYUTU;
			case FlxObject.UP: yilanBas.y -= KAREBOYUTU;
			case FlxObject.DOWN: yilanBas.y += KAREBOYUTU;
		}

		simdikiYon = sonrakiYon;

		FlxSpriteUtil.screenWrap(yilanBas);

		for (i in 0...basPozisyonlari.length)
		{
			yilanGovde.members[i].setPosition(basPozisyonlari[i].x, basPozisyonlari[i].y);
		}
	}

	private function zamanlayiciyiSifirla(?Zamanlayici : FlxTimer) : Void
	{
		if (!yilanBas.alive && Zamanlayici != null)
		{
			Zamanlayici.destroy();
			return;
		}

		new FlxTimer().start(hareketAraligi / FlxG.updateFramerate, zamanlayiciyiSifirla);
		hareketEttir();
	}

	private function rastgeleToplanabilirUret(?Object1:FlxObject, ?Object2:FlxObject) : Void
	{
		// toplanabilir öğeyi rastgele konuma taşı
		toplanabilir.x = FlxG.random.int(0, Math.floor(FlxG.width / 8) - 1) * 8;
		toplanabilir.y = FlxG.random.int(0, Math.floor(FlxG.height / 8) - 1) * 8;

		// üretilen koordinatların halihazırda yılanın bulunduğu yerde olmamasını sağla
		FlxG.overlap(toplanabilir, yilanGovde, rastgeleToplanabilirUret);
	}

	private function toplanabiliriTopla(?Object1:FlxObject, ?Object2:FlxObject) : Void
	{
		// skor puanı ver ve metni güncelle
		skor += 8;
		metniGuncelle("Skor: " + skor);

		// toplanabilir öğeyi yeni bir konuma taşı
		rastgeleToplanabilirUret();

		// yılana yeni gövde parçası ekle
		govdeEkle();

		// hızlandır
		if (hareketAraligi >= ARALIK)
		{
			hareketAraligi -= 0.25;
		}
	}

	private function oyunuBitir(?Object1:FlxObject, ?Object2:FlxObject) : Void
	{
		FlxG.switchState(new YenilmeDurumu());
	}
}
