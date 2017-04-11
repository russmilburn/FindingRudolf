package com.tro.findingrudolf.views.animations
{

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.deg2rad;

	/**
	 * ...
	 * @author Andrew Day
	 */
	public class SkiingAccident extends AnimationClip 
	{
		private var _skiingTexture:Texture;
		private var _skiingImage:Image;

		public function SkiingAccident(textures:Vector.<Texture>, fps:Number=12) 
		{
			super(textures, fps);
			
			_isScripted = true;
			
			if (movieClip.stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init); 
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init); 
			addChild(movieClip);
		}
		
		override protected function onMovieClipComplete(event:Event):void 
		{
			movieClip.removeEventListener(Event.COMPLETE, onMovieClipComplete);
			
			removeChild(movieClip);
			
			_skiingImage =  new Image(_skiingTexture);
			_skiingImage.scale = .02;
			_skiingImage.x = 1400;
			_skiingImage.y = 1365;
			_skiingImage.alignPivot();
			addChild(_skiingImage);
			
			var xTween:Tween = new Tween(_skiingImage, 3);
			xTween.scaleTo(1);
			xTween.animate("rotation", deg2rad(90));
			xTween.animate("x",  -2000);
			xTween.onComplete = onAnimationComplete;
			
			var yTween:Tween = new Tween(_skiingImage, 1.5, Transitions.EASE_OUT);
			yTween.animate("y", 2750/2 - 300);
			yTween.reverse = true;
			yTween.repeatCount = 2;
			
			Starling.juggler.add(xTween);
			Starling.juggler.add(yTween);
		}
		
		override public function dispose():void
		{
			_skiingImage.dispose();
			
			Starling.juggler.removeTweens(_skiingImage);
			
			super.dispose();
		}
		
		public function get skiingTexture():Texture
		{
			return _skiingTexture;
		}
		
		public function set skiingTexture(value:Texture):void
		{
			_skiingTexture = value;
		}
	}
}