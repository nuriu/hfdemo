package;

import flixel.FlxG;
import flixel.FlxSprite;

class YZOyuncu extends Oyuncu
{
	private function SkorHesapla() : Void
	{

	}

	public function KartOyna() : Void
	{
		var ortadakiKart : Kart = OyunDurumu.ortaYigin[OyunDurumu.ortaYigin.length - 1];

		// oyuncunun elini tara
		for (i in 0 ... El.length)
		{
			// pişti yapma durumu (ortada tek kart var ise)
			if (OyunDurumu.ortaYigin.length == 1)
			{
				if (ortadakiKart.deger == El[i].deger)
				{
					KartlariTopla();
					Puan += 10;
				}
			}
		}
	}
}