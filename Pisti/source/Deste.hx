package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup;

import haxe.ds.GenericStack;

class Deste extends FlxSpriteGroup
{
	public var SINEK : Array<Kart> = new Array<Kart>();
	public var KARO : Array<Kart> = new Array<Kart>();
	public var KUPA : Array<Kart> = new Array<Kart>();
	public var MACA : Array<Kart> = new Array<Kart>();
	
	public var D : GenericStack<Kart> = new GenericStack<Kart>();

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

	private function sinekleriYukle() : Void
	{
        for (i in 1...14)
        {
        	// Sinekler için kartları oluştur
        	if (i == 1) // sinek as = 1 puan
        		this.SINEK[i] = new Kart("SINEK", i, 1);
        	else if (i == 2) // sinek 2 = 2 puan
        		this.SINEK[i] = new Kart("SINEK", i, 2);
        	else if (i == 11) // sinek vale = 1 puan
        		this.SINEK[i] = new Kart("SINEK", i, 1);
        	else // geri kalan kartlar = 0 puan
        		this.SINEK[i] = new Kart("SINEK", i, 0);

        	// ilgili resimleri yükle ve ana kart destesine ekle
        	this.SINEK[i].loadGraphic("assets/images/sinek/" + i + ".png");
        	this.deste.push(this.SINEK[i]);
        }
	}

	private function karolariYukle() : Void
	{
		for (i in 1...14)
		{
        	// Karolar için kartları oluştur
        	if (i == 1) // karo as = 1 puan
        		this.KARO[i] = new Kart("KARO", i, 1);
        	else if (i == 10) // karo 10 = 3 puan
        		this.KARO[i] = new Kart("KARO", i, 3);
        	else if (i == 11) // karo vale = 1 puan
        		this.KARO[i] = new Kart("KARO", i, 1);
        	else // geri kalan kartlar = 0 puan
        		this.KARO[i] = new Kart("KARO", i, 0);

			// ilgili resimleri yükle ve ana kart destesine ekle
			this.KARO[i].loadGraphic("assets/images/karo/" + i + ".png");
			this.deste.push(this.KARO[i]);
		}
	}

	private function kupalariYukle() : Void
	{
		for (i in 1...14)
		{
        	// Kupalar için kartları oluştur
        	if (i == 1) // kupa as = 1 puan
        		this.KUPA[i] = new Kart("KUPA", i, 1);
        	else if (i == 11) // kupa vale = 1 puan
        		this.KUPA[i] = new Kart("KUPA", i, 1);
        	else // geri kalan kartlar = 0 puan
        		this.KUPA[i] = new Kart("KUPA", i, 0);

			// ilgili resimleri yükle ve ana kart destesine ekle
			this.KUPA[i].loadGraphic("assets/images/kupa/" + i + ".png");
			this.deste.push(this.KUPA[i]);
		}
	}

	private function macalariYukle() : Void
	{
		for (i in 1...14)
		{
        	// Maçalar için kartları oluştur
        	if (i == 1) // maça as = 1 puan
        		this.MACA[i] = new Kart("MACA", i, 1);
        	else if (i == 11) // maça vale = 1 puan
        		this.MACA[i] = new Kart("MACA", i, 1);
        	else // geri kalan kartlar = 0 puan
        		this.MACA[i] = new Kart("MACA", i, 0);

			// ilgili resimleri yükle ve ana kart destesine ekle
			this.MACA[i].loadGraphic("assets/images/maca/" + i + ".png");
			this.deste.push(this.MACA[i]);
		}
	}

	private function kartCekilmisMi(indis : Int) : Bool
	{
		for (i in 0 ... this.cekilenKartIndisleri.length) {
			if (indis == this.cekilenKartIndisleri[i]) {
				return true;
			}
		}
		return false;
	}

	private function karisikDesteOlustur() : Void
	{
		var g;
		for (i in 0 ... this.deste.length) {
			g = FlxG.random.int(1, 53);
			if (!kartCekilmisMi(g)) {
				this.D.add(this.deste[g]);
			}
		}
	}
}