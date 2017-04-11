/**
 * Created by andrew day on 16/10/15.
 */
package com.tro.findingrudolf.events
{

	import starling.events.Event;

	public class ViewEvent extends Event
	{
		public static const ON_VIEW_INIT_COMPLETE : String = "onViewInitComplete";
		
		public function ViewEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
