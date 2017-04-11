package com.tro.findingrudolf.events 
{
	import com.tro.findingrudolf.models.vos.TownLightsVo;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TownLightsModelEvent extends Event 
	{
		public static const INITIALIZE:String = "initialize";
		public static const UPDATE:String = "update";
		
		public var vo:TownLightsVo;
		
		public function TownLightsModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var evt : TownLightsModelEvent  = new TownLightsModelEvent(type, bubbles, cancelable);
			evt.vo = vo;
			return evt;
		}
		
	}

}