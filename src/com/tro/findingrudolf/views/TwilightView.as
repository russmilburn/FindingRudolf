package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.events.ViewEvent;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.display.BlendMode;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TwilightView extends View 
	{
		private var _dawnImage:Quad;
		private var _duskImage:Quad;
		
		public function TwilightView() 
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
			_dawnImage = new Quad(stage.stageWidth, stage.stageHeight, 0xFFB766);
			_dawnImage.alpha = 0;
			_dawnImage.blendMode = BlendMode.MULTIPLY;
			addChild(_dawnImage);
			
			_duskImage = new Quad(stage.stageWidth, stage.stageHeight, 0xFF6F8B);
			_duskImage.alpha = 0;
			_duskImage.blendMode = BlendMode.MULTIPLY;
			addChild(_duskImage);
		}
		
		public function get dawnImage():Quad 
		{
			return _dawnImage;
		}
		
		public function set dawnImage(value:Quad):void 
		{
			_dawnImage = value;
		}
		
		public function get duskImage():Quad 
		{
			return _duskImage;
		}
		
		public function set duskImage(value:Quad):void 
		{
			_duskImage = value;
		}
	}
}