package;

import flixel.addons.effects.FlxGlitchSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

/**
 * ...
 * @author 
 */
class LogoState extends FlxState
{
	var sprite:FlxSprite = new FlxSprite();
	var logo:FlxGlitchSprite;
	var strength:Float = 80;
	var goIn:Bool = true;
	var timer:FlxTimer = new FlxTimer();
	
	override public function create():Void 
	{
		sprite.loadGraphic("assets/images/gp.png");
		sprite.setPositionUsingCenter(80, 60);
		logo = new FlxGlitchSprite(sprite, 100, 1, 0.05, FlxGlitchDirection.HORIZONTAL);
		add(logo);
		
		FlxG.mouse.useSystemCursor = true;
		FlxG.stage.quality = flash.display.StageQuality.LOW;
		FlxG.camera.antialiasing = false;
		
		timer.start(3, stateCallback, 1);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (goIn)
		{
			strength -= elapsed * 50;
		}
		else
		{
			strength += elapsed * 100;
		}
		
		logo.strength = strength >= 0 ? Std.int(strength) : 0;
	}
	
	function stateCallback(timer:FlxTimer)
	{
		if (goIn)
		{
			goIn = false;
			timer.start(3, stateCallback, 1);
		}
		else
		{
			FlxG.switchState(new CutsceneState());
		}
	}
}