package com.tro.findingrudolf.views.components 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TownLight extends Sprite 
	{
		private var _light:Image;
		
		private var _lightId:int;
		private var _houseId:int;
		
		public function TownLight() 
		{
			super();
		}
		
		public function setImageTexture(texture:Texture):void
		{
			_light = new Image(texture);
			addChild(_light);
		}
		
		public function get light():Image 
		{
			return _light;
		}
		
		public function set light(value:Image):void 
		{
			_light = value;
		}
		
		public function get lightId():int 
		{
			return _lightId;
		}
		
		public function set lightId(value:int):void 
		{
			_lightId = value;
		}
		
		public function get houseId():int 
		{
			return _houseId;
		}
		
		public function set houseId(value:int):void 
		{
			_houseId = value;
		}
	}
}