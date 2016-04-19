package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxAxes;

class MenuDurumu extends FlxState
{
	private var baslatTusu:FlxButton;
	private var cikisTusu:FlxButton;
	private var baslik:FlxText;
	private var yapan:FlxText;

	override public function create():Void
	{
		super.create();

		baslatTusu = new FlxButton(0, 0, "", function()
		{
			FlxG.switchState(new OyunDurumu());
		});

		baslatTusu.loadGraphic(AssetPaths.oyna__png, false);
		baslatTusu.x = FlxG.width / 2 - baslatTusu.width - 10;
		baslatTusu.y = FlxG.height / 2 - baslatTusu.height / 2;
		add(baslatTusu);

		#if desktop
		cikisTusu = new FlxButton(0, 0, "", function()
		{
			System.exit(0);
		});

		cikisTusu.loadGraphic(AssetPaths.cik__png, false);
		cikisTusu.x = FlxG.width / 2 + cikisTusu.width / 2 - 10;
		cikisTusu.y = FlxG.height / 2 - cikisTusu.height / 2;
		add(cikisTusu);
		#end

		baslik = new FlxText(0, 40, 0, "PONG", 48);
		baslik.alignment = FlxTextAlign.CENTER;
		baslik.screenCenter(FlxAxes.X);
		add(baslik);

		yapan = new FlxText(0, 440, 0, "(c) 2016 - IO", 12);
		yapan.alignment = FlxTextAlign.CENTER;
		yapan.screenCenter(FlxAxes.X);
		add(yapan);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
