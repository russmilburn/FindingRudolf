package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.CloudView;
	import com.tro.findingrudolf.views.StarView;
	import starling.utils.deg2rad;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class StarViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:StarView;
		
		public function StarViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			addContextListener(ClockModelEvent.ON_NIGHT_END, onNightEnd);
			
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
		}
		
		private function onNightStart(event:ClockModelEvent):void 
		{
			addContextListener(ClockModelEvent.ON_TIMER, onClockTimer);
		}
		
		private function onNightEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, onClockTimer);
			view.starHolder.alpha = 0;
		}
		
		private function onClockTimer(event:ClockModelEvent):void
		{
			view.starHolder.alpha = getStarsAlpha(event.lunarPercent);
			view.starHolder.rotation = getStarsRotation(event.lunarPercent);
		}
		
		//FADES IN STARS 
		private function getStarsAlpha(lunarPercent:Number):Number
		{
			var alpha:Number;
			
			if (lunarPercent < 0.2)
			{
				alpha = lunarPercent * 5;
				
			} else if (lunarPercent > 0.8)
			{
				alpha = (1 - lunarPercent) * 5;
			} else {
				alpha = 1;
			}
			
			return alpha;
		}
		
		private function getStarsRotation(lunarPercent:Number):Number 
		{
			var rotationDegreeRange:Number = 40;
			var rotationDegree:Number;
			
			if (lunarPercent < 0.5)
			{
				rotationDegree = -(rotationDegreeRange / 2) + ((rotationDegreeRange / 2) * (lunarPercent * 2));
			} else {
				rotationDegree = ((rotationDegreeRange/2) * ((lunarPercent) - 0.5)) * 2;
			}
			
			return deg2rad(rotationDegree);
		}
	}
}