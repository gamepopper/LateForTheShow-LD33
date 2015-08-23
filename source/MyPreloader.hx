package ;

import flixel.system.FlxBasePreloader;
import flixel.FlxG;
import flixel.text.FlxText;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.Lib;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;

import com.newgrounds.*;
import com.newgrounds.components.*;

@:font("assets/data/ADORE64.ttf") class CustomFont extends Font {}

class MyPreloader extends FlxBasePreloader
{
	private var text:TextField;
	
	#if flash
	public function new(MinDisplayTime:Float=0, ?AllowedURLs:Array<String>) 
	{
		super(MinDisplayTime, AllowedURLs);
	}
	
	override function create():Void 
	{
		var stageWidth = Lib.current.stage.stageWidth;
		var stageHeight = Lib.current.stage.stageHeight;
		
		var ratio:Float = stageWidth / 160;
		
		Font.registerFont(CustomFont);
		text = new TextField();
		text.defaultTextFormat = new TextFormat("Adore64", 24, 0xFFFFFFFF, false, false, false, "", "", TextFormatAlign.CENTER);
		text.embedFonts = true;
		text.selectable = false;
		text.multiline = false;
		text.x = 0;
		text.y = stageHeight - 30;
		text.width = stageWidth;
		text.height = stageHeight;
		addChild(text);
		
		API.connect(root, "41723:UZz4bw5F", "X8jevkX4auxvrxRLT2yiXTmWb3T6tPZ9");
		
		if (API.isNewgrounds)
		{
			var ad:FlashAd = new FlashAd();
			ad.x = (stageWidth / 2) - (ad.width/2);
			ad.y = (stageWidth / 3) - (ad.height/2);
			addChild(ad);
			minDisplayTime = 8;
		}
		
		super.create();
	}
	
	override function update(Percent:Float):Void 
	{
		text.text = "Loading";
		
		for (i in 0...(Std.int(Percent * 10) % 4))
		{
			text.text += ".";
		}
		
		super.update(Percent);
	}
	#end
}