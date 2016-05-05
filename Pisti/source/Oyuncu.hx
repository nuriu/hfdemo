package;

import flixel.FlxG;

class Oyuncu 
{
	public var El : Array<Kart> = new Array<Kart>();
	public var ToplananKartlar : Array<Kart> = new Array<Kart>();
	public var Puan : Int = 0;

	public function new()
    {
        Sys.println("DEBUG: Bir oyuncu oluşturuldu.");
    }

	public function update(gecenZaman : Float) : Void
	{
	}

	public function EliYazdir() : Void 
	{
		for (i in 0 ... El.length) {
			Sys.println("| " + El[i].tur + ": \t" + El[i].deger + "\t|");
		}
	}

	public function KartiOyna(i : Int) : Void
	{
		Sys.println("DEBUG: " + El[i].tur + " " + El[i].deger + " kartı oynandı.");
		var ortadakiKart : Kart = OyunDurumu.ortaYigin[OyunDurumu.ortaYigin.length - 1];

		// oynanan kartı ortaya taşı
		El[i].setPosition((FlxG.width / 2) - (El[i].width / 2),
						  (FlxG.height / 2) - (El[i].height / 2));

		if (OyunDurumu.ortaYigin.length > 0) // ortada kart varsa
		{
			OyunDurumu.ortaYigin[OyunDurumu.ortaYigin.length - 1].destroy();

			if (ortadakiKart.deger == El[i].deger || El[i].deger == 11) 	// aynı kartı veya valeyi oynadıysa
			{					
				if (OyunDurumu.ortaYigin.length == 1 && El[i].deger == 11)	// vale ile pişti yaparsa
					Puan += 20;
				else if (OyunDurumu.ortaYigin.length == 1)					// normal pişti yaparsa
					Puan += 10;

				OyunDurumu.ortaYigin.push(El[i]);
				El[i].destroy();
				El.remove(El[i]);

				KartlariTopla();											// ortadaki kartları topla
			}
			else
			{
				OyunDurumu.ortaYigin.push(El[i]);
				El.remove(El[i]);
			}
		}
		else // ortada kart yoksa
		{
			OyunDurumu.ortaYigin.push(El[i]);
			El.remove(El[i]);
		}

		// DEBUG
		EliYazdir();
		OyunDurumu.ortakiKartlariYazdir(); 
	}

	private function KartlariTopla() : Void
	{
		for (i in 0 ... OyunDurumu.ortaYigin.length)
		{
			ToplananKartlar.push(OyunDurumu.ortaYigin.pop());	
		}
	}
}