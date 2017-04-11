/**
 * Created by russellmilburn on 05/11/15.
 */
package com.tro.findingrudolf.views.animations
{

	import starling.events.Event;

	public class AnimationClipEvent extends Event
	{
		public static const ANIMATION_COMPLETE : String = "animationComplete";
		
		public static const SET_BRANCH_VISIBILITY : String = "setBranchVisibility";
		
		public var isBranchVisible:Boolean;
		
		public function AnimationClipEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}

	}
}
