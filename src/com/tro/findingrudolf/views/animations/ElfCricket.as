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
	public class ElfCricket extends AnimationClip 
	{
		private var _snowballTexture:Texture;
		private var _snowballImage:Image;
		
		public function ElfCricket(textures:Vector.<Texture>, fps:Number=12) 
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
			removeEventListener(Event.COMPLETE, onAnimationComplete);
			
			_snowballImage =  new Image(_snowballTexture);
			_snowballImage.alignPivot();
			
			var endingX:Number = _snowballImage.width / 2;
			var endingY:Number = _snowballImage.height / 2;
			
			_snowballImage.scale = 0.1;
			_snowballImage.x = 983;
			_snowballImage.y = 2226;
			
			addChild(_snowballImage);
			
			var xTween:Tween = new Tween(_snowballImage, 1, Transitions.LINEAR);
			xTween.animate("x", 602 - movieClip.stage.stageWidth);
			xTween.animate("rotation", deg2rad(360));
			xTween.onComplete = onAnimationComplete;
			xTween.scaleTo(7);
			
			var yTween:Tween = new Tween(_snowballImage, 0.5, Transitions.EASE_OUT);
			yTween.animate("y", 1564);
			yTween.reverse = true;
			yTween.repeatCount = 2;
			
			Starling.juggler.add(xTween);
			Starling.juggler.add(yTween);
		}
		
		override public function dispose():void
		{
			Starling.juggler.removeTweens(_snowballImage);
			
			_snowballImage.dispose();
			
			super.dispose();
		}
		
		public function get snowballTexture():Texture
		{
			return _snowballTexture;
		}
		
		public function set snowballTexture(value:Texture):void
		{
			_snowballTexture = value;
		}
	}
}