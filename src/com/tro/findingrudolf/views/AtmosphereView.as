package com.tro.findingrudolf.views
{
	import com.tro.findingrudolf.events.ViewEvent;
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class AtmosphereView extends View
	{
		private var _dayAtmosphere:Quad;
		private var _nightAtmosphere:Quad;
		
		public function AtmosphereView()
		{
			super();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			touchable = false;
			
			_dayAtmosphere = new Quad(stage.stageWidth, stage.stageHeight, 0xFFAE06);
			_dayAtmosphere.blendMode = BlendMode.MULTIPLY;
			_dayAtmosphere.alpha = 0;
			addChild(_dayAtmosphere);
			
			_nightAtmosphere = new Quad(stage.stageWidth, stage.stageHeight, 0x782FFF);
			_nightAtmosphere.blendMode = BlendMode.MULTIPLY;
			_nightAtmosphere.alpha = 0;
			addChild(_nightAtmosphere);
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
		
		public function get dayAtmosphere():Quad
		{
			return _dayAtmosphere;
		}
		
		public function set dayAtmosphere(value:Quad):void
		{
			_dayAtmosphere = value;
		}
		
		public function get nightAtmosphere():Quad 
		{
			return _nightAtmosphere;
		}
		
		public function set nightAtmosphere(value:Quad):void 
		{
			_nightAtmosphere = value;
		}
	}
}