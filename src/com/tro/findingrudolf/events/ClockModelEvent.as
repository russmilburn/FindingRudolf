package com.tro.findingrudolf.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class ClockModelEvent extends Event 
	{
		public static const ON_TIMER:String = "onTimer";
		public static const ON_DAY_CHANGE:String = "onDayChange";
		public static const ON_DAWN_START:String = "onDawnStart";
		public static const ON_DAWN_END:String = "onDawnEnd";
		public static const ON_DAY_START:String = "onDayStart";
		public static const ON_DAY_END:String = "onDayEnd";
		public static const ON_DUSK_START:String = "onDuskStart";
		public static const ON_DUSK_END:String = "onDuskEnd";
		public static const ON_NIGHT_START:String = "onNightStart";
		public static const ON_NIGHT_END:String = "onNightEnd";
		
		public static const UPDATE_NIGHT_DISPLAY:String = "updateNightDisplay";
				
		public var dayNightPercent:Number;
		public var lunarPercent:Number;
		public var twilightPercent:Number;
		public var twilightLinearPercent:Number;
		public var dayNightPercentMinusTwilight:Number;
		public var dayNightPercentMinusTwilightZeroOneZero:Number;
		
		public function ClockModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var evt : ClockModelEvent  = new ClockModelEvent(type, bubbles, cancelable);
			evt.dayNightPercent = dayNightPercent;
			evt.lunarPercent = lunarPercent;
			evt.twilightPercent = twilightPercent;
			evt.twilightLinearPercent = twilightLinearPercent;
			evt.dayNightPercentMinusTwilight = dayNightPercentMinusTwilight;
			evt.dayNightPercentMinusTwilightZeroOneZero = dayNightPercentMinusTwilightZeroOneZero;
			return evt;
		}
		
	}

}