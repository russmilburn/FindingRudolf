package com.tro.findingrudolf.views.mediators
{
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.TwilightView;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TwilightViewMediator extends BaseMediator
	{
		[Inject]
		public var view:TwilightView;
		
		public function TwilightViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(ClockModelEvent.ON_DAWN_START, onDawnStart);
			addContextListener(ClockModelEvent.ON_DAWN_END, onDawnEnd);
			
			addContextListener(ClockModelEvent.ON_DUSK_START, onDuskStart);
			addContextListener(ClockModelEvent.ON_DUSK_END, onDuskEnd);
			
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
		}
		
		private function onDawnStart(event:ClockModelEvent):void 
		{
			addContextListener(ClockModelEvent.ON_TIMER, onDawnClockTimer);
		}
		
		private function onDawnEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, onDawnClockTimer);
			
			view.dawnImage.alpha = 0;
		}
		
		private function onDuskStart(event:ClockModelEvent):void 
		{
			addContextListener(ClockModelEvent.ON_TIMER, onDuskClockTimer);
		}
		
		private function onDuskEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, onDuskClockTimer);
			
			view.duskImage.alpha = 0;
		}
		
		private function onDawnClockTimer(event:ClockModelEvent):void 
		{
			view.dawnImage.alpha = event.twilightPercent * 0.35;
		}
		
		private function onDuskClockTimer(event:ClockModelEvent):void 
		{
			view.duskImage.alpha = event.twilightPercent * 0.35;
		}
	}
}