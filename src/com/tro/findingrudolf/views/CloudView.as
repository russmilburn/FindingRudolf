package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.views.components.Cloud;
	import starling.display.Image;
	import starling.events.Event;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class CloudView extends View 
	{
		public function CloudView() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, handleAdded);
		}
		
		private function handleAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAdded);
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
	}
}