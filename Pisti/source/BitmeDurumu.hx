package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxAxes;

class BitmeDurumu extends FlxState
{
	private var oyna  	: FlxButton;
	private var kapat 	: FlxButton;
	private var baslik 	: FlxText;
	private var yapan 	: FlxText;
	private var kazanan : FlxText;
	private var puan 	: FlxText;

	override public function create():Void
	{
		super.create();
		Sys.println("DEBUG: BitmeDurumu durumuna geçildi.");

		oyna = new FlxButton(0,0,null, function()
										{
											FlxG.switchState(new OyunDurumu());
										});

		oyna.setPosition((FlxG.width / 2) + (oyna.width * 2.5),
						 (FlxG.height / 2) - (oyna.height * 3));
		oyna.loadGraphic("assets/images/oyna.png");
		add(oyna);

		#if desktop
		kapat = new FlxButton(0,0,null, function()
										{
											System.exit(0);
										});

		kapat.setPosition((FlxG.width / 2) + (kapat.width * 2.5),
						  (FlxG.height / 2) + (kapat.height * 1.5));
		kapat.loadGraphic("assets/images/kapat.png");
		add(kapat);
		#end

		baslik = new FlxText(0, FlxG.height / 4, 0, "Oyun Bitti!", 24);
		baslik.alignment = FlxTextAlign.CENTER;
		baslik.screenCenter(FlxAxes.X);
		add(baslik);

		yapan = new FlxText(0, FlxG.height - 100, 0, "(c) 2016 - IO", 24);
		yapan.alignment = FlxTextAlign.CENTER;
		yapan.screenCenter(FlxAxes.X);
		add(yapan);

		kazanan = new FlxText(FlxG.width / 6, FlxG.height / 2.25, 0, "Kazanan Oyuncu : " + OyunDurumu.kazananOyuncu.KIMLIK, 24);
		add(kazanan);
		
		puan = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, "Oyuncu Puanı : " + OyunDurumu.kazananOyuncu.Puan, 24);
		add(puan);
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);
	}
}