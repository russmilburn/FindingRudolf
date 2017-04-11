package com.tro.findingrudolf.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class ElfzillaEvent extends Event 
	{
		public static const ANIMATION_COMPLETE:String = "animationComplete";
		public static const ANIMATION_START:String = "animationStart";
		
		public static const FOOT_STEP:String = "footStep";
		
		public var footPressure:Number;
		
		public function ElfzillaEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
		
	}

}