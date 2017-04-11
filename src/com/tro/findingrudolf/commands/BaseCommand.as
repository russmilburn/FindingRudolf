/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.commands
{

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.ILogger;

	public class BaseCommand extends Command
	{
		[Inject]
		public var logger : ILogger;

		[Inject]
		public var eventDispatcher:IEventDispatcher;

		public function BaseCommand()
		{
			super();
		}

		protected function dispatch(event:Event):void
		{
			if(eventDispatcher.hasEventListener(event.type))
				eventDispatcher.dispatchEvent(event);
		}
	}
}
