package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.AtmosphereView;
	import com.tro.findingrudolf.events.ClockModelEvent;
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class AtmosphereViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:AtmosphereView;
		
		[Inject]
		public var clockModel:ClockModel;
		
		private static const dayAlpha:Number = 0.35;//0.35;
		private static const nightAlpha:Number = 0.25;//0.25;
		
		public function AtmosphereViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{
			view.logger = logger;			
			
			addContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			addContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			
			addContextListener(ClockModelEvent.ON_DUSK_START, duskStart);
			addContextListener(ClockModelEvent.ON_DAWN_START, dawnStart);
			
			addContextListener(ClockModelEvent.ON_DUSK_END, duskEnd);
			addContextListener(ClockModelEvent.ON_DAWN_END, dawnEnd);
		}
		
		private function onNightStart(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			removeContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			
			addContextListener(ClockModelEvent.ON_TIMER, nightCycle);
		}
		
		private function onDayStart(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			addContextListener(ClockModelEvent.ON_TIMER, dayCycle);
		}
		
		private function dawnEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, nightCycle);
			addContextListener(ClockModelEvent.ON_TIMER, dayCycle);
			view.nightAtmosphere.alpha = 0;
		}
		
		private function duskStart(event:ClockModelEvent):void 
		{	
			removeContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			removeContextListener(ClockModelEvent.ON_TIMER, dayCycle);
			addContextListener(ClockModelEvent.ON_TIMER, duskCycle);
		}
		
		private function duskCycle(event:ClockModelEvent):void 
		{
			view.dayAtmosphere.alpha = (1 - event.twilightLinearPercent) * dayAlpha;
			view.nightAtmosphere.alpha = event.twilightLinearPercent * nightAlpha;
		}
		
		private function dawnCycle(event:ClockModelEvent):void 
		{
			view.nightAtmosphere.alpha = (1 - event.twilightLinearPercent) * nightAlpha;
			view.dayAtmosphere.alpha = event.twilightLinearPercent * dayAlpha;
		}
		
		private function duskEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, duskCycle);
			addContextListener(ClockModelEvent.ON_TIMER, nightCycle);
			view.dayAtmosphere.alpha = 0;
		}
		private function dayCycle(event:ClockModelEvent):void 
		{
			view.nightAtmosphere.alpha = 0;
			view.dayAtmosphere.alpha = (1 - event.dayNightPercentMinusTwilightZeroOneZero) * dayAlpha;
		}
		private function nightCycle(event:ClockModelEvent):void 
		{
			view.dayAtmosphere.alpha = 0;
			view.nightAtmosphere.alpha = (1 - event.dayNightPercentMinusTwilightZeroOneZero) * nightAlpha;
		}
		
		private function dawnStart(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, nightCycle);
			addContextListener(ClockModelEvent.ON_TIMER, dawnCycle);
		}	
	}
}