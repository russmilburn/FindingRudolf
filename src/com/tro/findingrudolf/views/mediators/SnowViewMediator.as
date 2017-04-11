package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.views.SnowView;
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author Andrew Day and David Armstrong
	 */
	public class SnowViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:SnowView;
		
		private var snowToggleTimer:Timer;
		private var snowing:Boolean = false;
		
		public function SnowViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
			
			snowToggleTimer = new Timer(getRandom(), 1);
			snowToggleTimer.addEventListener(TimerEvent.TIMER_COMPLETE, toggleSnow);
			snowToggleTimer.start();			
		}
		
		private function toggleSnow(e:TimerEvent):void 
		{
			snowToggleTimer.reset();
			snowToggleTimer.delay = getRandom();
			
			if (snowing)
			{
				view.stop();
			} else {
				view.start();
			}
			
			snowToggleTimer.start();
		}
		
		private static function getRandom():Number
		{
			return (Math.random() * 20000) + 10000;
		}		
	}
}