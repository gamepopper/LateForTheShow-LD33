package;

import flixel.FlxSprite;
import flixel.math.FlxVector;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class Player extends FlxSprite
{
	private var v:FlxVector = new FlxVector();
	
	public function new() 
	{
		super(0,0);
		loadGraphic("assets/images/Running.png", true, 16, 32);
		animation.add("running", [0, 1], 3, true);
		animation.play("running");
		setPosition(125, 60);
		solid = true;
		width = 7;
		height = 8;
		offset.x = 16 - 12;
		offset.y = 32 - 8;
	}
	
	override public function update(elapsed:Float):Void 
	{
		v.zero();
		if (FlxG.keys.anyPressed(["A", "LEFT"]))
		{
			v.x = -100;
		}
		if (FlxG.keys.anyPressed(["D", "RIGHT"]))
		{
			v.x = 100;
		}
		if (FlxG.keys.anyPressed(["W", "UP"]))
		{
			v.y = -100;
		}
		if (FlxG.keys.anyPressed(["S", "DOWN"]))
		{
			v.y = 100;
		}
		
		if (v.x != 0 || v.y != 0)
		{
			v.normalize();
		}
		
		velocity.x = v.x * 100;
		velocity.y = v.y * 100;
		
		super.update(elapsed);
	}
}