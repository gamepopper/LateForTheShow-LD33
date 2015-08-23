package;

import flixel.addons.text.FlxTypeText;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.FlxG;

import com.newgrounds.*;

enum Endings
{
	LATE;
	NOCOSTUME;
	MISSINGPARTS;
	COMPLETE;
}

class EndingState extends FlxState
{
	private var endingType:Endings = LATE;
	private var text:FlxTypeText;
	private var ending:FlxSprite = new FlxSprite(0, 8);
	
	private var person:FlxSprite = new FlxSprite();
	private var head:FlxSprite = new FlxSprite();
	private var body:FlxSprite = new FlxSprite();
	private var hand:FlxSprite = new FlxSprite();
	private var feet:FlxSprite = new FlxSprite();
	private var tail:FlxSprite = new FlxSprite();
	
	private var continued:Bool = false;
	var talkB:FlxSound = new FlxSound();
	
	public function new(endingType:Endings) 
	{
		super();
		
		this.endingType = endingType;
	}
	
	override public function create():Void 
	{
		ending.loadGraphic("assets/images/Ending.png", true, 160, 120);
		ending.animation.add("celebrate", [1, 2, 3, 4], 4, true);
		add(ending);
		
		person.loadGraphic("assets/images/Person.png");
		person.visible = endingType != LATE;
		person.setPositionUsingCenter(80);
		person.y = 100 - person.height;
		add(person);
		body.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "__Body.png");
		body.x = person.x;
		body.y = person.y;
		body.visible = Reg.GotBody && person.visible;
		add(body);
		feet.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "__Feet.png");
		feet.x = person.x;
		feet.y = person.y;
		feet.visible = Reg.GotFeet && person.visible;
		add(feet);
		hand.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "__Hands.png");
		hand.x = person.x;
		hand.y = person.y;
		hand.visible = Reg.GotHands && person.visible;
		add(hand);
		tail.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "__Tail.png");
		tail.x = person.x;
		tail.y = person.y;
		tail.visible = Reg.GotTail && person.visible;
		add(tail);
		head.loadGraphic("assets/images/Monsters/Monster" + Reg.ItemID + "__Head.png");
		head.x = person.x;
		head.y = person.y;
		head.visible = Reg.GotHead && person.visible;
		add(head);
		
		talkB.loadEmbedded("assets/sounds/talk1.wav");
		
		text = new FlxTypeText(0, 0, 160, "", 8);
		text.setTypingVariation(0.02, true);
		text.color = FlxColor.BLACK;
		text.sounds = [talkB];
		
		if (endingType == LATE)
		{
			text.resetText("YOU FAILED TO SHOW UP ON TIME, THE SHOW IS A DISASTER! GOOD JOB.");
			
			#if flash
			if (API.isNewgrounds)
				API.unlockMedal("No Show");
			#end
		}
		if (endingType == NOCOSTUME)
		{
			text.resetText("WHY DID YOU BOTHER GOING TO YOUR PERFORMANCE WITHOUT YOUR COSTUME?");
			
			#if flash
			if (API.isNewgrounds)
				API.unlockMedal("Going Full Monty");
			#end
		}
		if (endingType == MISSINGPARTS)
		{
			text.resetText("YOU THINK NO ONE WILL SEE SOMETHING IS MISSING, BUT THEY DO SEE...");
			
			#if flash
			if (API.isNewgrounds)
				API.unlockMedal("Ruining the Magic");
			#end
		}
		if (endingType == COMPLETE)
		{
			text.resetText("THANKS TO YOU, THE SHOW IS A BIG HIT! EVERYONE LOVED THE MONSTER!");
			ending.animation.play("celebrate");
			
			#if flash
			if (API.isNewgrounds)
				API.unlockMedal("Let the show begin!");
			#end
		}
		
		text.start(0.05, false, false, null, completeText);
		add(text);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (continued)
		{
			if (FlxG.keys.anyJustPressed(["ENTER", "SPACE", "W", "A", "S", "D", "J", "K", "L", "UP", "LEFT", "RIGHT", "DOWN"]))
			{
				FlxG.switchState(new MenuState());
			}
		}
		
		super.update(elapsed);
	}
	
	function completeText()
	{
		continued = true;
	}
}