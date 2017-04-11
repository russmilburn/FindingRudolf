/**
 * Created by russellmilburn on 22/07/15.
 */
package com.tro.findingrudolf.events
{

	import com.tro.findingrudolf.models.vos.DataPacketVo;

	import flash.events.Event;

	public class AppEvent extends Event
	{
		public static const START_UP : String = "startUp";
		public static const START_UP_COMPLETE : String = "startUpComplete";
		public static const START_CLOCK : String = "startClock";
		public static const STOP_CLOCK : String = "stopClock";
		public static const SET_TOWN_VIEW_BRANCH_VISIBILITY : String = "setTownViewBranchVisibility";
		public static const CREATE_INTERACTIVE_ANIMATION : String = "createInteractiveAnimation";
		public static const CREATE_RANDOM_ANIMATION : String = "createRandomAnimation";
		public static const INTERACTIVE_ANIMATION_COMPLETE : String = "interactiveAnimationComplete";
		public static const TOGGLE_CLOCK_SPEED : String = "toggleClockSpeed";
		
		public static const TRIGGER_EASTER_EGG : String = "triggerEasterEgg";
		
		public static const ENLARGE_MAIN_VIEW : String = "enlargeMainView";
		public static const SHAKE_MAIN_VIEW : String = "shakeMainView";
		public static const REDUCE_MAIN_VIEW : String = "reduceMainView";
		
		public var data : DataPacketVo;
		public var animationId : String;
		
		public function AppEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var evt : AppEvent  = new AppEvent(type, bubbles, cancelable);
			evt.data = this.data;
			evt.animationId = this.animationId;
			return evt;
		}
	}
}
