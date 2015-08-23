package;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import Reg;
/**
 * ...
 * @author 
 */
class CostumeProgess extends FlxSprite
{
	private var head:FlxSprite = new FlxSprite();
	private var body:FlxSprite = new FlxSprite();
	private var hand:FlxSprite = new FlxSprite();
	private var feet:FlxSprite = new FlxSprite();
	private var tail:FlxSprite = new FlxSprite();
	private var group:FlxSpriteGroup = new FlxSpriteGroup();
	
	public function new(state:FlxState) 
	{
		super(0, 0);
		loadGraphic("assets/images/PersonSmall.png");
		head.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "Small_Head.png");
		head.visible = false;
		group.add(head);
		body.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "Small_Body.png");
		body.visible = false;
		group.add(body);
		hand.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "Small_Hands.png");
		hand.visible = false;
		group.add(hand);
		feet.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "Small_Feet.png");
		feet.visible = false;
		group.add(feet);
		tail.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "Small_Tail.png");
		tail.visible = false;
		group.add(tail);
		
		state.add(this);
		state.add(group);
	}
	
	override public function update(elapsed:Float):Void 
	{
		head.visible = Reg.GotHead;
		body.visible = Reg.GotBody;
		hand.visible = Reg.GotHands;
		feet.visible = Reg.GotFeet;
		tail.visible = Reg.GotTail;
		
		group.setPosition(x, y);
		
		super.update(elapsed);
	}
}