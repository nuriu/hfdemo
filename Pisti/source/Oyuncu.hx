package;

import flixel.FlxG;

class Oyuncu 
{
	public var KIMLIK : Int;

	public var El : Array<Kart> = new Array<Kart>();
	public var ToplananKartlar : Array<Kart> = new Array<Kart>();
	public var Puan : Int = 0;

	public function new(kimlik : Int)
    {
    	this.KIMLIK = kimlik;
        Sys.println("DEBUG: Bir oyuncu oluşturuldu.");
    }

	public function update(gecenZaman : Float) : Void
	{
	}

	public function EliYazdir() : Void 
	{
		Sys.println("| Oyuncu: " + KIMLIK + " \t|");
		Sys.println("| Kart Sayısı: " + El.length + "|");
		Sys.println("|---------------|");
		for (i in 0 ... El.length)
			Sys.println("| " + El[i].tur + ": \t" + El[i].deger + "\t|");
		Sys.println("|---------------|");
	}

	public function ToplananKartlariYazdir() : Void
	{
		Sys.println("");
		Sys.println("|-------------------|");
		Sys.println("| Toplanan Kartlar: |");
		Sys.println("|-------------------|");
		Sys.println("| Oyuncu: " + KIMLIK + "\t\t\t|");
		Sys.println("| Kart Sayısı: " + ToplananKartlar.length + "\t|");
		Sys.println("|-------------------|");
		
		for (i in 0 ... ToplananKartlar.length)
			Sys.println("| " + ToplananKartlar[i].tur + ": \t" + ToplananKartlar[i].deger + "\t\t|");

		Sys.println("|-------------------|");
		Sys.println("");
	}

	public function KartiOyna(i : Int) : Void
	{
		Sys.println("DEBUG: " + KIMLIK + ". Oyuncu " + El[i].tur + " " + El[i].deger + " kartını oynandı.");
		Sys.println("");
		Sys.println("|---------------|");
		Sys.println("| Kalan Kartlar:|");
		Sys.println("|---------------|");
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
		OyunDurumu.ortadakiKartlariYazdir(); 
	}

	public function KartlariTopla() : Void
	{
		for (i in 0 ... OyunDurumu.ortaYigin.length)
		{
			ToplananKartlar.push(OyunDurumu.ortaYigin.pop());	
		}

		OyunDurumu.sonKazanan = this.KIMLIK;
	}

	public function YZKartOyna() : Void
	{
		if (OyunDurumu.ortaYigin.length > 0) 			// ortada kart var ise
		{
			var ortadakiKart : Kart = OyunDurumu.ortaYigin[OyunDurumu.ortaYigin.length - 1];

			// oyuncunun elini tara
			for (i in 0 ... El.length)
			{
				if (ortadakiKart.deger == El[i].deger)	// aynı karttan var ise oyna
				{
					KartiOyna(i);
					break;
				}
				else									// aynı karttan yoksa rastgele kart oyna
				{
					var g = FlxG.random.int(0, 3);		// rastgele indis üret

					while (El[g] == null)				// o indisteki kart oynandıysa tekrar indis üret
						g = FlxG.random.int(0, 3);

					KartiOyna(g);
					break;
				}
			}
		}
		else											// ortada kart yok ise
		{
			var g = FlxG.random.int(0, 3);				// rastgele indis üret

			while (El[g] == null)						// o indisteki kart oynandıysa tekrar indis üret
				g = FlxG.random.int(0, 3);

			KartiOyna(g);
		}
		
	}

	public function PuanHesapla() : Void
	{
		if (ToplananKartlar.length > 0)
		{
			for (i in 0 ... ToplananKartlar.length)
				Puan += ToplananKartlar[i].puanDegeri;
		}
		else
			Puan = 0;
	}
}