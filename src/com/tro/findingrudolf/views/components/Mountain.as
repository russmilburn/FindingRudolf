/**
 * Created by russellmilburn on 21/10/15.
 */
package com.tro.findingrudolf.views.components
{

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Mountain extends Sprite
	{
		private var _mountain : Image;
		
		private var _leftDayShadow : Image;
		private var _rightDayShadow : Image;
		
		private var _leftNightShadow : Image;
		private var _rightNightShadow : Image;
		
		public function Mountain()
		{
			super();
		}
		
		public function setMountainImageTextures(rightShadowDayTexture:Texture, leftShadowDayTexture:Texture, rightShadowNightTexture:Texture, leftShadowNightTexture:Texture):void
		{
			_mountain = new Image(rightShadowDayTexture);
			_mountain.color = 0x111111;
			addChild(_mountain);
			
			_rightNightShadow = new Image(rightShadowNightTexture);
			_rightNightShadow.alpha = 0;
			addChild(_rightNightShadow);
			
			_leftNightShadow = new Image(leftShadowNightTexture);
			_leftNightShadow.alpha = 0;
			addChild(_leftNightShadow);
			
			_rightDayShadow = new Image(rightShadowDayTexture);
			_rightDayShadow.alpha = 0;
			addChild(_rightDayShadow);
			
			_leftDayShadow = new Image(leftShadowDayTexture);
			_leftDayShadow.alpha = 0;
			addChild(_leftDayShadow);
		}
		
		public function setRightShadowDayAlpha(value : Number) : void
		{
			_rightDayShadow.alpha = value;
		}
		
		public function setLeftShadowDayAlpha(value : Number) : void
		{
			_leftDayShadow.alpha = value;
		}
		
		public function setRightShadowNightAlpha(value : Number) : void
		{
			_rightNightShadow.alpha = value;
		}
		
		public function setLeftShadowNightAlpha(value : Number) : void
		{
			_leftNightShadow.alpha = value;
		}
		
		public function get mountain():Image 
		{
			return _mountain;
		}
		
		public function set mountain(value:Image):void 
		{
			_mountain = value;
		}
		
		public function get leftDayShadow():Image 
		{
			return _leftDayShadow;
		}
		
		public function set leftDayShadow(value:Image):void 
		{
			_leftDayShadow = value;
		}
		
		public function get rightayShadow():Image 
		{
			return _rightDayShadow;
		}
		
		public function set rightDayShadow(value:Image):void 
		{
			_rightDayShadow = value;
		}
		
		public function get leftNightShadow():Image 
		{
			return _leftNightShadow;
		}
		
		public function set leftNightShadow(value:Image):void 
		{
			_leftNightShadow = value;
		}
		
		public function get rightNightShadow():Image 
		{
			return _rightNightShadow;
		}
		
		public function set rightNightShadow(value:Image):void 
		{
			_rightNightShadow = value;
		}
	}
}
