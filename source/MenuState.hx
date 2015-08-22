package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxVector;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var bg:FlxSprite = new FlxSprite();
	var player:FlxSprite = new FlxSprite();
	var velocity:FlxVector = new FlxVector();
	
	var roomBarriers:FlxGroup = new FlxGroup();
	
	var progress:CostumeProgess;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		
		FlxG.camera.bgColor = FlxColor.WHITE;
		
		var leftWall:FlxSprite = new FlxSprite();
		leftWall.makeGraphic(18, 120, FlxColor.TRANSPARENT);
		leftWall.solid = true;
		leftWall.immovable = true;
		roomBarriers.add(leftWall);
		
		/*var rightWall:FlxSprite = new FlxSprite();
		rightWall.loadGraphicFromSprite(leftWall);
		rightWall.x = 142;
		rightWall.solid = true;
		rightWall.immovable = true;
		roomBarriers.add(rightWall);*/
		
		var topWall:FlxSprite = new FlxSprite();
		topWall.makeGraphic(160, 12, FlxColor.TRANSPARENT);
		topWall.solid = true;
		topWall.immovable = true;
		roomBarriers.add(topWall);
		
		var bottomWallA:FlxSprite = new FlxSprite();
		bottomWallA.makeGraphic(69, 5, FlxColor.TRANSPARENT);
		bottomWallA.y = 115;
		bottomWallA.solid = true;
		bottomWallA.immovable = true;
		roomBarriers.add(bottomWallA);
		
		var bottomWallB:FlxSprite = new FlxSprite();
		bottomWallB.loadGraphicFromSprite(bottomWallA);
		bottomWallB.x = 91;
		bottomWallB.y = 115;
		bottomWallB.solid = true;
		bottomWallB.immovable = true;
		roomBarriers.add(bottomWallB);
		add(roomBarriers);
		
		bg.loadGraphic("assets/images/Room.png");
		add(bg);
		
		player.loadGraphic("assets/images/Running.png", true, 16, 32);
		player.animation.add("running", [0, 1], 3, true);
		player.animation.play("running");
		player.setPositionUsingCenter(80, 60);
		player.solid = true;
		add(player);
		
		progress = new CostumeProgess(this);
		progress.setPosition(130, 0);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(player, roomBarriers);
		
		velocity.zero();
		if (FlxG.keys.anyPressed(["A", "LEFT"]))
		{
			velocity.x = -100;
		}
		if (FlxG.keys.anyPressed(["D", "RIGHT"]))
		{
			velocity.x = 100;
		}
		if (FlxG.keys.anyPressed(["W", "UP"]))
		{
			velocity.y = -100;
		}
		if (FlxG.keys.anyPressed(["S", "DOWN"]))
		{
			velocity.y = 100;
		}
		
		if (velocity.x != 0 || velocity.y != 0)
		{
			velocity.normalize();
		}
		
		player.velocity.x = velocity.x * 100;
		player.velocity.y = velocity.y * 100;
		
		if (player.x + player.width > 142)
		{
			player.x = 142 - player.width;
		}
		
		if (FlxG.keys.justPressed.ONE)
			Reg.GotHead = !Reg.GotHead;
		if (FlxG.keys.justPressed.TWO)
			Reg.GotBody = !Reg.GotBody;
		if (FlxG.keys.justPressed.THREE)
			Reg.GotHands = !Reg.GotHands;
		if (FlxG.keys.justPressed.FOUR)
			Reg.GotFeet = !Reg.GotFeet;
		if (FlxG.keys.justPressed.FIVE)
			Reg.GotTail = !Reg.GotTail;
	}
}
