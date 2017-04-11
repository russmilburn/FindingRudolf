package com.tro.findingrudolf.views.components 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class Star extends Sprite 
	{
		private var star:Image;
		private var starSparkle:Image;
		private var sparkleTimer:Timer;
		private var sparkleInterval:Number = 0;
		private var minimumInterval:int = 5;
		
		private var firstAnimation:Boolean = true;
		
		private var currentScale:Number;
		
		public function Star() 
		{
			super();
		}
		
		public function setTimer():void
		{
			/*sparkleTimer = new Timer(getSparkleInterval(), 1);
			sparkleTimer.addEventListener(TimerEvent.TIMER_COMPLETE, handleSparkle);
			sparkleTimer.start();*/
			
			Starling.juggler.delayCall(sparkleIn, getSparkleInterval());
		}
		
		public function startTimer():void
		{
			sparkleTimer.start();
		}
		
		private function destroyTimer():void
		{
			sparkleTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleSparkle);
			sparkleTimer = null;
		}
		
		private function handleSparkle(event:TimerEvent):void 
		{
			sparkleIn();
			destroyTimer();
			setTimer();
		}
		
		private function sparkleIn():void
		{
			Starling.juggler.remove(Starling.juggler.delayCall(sparkleIn, getSparkleInterval()));

			Starling.juggler.removeTweens(starSparkle);
			Starling.juggler.removeTweens(star);
			
			var tweenInSparkle:Tween = new Tween(starSparkle, 0.5);
			tweenInSparkle.scaleTo(currentScale + 0.2);
			tweenInSparkle.animate("alpha", 0.35);
			tweenInSparkle.reverse = true;
			tweenInSparkle.repeatCount = 2;

			var rotationTween:Tween = new Tween(starSparkle, 1);
			rotationTween.animate("rotation", deg2rad(720));
			
			var tweenInStatic:Tween = new Tween(star, 0.5);
			tweenInStatic.reverse = true;
			tweenInStatic.repeatCount = 2;
			tweenInStatic.animate("alpha", 1);
			
			Starling.juggler.add(tweenInSparkle);
			Starling.juggler.add(rotationTween);
			Starling.juggler.add(tweenInStatic);
			
			Starling.juggler.delayCall(sparkleIn, getSparkleInterval());
			
		}
		
		private function getSparkleInterval():Number
		{
			var interval:Number;
			
			interval = (Math.random() * minimumInterval) + (Math.random() * 10);
			
			return interval;
		}
		
		public function setStarTexture(texture:Texture):void
		{
			star = new Image(texture);
			star.scale = 0.1 + randomPercent();
			star.alignPivot();
			star.x = star.width / 2;
			star.alpha = 0.8;
			addChild(star);
			
			starSparkle = new Image(texture);
			starSparkle.scale = star.scale;
			starSparkle.alignPivot();
			starSparkle.x = starSparkle.width / 2;
			starSparkle.alpha = 0;
			addChild(starSparkle);
			
			currentScale = star.scale;
		}
		
		public function randomPercent():Number
		{
			var percent:Number = Math.random();
			
			return percent;
		}
		
	}
}