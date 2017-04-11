package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.events.ViewEvent;
	import starling.display.Image;
	import starling.events.Event;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class LunarView extends View 
	{
	
		private var _orbitImage:Image;
		
		public function LunarView() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, handleAdded);
		}
		
		private function handleAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAdded);
			
			init();
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
		
		private function init():void
		{
			addOrbitImage("Static_Moon");
		}
		
		public function addOrbitImage(path:String):void
		{
			if (_orbitImage)
			{
				removeChild(_orbitImage);
			}
			
			_orbitImage = getDisplayImage(path);
			_orbitImage.pivotY = stage.stageHeight / 2;
			_orbitImage.pivotX = _orbitImage.width / 2;
			_orbitImage.y = stage.stageHeight / 2;
			_orbitImage.x = stage.stageWidth / 2;
			_orbitImage.rotation = -Math.PI / 4;
			addChild(_orbitImage);
		}
		
		public function get orbitImage():Image 
		{
			return _orbitImage;
		}
	}
}