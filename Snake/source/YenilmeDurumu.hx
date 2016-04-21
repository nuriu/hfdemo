package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxAxes;

class YenilmeDurumu extends FlxState 
{
	private var YenidenBaslatTusu : FlxButton;
	private var cikisTusu : FlxButton;
	private var baslik : FlxText;
	private var skorMetni : FlxText;
	private var yapan : FlxText;

	override public function create() : Void
	{
		super.create();

		// platform masaüstü (bilgisayar) ise fareyi gizle
		#if desktop
		FlxG.mouse.visible = true;
		#end

		YenidenBaslatTusu = new FlxButton(0, 0, "Yeniden Baslat", function() 
		{
			FlxG.switchState(new OyunDurumu());
		});

		YenidenBaslatTusu.x = FlxG.width / 2 - YenidenBaslatTusu.width - 35;
		YenidenBaslatTusu.y = FlxG.height / 2 - YenidenBaslatTusu.height / 2;

		add(YenidenBaslatTusu);

		#if desktop
		cikisTusu = new FlxButton(0, 0, "Cik", function()
		{
			System.exit(0);
		});

		cikisTusu.x = FlxG.width / 2 + cikisTusu.width / 2 - 10;
		cikisTusu.y = FlxG.height / 2 - cikisTusu.height / 2;
		add(cikisTusu);
		#end


		baslik = new FlxText(0, 40, 0, "Oyun Bitti!", 48);
		baslik.alignment = FlxTextAlign.CENTER;
		baslik.screenCenter(FlxAxes.X);
		add(baslik);

		skorMetni = new FlxText(0, 150, 0, "Skorunuz: " + OyunDurumu.skor, 32);
		skorMetni.alignment = FlxTextAlign.CENTER;
		skorMetni.screenCenter(FlxAxes.X);
		add(skorMetni);

		yapan = new FlxText(0, 440, 0, "(c) 2016 - IO", 12);
		yapan.alignment = FlxTextAlign.CENTER;
		yapan.screenCenter(FlxAxes.X);
		add(yapan);
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);
	}
}