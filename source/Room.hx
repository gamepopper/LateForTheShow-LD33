package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class HidingSpot
{
	public var name:String = "";
	public var position:FlxPoint = new FlxPoint();
	public var visible:Bool = false;
	public var sprite:FlxSprite = null;
	
	public function new(){}
	
	public function SetPosition(pos:FlxPoint):Void
	{
		position = pos;
		visible = true;
	}
}

class Room
{
	private var roomBarriers:FlxSpriteGroup = new FlxSpriteGroup();
	private var bg:FlxSprite = new FlxSprite();
	private var bed:FlxSprite = new FlxSprite();
	private var box:FlxSprite = new FlxSprite();
	private var shelf:FlxSprite = new FlxSprite();
	private var cupboard:FlxSprite = new FlxSprite();
	private var desk:FlxSprite = new FlxSprite();
	private var bags:FlxSprite = new FlxSprite();
	
	private var text:FlxText = new FlxText(0, 0, FlxG.width, "");
	
	private var player:FlxSprite;
	
	private var showGotItem:Bool = false;
	private var revertTimer:FlxTimer = new FlxTimer();
	
	public var hidingAreas:Array<HidingSpot> = new Array<HidingSpot>();
	
	public function new(player:FlxSprite, group:FlxSpriteGroup, state:FlxState) 
	{
		for (i in 0...9)
		{
			hidingAreas.push(new HidingSpot());
		}
		
		hidingAreas[1].SetPosition(new FlxPoint(151, 100)); 	//On Shelf
		hidingAreas[3].SetPosition(new FlxPoint(15, 50)); 	//On Cupboard
		hidingAreas[5].SetPosition(new FlxPoint(134, 75)); 	//On Desk
		hidingAreas[8].SetPosition(new FlxPoint(28, 30));		//On Boxes
		
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
					CheckItem(hidingAreas[0]);
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					NothingHere();
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					NothingHere();
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
					NothingHere();
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					NothingHere();
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					CheckItem(hidingAreas[1]);
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
					NothingHere();
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					CheckItem(hidingAreas[2]);
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					CheckItem(hidingAreas[3]);
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
					CheckItem(hidingAreas[4]);
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					NothingHere();
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					CheckItem(hidingAreas[5]);
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
					NothingHere();
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					CheckItem(hidingAreas[6]);
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					NothingHere();
				}
			}
		}
		
		if (FlxG.collide(player, box))
		{
			if (!showGotItem)
			{
				text.text = "CHECK BOXES";
				
				if (FlxG.keys.anyPressed(["Z", "J"]))
				{
					NothingHere();
				}
				if (FlxG.keys.anyPressed(["X", "K"]))
				{
					CheckItem(hidingAreas[7]);
				}
				if (FlxG.keys.anyPressed(["C", "L"]))
				{
					CheckItem(hidingAreas[8]);
				}
			}
		}
	}
	
	function RevertToNormal(timer:FlxTimer)
	{
		showGotItem = false;
	}
	
	function CheckItem(area:HidingSpot)
	{
		if (area.name != "")
		{
			if (area.name == "head")
			{
				Reg.GotHead = true;
			}
			if (area.name == "body")
			{
				Reg.GotBody = true;
			}
			if (area.name == "hands")
			{
				Reg.GotHands = true;
			}
			if (area.name == "feet")
			{
				Reg.GotFeet = true;
			}
			if (area.name == "tail")
			{
				Reg.GotTail = true;
			}
			
			Reg.ItemCount++;
			area.visible = false;
			area.sprite.visible = false;
			
			text.text = area.name.toUpperCase() + " FOUND";
			showGotItem = true;
			revertTimer.start(0.75, RevertToNormal, 1);
		}
		else
		{
			NothingHere();
		}
	}
	
	function NothingHere()
	{
		text.text = "NOTHING HERE";
		showGotItem = true;
		revertTimer.start(0.75, RevertToNormal, 1);
	}
}