package com.tro.findingrudolf.views.components
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Flake extends Sprite
	{
		private var snowing:Boolean = false;
		
		private static var _snowTexture:Texture;
		private var flake:Image;
		
		private var flakeScale:Number;
		private var windTweenX:Tween;
		private var windTweenY:Tween;
		
		private var startX:int;
		private const XDropSpeed:Number = (Math.random() * 5) - 2.5;
		private var YDropSpeed:Number = Math.random() * 80 + 16;
		
		private var YPosition:Number;
		private var XPosition:Number;
		private var flakeHeight:int;
		
		private var leftThreshold:int;
		private var rightThreshold:int;
		
		private var delayTimer:Timer;
		private var dropDelay:Number;
		
		private static var windClaimed:Boolean = false;
		private var windClaimedByMe:Boolean = false;
		private static var windPoint:Point = new Point(0, 0);
		
		public function Flake(scale:Number = -1)
		{
			super();
			
			if (scale == -1)
			{
				flakeScale = Math.random();
			}
			else
			{
				flakeScale = scale;
			}
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			dropDelay = (60000 * flakeScale) + (Math.random() * 20000);
			delayTimer = new Timer(dropDelay, 1);
			touchable = false;
			
			flake = new Image(snowTexture);
			flake.scale = flakeScale;
			addChild(flake);
			var flakeWidth:Number = flake.width * 0.5;
			flake.pivotX = flakeWidth;
			flakeHeight = Math.ceil(flake.height);
			flake.alpha = 1 - flakeScale;
			
			YDropSpeed *= flakeScale;
			
			leftThreshold = -int(Math.ceil(flakeWidth));
			rightThreshold = int(stage.stageWidth + Math.ceil(flakeWidth));
			
			reset();
			
			if (!windClaimed)
			{
				windClaimed = true;
				windClaimedByMe = true;
			}
		}
		
		public function startSnowing():void
		{
			snowing = true;
			
			if (windClaimedByMe)
			{
				windXGo();
				windYGo();
			}
			
			if (!delayTimer.hasEventListener(TimerEvent.TIMER_COMPLETE))
			{
				delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, delayTimerComplete);
			}
			
			delayTimer.reset();
			delayTimer.start();
		}
		
		public function stopSnowing():void
		{
			snowing = false;
			
			if (delayTimer.hasEventListener(TimerEvent.TIMER_COMPLETE))
			{
				delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, delayTimerComplete);
			}
			
			delayTimer.reset();
			
			if (windClaimedByMe)
			{
				windStop();
			}
		}
		
		private function delayTimerComplete(e:TimerEvent):void
		{
			dropIt();
		}
		
		private function dropIt():void
		{
			visible = true;
			
			if (!hasEventListener(EnterFrameEvent.ENTER_FRAME))
			{
				addEventListener(EnterFrameEvent.ENTER_FRAME, tick);
			}
		}
		
		private function tick(e:EnterFrameEvent):void
		{
			var frameYAmount:Number = YDropSpeed;
			var frameXAmount:Number = XDropSpeed;
			
			frameYAmount += windPoint.y * flakeScale;
			YPosition += frameYAmount;
			
			frameXAmount += windPoint.x * flakeScale;
			XPosition += frameXAmount;
			
			if (YPosition > stage.stageHeight)
			{
				reset();
			}
			else
			{
				flake.y = YPosition;
				flake.x = XPosition;
			}
			
			if (flake.x > leftThreshold && flake.x < rightThreshold)
			{
				flake.visible = true;
			} else {
				flake.visible = false;
			}
		}
		
		private function windXGo():void
		{
			Starling.juggler.remove(windTweenX);
			windTweenX = new Tween(windPoint, (Math.random() * 5) + 1, Transitions.EASE_IN_OUT);
			windTweenX.animate("x", (Math.random() * 20) - 10);
			windTweenX.reverse = true;
			windTweenX.repeatCount = 2;
			windTweenX.onComplete = windXGo;
			
			Starling.juggler.add(windTweenX);
		}
		
		private function windYGo():void
		{
			Starling.juggler.remove(windTweenY);
			windTweenY = new Tween(windPoint, (Math.random() * 5) + 1, Transitions.EASE_IN_OUT);
			windTweenY.animate("y", (Math.random() * 10) - 5);
			windTweenY.reverse = true;
			windTweenY.repeatCount = 2;
			windTweenY.onComplete = windYGo;
			
			Starling.juggler.add(windTweenY);
		}
		
		private function windStop():void
		{
			Starling.juggler.removeTweens(windPoint);
			var tween:Tween = new Tween(windPoint, 3, Transitions.EASE_IN_OUT);
			tween.moveTo(0, 0);
			Starling.juggler.add(tween);
		}
		
		private function reset():void
		{
			if (hasEventListener(EnterFrameEvent.ENTER_FRAME))
			{
				removeEventListener(EnterFrameEvent.ENTER_FRAME, tick);
			}
			
			if (snowing)
			{
				startSnowing();
			}			
			
			visible = false;
			XPosition = randomX();
			flake.x = XPosition;
			YPosition = -flakeHeight;
			flake.y = YPosition;
		}
		
		private function randomX():int
		{
			return int((Math.random() * (stage.stageWidth * 2)) - (stage.stageWidth * 0.5));
		}
		
		public static function get snowTexture():Texture 
		{
			return _snowTexture;
		}
		
		public static function set snowTexture(value:Texture):void 
		{
			_snowTexture = value;
		}
	}
}