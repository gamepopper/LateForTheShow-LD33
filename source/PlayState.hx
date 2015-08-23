package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var room:Room;
	var player:Player;
	var objectGroup:FlxSpriteGroup = new FlxSpriteGroup();
	var progress:CostumeProgess;
	
	var time:Int = 15;
	var text:FlxText;
	var countdown:FlxTimer = new FlxTimer();
	
	var random:FlxRandom = new FlxRandom();
	
	private var head:FlxSprite = new FlxSprite();
	private var body:FlxSprite = new FlxSprite();
	private var hand:FlxSprite = new FlxSprite();
	private var feet:FlxSprite = new FlxSprite();
	private var tail:FlxSprite = new FlxSprite();
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = FlxColor.WHITE;
		
		Reg.GotBody = false;
		Reg.GotFeet = false;
		Reg.GotHands = false;
		Reg.GotHead = false;
		Reg.GotTail = false;
		Reg.ItemCount = 0;
		
		room = new Room(player, objectGroup, this);
		player = new Player();
		objectGroup.add(player);
		add(objectGroup);
		
		progress = new CostumeProgess(this);
		progress.setPosition(130, 0);
		
		head.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Head.png");
		head.offset.y = -5;
		add(head);
		PlaceCostume("head", head);
		body.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Body.png");
		body.offset.y = 5;
		add(body);
		PlaceCostume("body", body);
		hand.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Hands.png");
		hand.offset.y = -1;
		add(hand);
		PlaceCostume("hands", hand);
		feet.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Feet.png");
		feet.offset.y = 8;
		add(feet);
		PlaceCostume("feet", feet);
		tail.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Tail.png");
		tail.offset.y = 5;
		add(tail);
		PlaceCostume("tail", tail);
		
		text = new FlxText(5, 0, FlxG.width, Std.string(time));
		text.color = FlxColor.BLACK;
		add(text);
		
		countdown.start(1, CountdownHit, 1);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (player.y > 120)
		{
			FlxG.switchState(new EndingState(Reg.ItemCount == 0 ? NOCOSTUME : 
				Reg.ItemCount < 5 ? MISSINGPARTS : COMPLETE));
		}
		
		room.update(elapsed);
		objectGroup.sort(FlxSort.byY);
	}
	
	function PlaceCostume(name:String, sprite:FlxSprite)
	{
		var hidingID:Int = 0;
		
		while (room.hidingAreas[(hidingID = random.int(0, 8))].name != "") { }
		
		room.hidingAreas[hidingID].name = name;
		sprite.setPositionUsingCenter(
			room.hidingAreas[hidingID].position.x, 
			room.hidingAreas[hidingID].position.y);
		sprite.visible = room.hidingAreas[hidingID].visible;
		room.hidingAreas[hidingID].sprite = sprite;
	}
	
	function CountdownHit(timer:FlxTimer)
	{
		time--;
		
		if (time > 0)
		{
			text.text = Std.string(time);
			countdown.start(1, CountdownHit, 1);
		}
		else
		{
			FlxG.switchState(new EndingState(LATE));
		}
	}
}
