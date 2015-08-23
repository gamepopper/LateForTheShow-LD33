package;

import flixel.addons.text.FlxTypeText;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class CutsceneState extends FlxState
{
	var cutscene:FlxSprite = new FlxSprite();
	var text:FlxTypeText;
	
	var sceneTimer:FlxTimer = new FlxTimer();
	var scene:Int = 0;
	
	var dial:FlxSound = new FlxSound();
	var talkA:FlxSound = new FlxSound();
	var talkB:FlxSound = new FlxSound();
	
	override public function create():Void 
	{
		cutscene.loadGraphic("assets/images/Cutscene.png");
		add(cutscene);
		
		text = new FlxTypeText(5, 5, 150, "", 8);
		text.showCursor = true;
		text.cursorCharacter = "_";
		add(text);
		
		dial.loadEmbedded("assets/sounds/dial.wav", true);
		talkA.loadEmbedded("assets/sounds/talk.wav");
		talkB.loadEmbedded("assets/sounds/talk1.wav");
		
		sceneTimer.start(2, NextScene, 1);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (text.text == "You: OH @!#&$")
		{
			FlxG.camera.shake(0.05, 1, NextState);
		}
		
		super.update(elapsed);
	}
	
	function NextScene(timer:FlxTimer)
	{
		scene++;
		
		if (scene == 1)
		{
			dial.play();
			sceneTimer.start(3, NextScene, 1);
		}
		else if (scene == 2)
		{
			dial.stop();
			text.sounds = [talkA];
			text.prefix = "You: ";
			text.resetText("Hello?");
			text.start(0.05, true, false, null, EndSpeech);
		}
		else if (scene == 3)
		{
			text.sounds = [talkB];
			text.prefix = "Friend: ";
			text.resetText("Hey! Where are you? The show is about to start in 15 minutes. Have you been sleeping?!");
			text.start(0.05, true, false, null, EndSpeech);
		}
		else if (scene == 4)
		{
			text.sounds = [talkA];
			text.prefix = "You: ";
			text.resetText("What show?");
			text.start(0.05, true, false, null, EndSpeech);
		}
		else if (scene == 5)
		{
			text.sounds = [talkB];
			text.prefix = "Friend: ";
			text.resetText("Umm...the huge theatre show you've been preparing for months? The one where you play the monster?");
			text.start(0.05, true, false, null, EndSpeech);
		}
		else if (scene == 6)
		{
			text.sounds = [talkA];
			text.prefix = "You: ";
			text.resetText("....");
			text.start(0.8, true, false, null, EndSpeech);
		}
		else if (scene == 7)
		{
			text.prefix = "You: ";
			text.resetText("OH @!#&$!!!!!!!!!!!!!!!!!");
			text.start(0.04, true, false, null, EndSpeech);
		}
	}
	
	function EndSpeech()
	{
		sceneTimer.start(3, NextScene, 1);
	}
	
	function NextState()
	{
		FlxG.switchState(new MenuState());
	}
}