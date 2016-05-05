package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;

class MenuDurumu extends FlxState
{
	private var logo  : FlxSprite = new FlxSprite();
	private var oyna  : FlxButton;
	private var kapat : FlxButton;
	private var yapan : FlxText;

	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = FlxColor.GREEN;

		Sys.println("DEBUG: MenuDurumu durumuna geçildi.");

		logo.loadGraphic("assets/images/pisti.png");
		logo.setPosition((FlxG.width / 2) - logo.width, 
						 (FlxG.height / 2) - (logo.height / 2));
		add(logo);

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

		yapan = new FlxText(0, FlxG.height - 100, 0, "(c) 2016 - IO", 24);
		yapan.alignment = FlxTextAlign.CENTER;
		yapan.screenCenter(FlxAxes.X);
		add(yapan);
	}

	override public function update(gecenZaman : Float) : Void
	{
		super.update(gecenZaman);
	}
}
