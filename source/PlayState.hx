package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.util.FlxColor;
import flixel.util.FlxSort;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var roomBarriers:FlxSpriteGroup = new FlxSpriteGroup();
	var bg:FlxSprite = new FlxSprite();
	var bed:FlxSprite = new FlxSprite();
	var box:FlxSprite = new FlxSprite();
	var shelf:FlxSprite = new FlxSprite();
	var cupboard:FlxSprite = new FlxSprite();
	var desk:FlxSprite = new FlxSprite();
	var bags:FlxSprite = new FlxSprite();
	
	var player:FlxSprite = new FlxSprite();
	var velocity:FlxVector = new FlxVector();
	
	var objectGroup:FlxSpriteGroup = new FlxSpriteGroup();
	
	var progress:CostumeProgess;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		
		FlxG.debugger.drawDebug = true;
		
		FlxG.camera.bgColor = FlxColor.WHITE;
		
		var leftWall:FlxSprite = new FlxSprite();
		leftWall.makeGraphic(21, 120, FlxColor.TRANSPARENT);
		leftWall.solid = true;
		leftWall.immovable = true;
		roomBarriers.add(leftWall);
		
		var rightWall:FlxSprite = new FlxSprite();
		rightWall.loadGraphicFromSprite(leftWall);
		rightWall.x = FlxG.width - rightWall.width;
		rightWall.solid = true;
		rightWall.immovable = true;
		roomBarriers.add(rightWall);
		
		var topWall:FlxSprite = new FlxSprite();
		topWall.makeGraphic(160, 30, FlxColor.TRANSPARENT);
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
		
		bed.loadGraphic("assets/images/Bed.png");
		bed.setPosition(76, 21);
		bed.solid = true;
		bed.immovable = true;
		objectGroup.add(bed);
		
		box.loadGraphic("assets/images/Box.png");
		box.setPosition(20, 26);
		box.solid = true;
		box.immovable = true;
		objectGroup.add(box);
		
		shelf.loadGraphic("assets/images/Shelf.png");
		shelf.setPosition(139, 64);
		shelf.solid = true;
		shelf.immovable = true;
		objectGroup.add(shelf);
		
		cupboard.loadGraphic("assets/images/Cupboard.png");
		cupboard.setPosition(20, 60);
		cupboard.solid = true;
		cupboard.immovable = true;
		cupboard.width = 12;
		cupboard.height = 31;
		cupboard.offset.set(12, 33);
		objectGroup.add(cupboard);
		
		desk.loadGraphic("assets/images/Desk.png");
		desk.setPosition(109, 75);
		desk.solid = true;
		desk.immovable = true;
		desk.height = 26;
		desk.offset.y = 4;
		objectGroup.add(desk);
		
		bags.loadGraphic("assets/images/Bags.png");
		bags.setPosition(20, 100);
		bags.solid = true;
		bags.immovable = true;
		bags.height = 16;
		bags.offset.y = 5;
		objectGroup.add(bags);
		
		player.loadGraphic("assets/images/Running.png", true, 16, 32);
		player.animation.add("running", [0, 1], 3, true);
		player.animation.play("running");
		player.setPosition(125, 60);
		player.solid = true;
		player.width = 7;
		player.height = 8;
		player.offset.x = 16 - 12;
		player.offset.y = 32 - 8;
		objectGroup.add(player);
		
		add(objectGroup);
		
		progress = new CostumeProgess(this);
		progress.setPosition(130, 0);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(player, roomBarriers);
		FlxG.collide(player, bed);
		FlxG.collide(player, box);
		FlxG.collide(player, cupboard);
		FlxG.collide(player, desk);
		FlxG.collide(player, bags);
		
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
			
		objectGroup.sort(FlxSort.byY);
	}
}
