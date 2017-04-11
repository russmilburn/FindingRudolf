package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.MountainView;
	import starling.display.Image;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class MountainViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:MountainView;
		
		[Inject]
		public var clockModel:ClockModel;
		
		public function MountainViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{	
			
			
			addContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			
			addContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			
			addContextListener(ClockModelEvent.ON_DAWN_START, onDawnStart);
			addContextListener(ClockModelEvent.ON_DAWN_END, onDawnEnd);
			
			addContextListener(ClockModelEvent.ON_DUSK_START, onDuskStart);
			addContextListener(ClockModelEvent.ON_DUSK_END, onDuskEnd);
			
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
		}
		
		private function onDawnStart(event:ClockModelEvent):void 
		{
			logger.info("onDawnStart");
			removeContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			removeContextListener(ClockModelEvent.ON_TIMER, onNightClockTimer);
			removeContextListener(ClockModelEvent.ON_TIMER, onDayClockTimer);
			
			addContextListener(ClockModelEvent.ON_TIMER, onDawnClockTimer);
		}
		
		private function onDawnEnd(event:ClockModelEvent):void 
		{
			logger.info("onDawnEnd");
			removeContextListener(ClockModelEvent.ON_TIMER, onDawnClockTimer);
			addContextListener(ClockModelEvent.ON_TIMER, onDayClockTimer);
		}
		
		private function onDuskStart(event:ClockModelEvent):void 
		{
			logger.info("onDuskStart");
			removeContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			removeContextListener(ClockModelEvent.ON_TIMER, onDayClockTimer);
			removeContextListener(ClockModelEvent.ON_TIMER, onNightClockTimer);
			
			addContextListener(ClockModelEvent.ON_TIMER, onDuskClockTimer);
		}
		
		private function onDuskEnd(event:ClockModelEvent):void 
		{
			logger.info("onDuskEnd");
			addContextListener(ClockModelEvent.ON_TIMER, onNightClockTimer);
			removeContextListener(ClockModelEvent.ON_TIMER, onDuskClockTimer);
		}
		
		private function onNightStart(event:ClockModelEvent):void 
		{	
			logger.info("onNightStart");
			removeContextListener(ClockModelEvent.ON_TIMER, onDayClockTimer);
			addContextListener(ClockModelEvent.ON_TIMER, onNightClockTimer);
		}
		
		private function onDayStart(event:ClockModelEvent):void 
		{	
			logger.info("onDayStart");
			removeContextListener(ClockModelEvent.ON_TIMER, onNightClockTimer);
			addContextListener(ClockModelEvent.ON_TIMER, onDayClockTimer);
		}
		
		private function onDawnClockTimer(event:ClockModelEvent):void
		{
			setPercentOnDawnShadows(event.twilightLinearPercent);
		}
		
		private function onDuskClockTimer(event:ClockModelEvent):void
		{
			setPercentOnDuskShadows(event.twilightLinearPercent);
		}
		
		private function onNightClockTimer(event:ClockModelEvent):void 
		{
			setPercentOnNightShadows(event.dayNightPercentMinusTwilight);
		}
		
		private function onDayClockTimer(event:ClockModelEvent):void 
		{
			setPercentOnDayShadows(event.dayNightPercentMinusTwilight);
		}
		
	
		//TODO: Please refactor so that all the logic happens in the mediator
		// mountain should not care if it is day or night.
		private function setPercentOnDawnShadows(percent:Number):void
		{
			if (clockModel.isDay)
			{
				applyPercentToLeftNightShadow(0);
				applyPercentToRightDayShadow(0);
				applyPercentToRightNightShadow(0);
				
				applyPercentToLeftDayShadow((percent - 0.5) * 2);
			}
			else
			{
				applyPercentToLeftDayShadow(0);
				applyPercentToRightNightShadow(1 - (percent*2));
			}
		}
		
		private function setPercentOnDuskShadows(percent:Number):void
		{
			if (clockModel.isDay)
			{
				applyPercentToLeftNightShadow(0);
				applyPercentToRightNightShadow(0);
				applyPercentToLeftDayShadow(0);
				
				applyPercentToRightDayShadow(1 - (percent*2));
			}
			else
			{
				applyPercentToRightNightShadow(0);
				applyPercentToLeftNightShadow((percent * 2) - 1);
			}
		}
		
		private function setPercentOnNightShadows(percent:Number) : void
		{
			var alphaLeftPercent:Number = 1 - percent;
			var alphaRightPercent:Number = percent;
			
			applyPercentToLeftNightShadow(alphaLeftPercent);
			applyPercentToRightNightShadow(alphaRightPercent);
		}
		
		private function setPercentOnDayShadows(percent:Number) : void
		{
			var alphaLeftPercent:Number = 1 - percent;
			var alphaRightPercent:Number = percent;
			
			applyPercentToLeftDayShadow(alphaLeftPercent);
			applyPercentToRightDayShadow(alphaRightPercent);
		}
		
		private function applyPercentToLeftDayShadow(value: Number) : void
		{
			view.leftMountain.setLeftShadowDayAlpha(value);
			view.centreMountain.setLeftShadowDayAlpha(value);
			view.rightMountain.setLeftShadowDayAlpha(value);
		}
		
		private function applyPercentToRightDayShadow(value: Number) : void
		{
			view.leftMountain.setRightShadowDayAlpha(value);
			view.centreMountain.setRightShadowDayAlpha(value);
			view.rightMountain.setRightShadowDayAlpha(value);
		}
		
		private function applyPercentToLeftNightShadow(value: Number) : void
		{
			view.leftMountain.setLeftShadowNightAlpha(value);
			view.centreMountain.setLeftShadowNightAlpha(value);
			view.rightMountain.setLeftShadowNightAlpha(value);
		}
		
		private function applyPercentToRightNightShadow(value: Number) : void
		{
			view.leftMountain.setRightShadowNightAlpha(value);
			view.centreMountain.setRightShadowNightAlpha(value);
			view.rightMountain.setRightShadowNightAlpha(value);
		}
	}
}