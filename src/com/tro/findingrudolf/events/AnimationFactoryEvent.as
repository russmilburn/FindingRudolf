/**
 * Created by russellmilburn on 04/11/15.
 */
package com.tro.findingrudolf.events
{

	import com.tro.findingrudolf.interfaces.IAnimationClip;

	import flash.events.Event;

	public class AnimationFactoryEvent extends Event
	{

		public static const ON_CREATE_ANIMATION : String = "onCreateAnimation";

		public var anim :IAnimationClip;

		public function AnimationFactoryEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		override public function clone():Event
		{
			var evt : AnimationFactoryEvent = new AnimationFactoryEvent(type, bubbles, cancelable);
			evt.anim = this.anim;
			return evt;
		}
	}
}
