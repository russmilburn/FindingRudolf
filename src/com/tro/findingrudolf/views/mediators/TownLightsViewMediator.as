package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.events.TownLightsModelEvent;
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.models.TownLightsModel;
	import com.tro.findingrudolf.views.components.TownLight;
	import com.tro.findingrudolf.views.TownLightsView;
	import starling.display.Image;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TownLightsViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:TownLightsView;
		
		private var lightsVector:Vector.<TownLight> = new <TownLight>[];
		
		public function TownLightsViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
			
			lightsVector = view.lightVector;
			
			addContextListener(TownLightsModelEvent.UPDATE, updateLight);
			
			addContextListener(ClockModelEvent.UPDATE_NIGHT_DISPLAY, turnOnAllLights);
		}
		
		private function turnOnAllLights(event:ClockModelEvent):void 
		{
			for (var i:int = 0; i < lightsVector.length; i++)
			{
				lightsVector[i].visible = true;
			}
		}
		
		private function updateLight(event:TownLightsModelEvent):void 
		{
			for (var i:int = 0; i < lightsVector.length; i++)
			{
				if (lightsVector[i].lightId == event.vo.lightId)
				{
					lightsVector[i].visible = event.vo.lightsOn;
				}
			}
		}
	}
}