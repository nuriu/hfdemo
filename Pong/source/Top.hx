package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Top extends FlxSprite
{
	private var carpilanPaddle:Paddle;

    public function new(x:Float, y:Float, renk:FlxColor)
    {
        super(x, y);

        makeGraphic(30, 30, FlxColor.BLACK);
        FlxSpriteUtil.drawCircle(this, 15, 15, 15, renk);
        setSize(30, 30);

        this.velocity.x = 200;
        this.velocity.y = -200;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // yukarıya veya aşağıya çarpmasını sağla
        if (this.y < 0 || this.y + this.height > FlxG.stage.stageHeight)
        	this.velocity.y *= -1;

        // yanlardan çıkması durumunda oyunu yeniden başlat
        if (this.x + this.width < 0 || this.x > FlxG.stage.stageWidth)
        	FlxG.switchState(new MenuDurumu());
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
    	}
    }
}