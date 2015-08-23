package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Room
{
	var roomBarriers:FlxSpriteGroup = new FlxSpriteGroup();
	var bg:FlxSprite = new FlxSprite();
	var bed:FlxSprite = new FlxSprite();
	var box:FlxSprite = new FlxSprite();
	var shelf:FlxSprite = new FlxSprite();
	var cupboard:FlxSprite = new FlxSprite();
	var desk:FlxSprite = new FlxSprite();
	var bags:FlxSprite = new FlxSprite();
	
	var text:FlxText = new FlxText(0, 0, FlxG.width, "");
	
	var player:FlxSprite;
	
	var showGotItem:Bool = false;
	var revertTimer:FlxTimer = new FlxTimer();
	
	public function new(player:FlxSprite, group:FlxSpriteGroup, state:FlxState) 
	{
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
		state.add(roomBarriers);
		
		bg.loadGraphic("assets/images/Room.png");
		state.add(bg);
		
		bed.loadGraphic("assets/images/Bed.png");
		bed.setPosition(76, 21);
		bed.solid = true;
		bed.immovable = true;
		group.add(bed);
		
		box.loadGraphic("assets/images/Box.png");
		box.setPosition(20, 26);
		box.solid = true;
		box.immovable = true;
		group.add(box);
		
		shelf.loadGraphic("assets/images/Shelf.png");
		shelf.setPosition(138, 64);
		shelf.solid = true;
		shelf.immovable = true;
		group.add(shelf);
		
		cupboard.loadGraphic("assets/images/Cupboard.png");
		cupboard.setPosition(20, 60);
		cupboard.solid = true;
		cupboard.immovable = true;
		cupboard.width = 12;
		cupboard.height = 31;
		cupboard.offset.set(12, 33);
		group.add(cupboard);
		
		desk.loadGraphic("assets/images/Desk.png");
		desk.setPosition(109, 75);
		desk.solid = true;
		desk.immovable = true;
		desk.height = 26;
		desk.offset.y = 4;
		group.add(desk);
		
		bags.loadGraphic("assets/images/Bags.png");
		bags.setPosition(20, 100);
		bags.solid = true;
		bags.immovable = true;
		bags.height = 16;
		bags.offset.y = 5;
		group.add(bags);
		
		text.color = FlxColor.BLACK;
		text.alignment = "center";
		state.add(text);
		
		this.player = player;
	}
	
	public function update(elapsed:Float)
	{
		if (!showGotItem)
		{
			text.text = "";
		}
		
		FlxG.collide(player, roomBarriers);
		
		if (FlxG.collide(player, bed))
		{
			if (!showGotItem)
			{
				text.text = "CHECK BED";
				
				if (FlxG.keys.anyPressed(["Z", "J"]))
				{
					
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
			}
		}
		
		if (FlxG.collide(player, bed))
		{
			if (!showGotItem)
			{
				text.text = "CHECK BED";
				
				if (FlxG.keys.anyPressed(["Z", "J"]))
				{
					
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
			}
		}
		
		if (FlxG.collide(player, shelf))
		{
			if (!showGotItem)
			{
				text.text = "CHECK SHELF";
				
				if (FlxG.keys.anyPressed(["Z", "J"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					
				}
			}
		}
		
		if (FlxG.collide(player, cupboard))
		{
			if (!showGotItem)
			{
				text.text = "CHECK CUPBOARD";
				
				if (FlxG.keys.anyPressed(["Z", "J"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					
				}
			}
		}
		
		if (FlxG.collide(player, desk))
		{
			if (!showGotItem)
			{
				text.text = "CHECK DESK";
				
				if (FlxG.keys.anyPressed(["Z", "J"]))
				{
					
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
			}
		}
		
		if (FlxG.collide(player, bags))
		{
			if (!showGotItem)
			{
				text.text = "CHECK BAGS";
				
				if (FlxG.keys.anyPressed(["Z", "J"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					text.text = "NOTHING HERE";
					showGotItem = true;
					revertTimer.start(0.75, RevertToNormal, 1);
				}
			}
		}
	}
	
	function RevertToNormal(timer:FlxTimer)
	{
		showGotItem = false;
	}
}