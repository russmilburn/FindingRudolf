/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.models
{

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.framework.api.ILogger;

	public class BaseModel
	{
		[Inject]
		public var logger : ILogger;

		[Inject]
		public var eventDispatcher:IEventDispatcher;

		public function BaseModel()
		{

		}

		protected function dispatch(event:Event):void
		{
			if(eventDispatcher.hasEventListener(event.type))
				eventDispatcher.dispatchEvent(event);
		}
	}
}
