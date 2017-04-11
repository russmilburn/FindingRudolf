package com.tro.findingrudolf.views.components 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class House extends Sprite 
	{
		private var _baseHouse:Image;
		private var _dayHouse:Image;
		private var _nightHouse:Image;
		
		public function House() 
		{
			super();
		}
		
		public function setImageTextures(baseTexture:Texture, dayTexture:Texture, nightTexture:Texture):void
		{
			_baseHouse = new Image(baseTexture);
			addChild(_baseHouse);
			
			_dayHouse = new Image(dayTexture);
			_dayHouse.alpha = 0;
			addChild(_dayHouse);
			
			_nightHouse = new Image(nightTexture);
			_nightHouse.alpha = 0;
			addChild(_nightHouse);
		}
		
		public function setDayHouseAlpha(value:Number):void
		{
			_dayHouse.alpha = value;
		}
		
		public function setNightHouseAlpha(value:Number):void
		{
			_nightHouse.alpha = value;
		}
	}
}