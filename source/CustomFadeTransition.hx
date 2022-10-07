package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;

class CustomFadeTransition extends MusicBeatSubstate
{
	public static var finishCallback:Void->Void;
	
	private var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	var isTransIn:Bool = false;

	var rows:Int = 15;
	var columns:Int = 27;

	public function new(duration:Float, isTransIn:Bool)
	{
		super();

		this.isTransIn = isTransIn;
		var zoom:Float = CoolUtil.boundTo(FlxG.camera.zoom, 0.05, 1);
		if (nextCamera != null) zoom = CoolUtil.boundTo(nextCamera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);

		for (i in 0...rows)
		{
			var yPos:Float = height * (i / rows);
			for (j in 0...columns)
			{
				var xPos:Float = width * (j / columns);
				var square = new FlxSprite(xPos-2, yPos-2).makeGraphic(Std.int(width/columns-1)+4, Std.int(height/rows-1)+4, FlxColor.BLACK);
				square.scrollFactor.set();

				var tweenDuration:Float = duration/(columns/2);
				var startDelay:Float = duration-tweenDuration;
				startDelay -= tweenDuration*j;

				var delA = duration/(rows/2);
				var delB = duration-delA;
				delB -= delA*i;
				if (delB < 0) delB = -delB;
				if (startDelay < 0) startDelay = -startDelay;
				startDelay += delB;

				startDelay /= 4;

				if (isTransIn)
				{
					FlxTween.tween(square.scale, {x: 0, y: 0}, tweenDuration*7, {ease: FlxEase.expoIn, startDelay: startDelay,
					onComplete: function(twn:FlxTween)
					{
						remove(square);
						square.destroy();
					}});
				}
				else
				{
					square.scale.x = 0;
					square.scale.y = 0;
					FlxTween.tween(square.scale, {x: 1, y: 1}, tweenDuration*7, {ease: FlxEase.expoOut, startDelay: startDelay});
				}

				if(nextCamera != null)
				{
					square.cameras = [nextCamera];
				}
				add(square);
			}
		}

		new FlxTimer().start(duration, function(tm:FlxTimer)
		{
			if (isTransIn) close();
			else 
			{
				if(finishCallback != null)
					finishCallback();
			}
		}, 1);
		nextCamera = null;
	}

	/*
	override function update(elapsed:Float) {
		if(isTransIn) {
			transBlack.y = transGradient.y + transGradient.height;
		} else {
			transBlack.y = transGradient.y - transBlack.height;
		}
		super.update(elapsed);
		if(isTransIn) {
			transBlack.y = transGradient.y + transGradient.height;
		} else {
			transBlack.y = transGradient.y - transBlack.height;
		}
	}*/

	override function destroy() {
		if(leTween != null) {
			finishCallback();
			leTween.cancel();
		}
		super.destroy();
	}
}