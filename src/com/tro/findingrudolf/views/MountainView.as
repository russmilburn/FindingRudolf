package com.tro.findingrudolf.views 
{

	import com.tro.findingrudolf.views.components.Mountain;
	import com.tro.findingrudolf.events.ViewEvent;
	import starling.display.Image;
	import starling.events.Event;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class MountainView extends View 
	{
		private var _leftMountain : Mountain;
		private var _centreMountain : Mountain;
		private var _rightMountain : Mountain;
		
		public function MountainView() 
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
			_leftMountain = new Mountain();
			_leftMountain.setMountainImageTextures(assetManager.getTexture("Static_Mountains_Left_01"),	assetManager.getTexture("Static_Mountains_Left_02"), assetManager.getTexture("Static_MountainsNight_Left_01"),assetManager.getTexture("Static_MountainsNight_Left_02"));
			addChild(_leftMountain);
			
			_centreMountain = new Mountain();
			_centreMountain.setMountainImageTextures(assetManager.getTexture("Static_Mountains_Mid_01"), assetManager.getTexture("Static_Mountains_Mid_02"), assetManager.getTexture("Static_MountainsNight_Mid_01"), assetManager.getTexture("Static_MountainsNight_Mid_02"));
			addChild(_centreMountain);
			
			_rightMountain = new Mountain();
			_rightMountain.setMountainImageTextures(assetManager.getTexture("Static_Mountains_Right_02"), assetManager.getTexture("Static_Mountains_Right_01"), assetManager.getTexture("Static_MountainsNight_Right_02"), assetManager.getTexture("Static_MountainsNight_Right_01"))
			addChild(_rightMountain);
		}
		
		public function get leftMountain():Mountain 
		{
			return _leftMountain;
		}
		
		public function set leftMountain(value:Mountain):void 
		{
			_leftMountain = value;
		}
		
		public function get rightMountain():Mountain 
		{
			return _rightMountain;
		}
		
		public function set rightMountain(value:Mountain):void 
		{
			_rightMountain = value;
		}
		
		public function get centreMountain():Mountain 
		{
			return _centreMountain;
		}
		
		public function set centreMountain(value:Mountain):void 
		{
			_centreMountain = value;
		}
	}
}