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
	var room:Room;
	
	var player:Player;
	
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
		
		room = new Room(player, objectGroup, this);
		player = new Player();
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
		
		room.update(elapsed);
		
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
