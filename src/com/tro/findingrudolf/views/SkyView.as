package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.events.ViewEvent;
	import starling.display.Image;
	import starling.events.Event;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class SkyView extends View 
	{
		private var _day:Image;
		private var _night:Image;
		
		public function SkyView() 
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
			_night = getDisplayImage("Static_SkyNight");
			addChild(_night);
			
			_day = getDisplayImage("Static_SkyDay");
			_day.alpha = 0;
			addChild(_day);
		}
		
		public function get day():Image 
		{
			return _day;
		}
		
		public function set day(value:Image):void 
		{
			_day = value;
		}
		
		public function get night():Image 
		{
			return _night;
		}
		
		public function set night(value:Image):void 
		{
			_night = value;
		}
	}
}