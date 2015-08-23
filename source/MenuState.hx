package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var start:FlxText;
	var lyserdigi:FlxText;
	
	var logo:FlxSprite = new FlxSprite();
	
	var flash:FlxTimer = new FlxTimer();
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		FlxG.debugger.drawDebug = true;
		FlxG.camera.bgColor = FlxColor.WHITE;
		
		start = new FlxText(0, 80, FlxG.width, "SPACE/ENTER to START", 8);
		start.color = FlxColor.BLACK;
		start.alignment = "center";
		add(start);
		
		lyserdigi = new FlxText(0, 105, FlxG.width, "Music by Lyserdigi", 8);
		lyserdigi.color = FlxColor.BLACK;
		lyserdigi.alignment = "right";
		add(lyserdigi);
		
		logo.loadGraphic("assets/images/logo.png");
		logo.setPositionUsingCenter(80, 40);
		add(logo);
		
		flash.start(0.5, flashCallback, 0);
		
		super.create();
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
		if (FlxG.keys.anyJustPressed(["SPACE", "ENTER"]))
		{
			FlxG.switchState(new HowToPlayState());
		}
		
		super.update(elapsed);
	}
	
	function flashCallback(timer:FlxTimer)
	{
		start.visible = !start.visible;
	}
}
