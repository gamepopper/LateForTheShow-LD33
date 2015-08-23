package;

import flixel.addons.text.FlxTypeText;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;

/**
 * ...
 * @author 
 */
class HowToPlayState extends FlxState
{
	var goal:FlxTypeText;
	var controls:FlxTypeText;
	
	var playGame:FlxTimer = new FlxTimer();
	var talkA:FlxSound = new FlxSound();
	
	override public function create():Void 
	{
		FlxG.camera.bgColor = FlxColor.BLACK;
		talkA.loadEmbedded("assets/sounds/talk.wav");
		
		goal = new FlxTypeText(5, 5, 150, "Okay, your costume is around here somewhere. Need to find the HEAD, BODY, HANDS, FEET and TAIL.", 8);
		goal.color = FlxColor.WHITE;
		goal.start(0.05, false, false, null, completeGoal);
		goal.sounds = [talkA];
		add(goal);
		
		controls = new FlxTypeText(5, 60, 150, "Move:\nW/A/S/D or ARROW KEYS\nCheck Under/Inside/On Stuff\nJ/K/L or Z/X/C", 8);
		controls.color = FlxColor.WHITE;
		controls.sounds = [talkA];
		add(controls);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
	function completeGoal()
	{
		controls.start(0.05, false, false, null, completeControls);
	}
	
	function completeControls()
	{
		playGame.start(3, NextPage, 1);
	}
	
	function NextPage(timer:FlxTimer)
	{
		FlxG.switchState(new PlayState());
	}
}