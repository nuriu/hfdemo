package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup;

import haxe.ds.GenericStack;

class Deste extends FlxSpriteGroup
{
	public var karisikDeste : GenericStack<Kart> = new GenericStack<Kart>();

	private var geciciKart : Kart;
	private var deste : Array<Kart> = new Array<Kart>();
	private var cekilenKartIndisleri : Array<Int> = new Array<Int>();

	public function new()
    {
        super();
        
        sinekleriYukle();
        karolariYukle();
        kupalariYukle();
        macalariYukle();

        karisikDesteOlustur();

        Sys.println("DEBUG: Bir deste oluşturuldu.");
    }

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);
	}

	// TODO: yükleme fonksiyonlarını birleştir
	private function sinekleriYukle() : Void
	{
        for (i in 0...13)
        {
        													// Sinekler için kartları oluştur
        	if (i + 1 == 1) 								// sinek as = 1 puan
        		geciciKart = new Kart("SINEK", i + 1, 1);
        	else if (i + 1 == 2) 							// sinek 2 = 2 puan
        		geciciKart = new Kart("SINEK", i + 1, 2);
        	else if (i + 1 == 11) 							// sinek vale = 1 puan
        		geciciKart = new Kart("SINEK", i + 1, 1);
        	else 											// geri kalan kartlar = 0 puan
        		geciciKart = new Kart("SINEK", i + 1, 0);

        	// ilgili resimleri yükle ve ana desteye ekle
        	geciciKart.loadGraphic("assets/images/sinek/" + (i + 1) + ".png");
        	deste.push(geciciKart);
        }
	}

	private function karolariYukle() : Void
	{
		for (i in 0...13)
		{
        													// Karolar için kartları oluştur
        	if (i + 1 == 1) 								// karo as = 1 puan
        		geciciKart = new Kart("KARO", i + 1, 1);
        	else if (i + 1 == 10) 							// karo 10 = 3 puan
        		geciciKart = new Kart("KARO", i + 1, 3);
        	else if (i + 1 == 11) 							// karo vale = 1 puan
        		geciciKart = new Kart("KARO", i + 1, 1);
        	else 											// geri kalan kartlar = 0 puan
        		geciciKart = new Kart("KARO", i + 1, 0);

			// ilgili resimleri yükle ve ana desteye ekle
			geciciKart.loadGraphic("assets/images/karo/" + (i + 1) + ".png");
			deste.push(geciciKart);
		}
	}

	private function kupalariYukle() : Void
	{
		for (i in 0...13)
		{
        													// Kupalar için kartları oluştur
        	if (i + 1 == 1) 								// kupa as = 1 puan
        		geciciKart = new Kart("KUPA", i + 1, 1);
        	else if (i + 1 == 11) 							// kupa vale = 1 puan
        		geciciKart = new Kart("KUPA", i + 1, 1);
        	else 											// geri kalan kartlar = 0 puan
        		geciciKart = new Kart("KUPA", i + 1, 0);

			// ilgili resimleri yükle ve ana desteye ekle
			geciciKart.loadGraphic("assets/images/kupa/" + (i + 1) + ".png");
			this.deste.push(geciciKart);
		}
	}

	private function macalariYukle() : Void
	{
		for (i in 0...13)
		{
        													// Maçalar için kartları oluştur
        	if (i + 1 == 1) 								// maça as = 1 puan
        		geciciKart = new Kart("MACA", i + 1, 1);
        	else if (i + 1 == 11) 							// maça vale = 1 puan
        		geciciKart = new Kart("MACA", i + 1, 1);
        	else 											// geri kalan kartlar = 0 puan
        		geciciKart = new Kart("MACA", i + 1, 0);

			// ilgili resimleri yükle ve ana desteye ekle
			geciciKart.loadGraphic("assets/images/maca/" + (i + 1) + ".png");
			this.deste.push(geciciKart);
		}
	}

	private function kartCekilmisMi(indis : Int) : Bool
	{
		for (i in 0 ... cekilenKartIndisleri.length) {
			if (indis == cekilenKartIndisleri[i]) {
				return true;
			}
		}
		return false;
	}

	private function karisikDesteOlustur() : Void
	{
		var g;
		
		for (i in 0 ... deste.length) {			// deste bitene kadar
			g = FlxG.random.int(0, 51); 		// rastgele bir indis üret

			while (kartCekilmisMi(g) == true)	// indisteki kart daha önce çekilmiş ise
			{
				g = FlxG.random.int(0, 51); 	// rastgele bir indis üretmeye devam et
			}
			cekilenKartIndisleri.push(g); 		// indisi çekilenlere ekle
			karisikDeste.add(this.deste[g]); 	// çekilen kartı karışık desteye ekle
		}
	}
}