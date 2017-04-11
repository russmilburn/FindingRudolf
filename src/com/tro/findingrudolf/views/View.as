package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.interfaces.IView;
	import robotlegs.bender.framework.api.ILogger;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class View extends Sprite implements IView
	{
		public var logger:ILogger;
		
		private var _assetManager:AssetManager;
		
		public function View() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage);
		}
		
		private function onViewAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage);
			
			onViewInit();
		}
		
		protected function onViewInit():void
		{
		
		}

		public function getTexturesSprite(id : String ) : Sprite
		{
			var texture : Texture = assetManager.getTexture(id);
			var image : Image = new Image(texture);
			image.name = "image";
			var sprite : Sprite = new Sprite();
			sprite.addChild(image);
			return sprite;
		}
		
		public function getDisplayImage(path:String):Image
		{
			var image:Image = new Image(assetManager.getTexture(path));
			return image;
		}
		
		protected function initStageAssets():void
		{
			logger.info(this + " Init stage assets");
		}
		
		public function get assetManager():AssetManager 
		{
			return _assetManager;
		}
		
		public function set assetManager(value:AssetManager):void 
		{
			_assetManager = value;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function show():void
		{
			this.visible = true;
		}
	}
}