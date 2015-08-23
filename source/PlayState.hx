package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.util.FlxColor;
import flixel.util.FlxSort;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var room:Room;
	var player:Player;
	var objectGroup:FlxSpriteGroup = new FlxSpriteGroup();
	var progress:CostumeProgess;
	
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
		
		FlxG.debugger.drawDebug = true;
		
		FlxG.camera.bgColor = FlxColor.WHITE;
		
		room = new Room(player, objectGroup, this);
		player = new Player();
		objectGroup.add(player);
		add(objectGroup);
		
		progress = new CostumeProgess(this);
		progress.setPosition(130, 0);
		
		head.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Head.png");
		add(head);
		PlaceCostume("head", head);
		body.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Body.png");
		add(body);
		PlaceCostume("body", body);
		hand.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Hands.png");
		add(hand);
		PlaceCostume("hands", hand);
		feet.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Feet.png");
		add(feet);
		PlaceCostume("feet", feet);
		tail.loadGraphic("assets/images/Monsters/Monster" + 1 + "Small_Tail.png");
		add(tail);
		PlaceCostume("tail", tail);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
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
}
