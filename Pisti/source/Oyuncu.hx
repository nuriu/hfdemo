package;

import flixel.FlxG;

class Oyuncu {
	public var El : Array<Kart> = new Array<Kart>();

	public function new()
    {
        Sys.println("DEBUG: Bir oyuncu oluşturuldu.");
    }

	public function update(gecenZaman : Float) : Void
	{
	}

	public function EliYazdir() : Void 
	{
		for (i in 0 ... this.El.length) {
			Sys.println("| " + El[i].tur + ": " + El[i].deger);
		}
	}
}