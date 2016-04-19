package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import flixel.util.FlxSpriteUtil;

class Top extends FlxSprite
{
	private var carpilanPaddle:Paddle;
	private var carpmaSesi:FlxSound;

    public function new(x:Float, y:Float, renk:FlxColor)
    {
        super(x, y);

        makeGraphic(30, 30, FlxColor.BLACK);
        FlxSpriteUtil.drawCircle(this, 15, 15, 15, renk);
        setSize(30, 30);

        // varsayılan top hızı
        this.velocity.x = 200;
        this.velocity.y = -200;

        carpmaSesi = FlxG.sound.load(AssetPaths.carpma__wav);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // yukarıya veya aşağıya çarpmasını sağla
        if (this.y < 0 || this.y + this.height > FlxG.stage.stageHeight)
        {
        	this.velocity.y *= -1;
        	carpmaSesi.play();
        }

        // yanlardan çıkması durumunda skoru arttır ve oyunu yeniden başlat
        if (this.x + this.width < 0)
        {
        	OyunDurumu.oyuncu2Skor += 1;
        	FlxG.switchState(new OyunDurumu());
        }

        if(this.x > FlxG.stage.stageWidth)
        {
        	OyunDurumu.oyuncuSkor += 1;
        	FlxG.switchState(new OyunDurumu());
        }
    }

    public function sekme(paddle:Paddle):Void
    {
    	// bir öncekinden farklı bir oyuncuya çarptığında
    	if (carpilanPaddle != paddle)
    	{
    		// yatayda hızını ters çevir
    		this.velocity.x *= -1;
    		// aynı oyuncuya aynı anda birden fazla kez çarpmasını engellemek için
    		// çarptığı oyuncuyu referans olarak tut.
    		carpilanPaddle = paddle;
    		// çarpma sesini çal
    		carpmaSesi.play();
    	}
    }
}