package com.tro.findingrudolf.views.components 
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.animation.Transitions;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class Fog extends Sprite 
	{
		private var fogLeft:Image;
		private var fogRight:Image;
		
		private var originalWidth:Number;
		
		public function Fog() 
		{
			super();
		}
		
		public function setImageTextures(texture:Texture):void
		{
			var stretch:Number = 0.1;
			
			fogLeft = new Image(texture);
			originalWidth = fogLeft.width;
			fogLeft.width += fogLeft.width * stretch;
			fogLeft.x = -(originalWidth * stretch);
			addChild(fogLeft);
			
			fogRight = new Image(texture);
			fogRight.width += fogRight.width * stretch;
			addChild(fogRight);
			
			animate(stretch);
		}
		
		private function animate(stretch:Number):void
		{
			Starling.juggler.removeTweens(fogLeft);
			Starling.juggler.removeTweens(fogRight);
			
			var tweenLeft:Tween = new Tween(fogLeft, 34, Transitions.EASE_IN_OUT);
			tweenLeft.moveTo(0, 0);
			tweenLeft.reverse = true;
			tweenLeft.repeatCount = 2;
			
			var tweenRight:Tween = new Tween(fogRight, 26, Transitions.EASE_IN_OUT);
			tweenRight.moveTo(-(originalWidth * stretch), 0);
			tweenRight.reverse = true;
			tweenRight.repeatCount = 2;
			tweenRight.onComplete = animate;
			tweenRight.onCompleteArgs = [stretch];
	
			Starling.juggler.add(tweenLeft);
			Starling.juggler.add(tweenRight);
		}
	}
}