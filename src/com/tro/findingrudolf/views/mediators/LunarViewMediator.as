package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.LunarView;
	import starling.display.Image;
	import starling.utils.deg2rad;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class LunarViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:LunarView;

		public function LunarViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(ClockModelEvent.ON_TIMER, onClockTimer);
			
			addContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			addContextListener(ClockModelEvent.ON_DAY_END, onDayEnd); 
		
			addContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			addContextListener(ClockModelEvent.ON_NIGHT_END, onNightEnd);
			
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
		}
		
		private function onNightEnd(event:ClockModelEvent):void 
		{
			
		}
		
		private function onNightStart(event:ClockModelEvent):void 
		{
			view.addOrbitImage("Static_Moon");
		}
		
		private function onDayEnd(event:ClockModelEvent):void 
		{
			
		}
		
		private function onDayStart(event:ClockModelEvent):void 
		{
			view.addOrbitImage("Static_Sun");
		}
		
		
		private function onClockTimer(event:ClockModelEvent):void 
		{
			view.orbitImage.rotation = getOrbitRotation(event.lunarPercent);
		}

		//TODO: why is current orbit passed as a parameter? it is not used
		private function getOrbitRotation(percent:Number):Number 
			{
				var startingDegrees:Number = deg2rad(-77.25);
				var endingDegrees:Number = deg2rad(77.25);
				
				var rotation:Number = startingDegrees + (endingDegrees - startingDegrees) * percent;
				
				return rotation;
			}
		
	}

}