/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf
{

	import com.tro.findingrudolf.events.AppEvent;

	import flash.events.IEventDispatcher;

	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;

	public class ConfigComplete implements IConfig
	{
		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var _context : IContext;

		public function ConfigComplete()
		{
		}

		public function configure():void
		{
			_context.initialize(afterInitializing);
		}

		private function afterInitializing():void
		{
			//eventDispatcher.dispatchEvent(new AppEvent(AppEvent.START_UP));
		}
	}
}
