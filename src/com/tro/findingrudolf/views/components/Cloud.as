package com.tro.findingrudolf.views.components 
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class Cloud extends Sprite 
	{
		private var _cloud:Image;
		private var _nightCloud:Image;
		private var _highLightCloud:Image;
		private var _type:String;
		
		public function Cloud() 
		{
			super();
		}
		
		public function setImageTexture(texture:Texture):void
		{
			_cloud = new Image(texture);
			addChild(_cloud);
			
			_nightCloud = new Image(texture);
			addChild(_nightCloud);
		}
		
		public function changeImageTexture(texture:Texture):void
		{
			_cloud.texture = texture;
			_nightCloud.texture = texture;
		}
		
		public function setNightColour(value:int):void
		{
			_nightCloud.color = value;
		}
		
		public function scaleImage(value:Number):void
		{
			_cloud.scale = value;
			_nightCloud.scale = value;
		}
		
		public function get cloud():Image 
		{
			return _cloud;
		}
		
		public function set cloud(value:Image):void 
		{
			_cloud = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get nightCloud():Image 
		{
			return _nightCloud;
		}
		
		public function set nightCloud(value:Image):void 
		{
			_nightCloud = value;
		}
	}
}