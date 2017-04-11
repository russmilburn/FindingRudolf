package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.views.components.TownLight;
	import starling.display.Image;
	import starling.events.Event;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TownLightsView extends View 
	{
		private var _light:TownLight;
		private var _lightVector:Vector.<TownLight> = new <TownLight>[];
		private var _amountOfLights:int = 19;
		
		public function TownLightsView() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, handleAdded);
		}
		
		private function handleAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAdded);
			
			init();
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
		
		private function init():void
		{
			for (var i:int = 0; i < _amountOfLights; i++)
			{
				_light = new TownLight();
				
				var leadingZero:String = "";
				
				if (i < 9)
				{
					leadingZero = "0";
				}
				
				_light.setImageTexture(assetManager.getTexture("Light_" + leadingZero + String(i + 1)));
				_light.lightId = i;
				_light.visible = false;
				_lightVector.push(_light);
				addChild(_light);
			}
		}
		
		public function get light():TownLight 
		{
			return _light;
		}
		
		public function set light(value:TownLight):void 
		{
			_light = value;
		}
		
		public function get lightVector():Vector.<TownLight> 
		{
			return _lightVector;
		}
		
		public function set lightVector(value:Vector.<TownLight>):void 
		{
			_lightVector = value;
		}
	}
}