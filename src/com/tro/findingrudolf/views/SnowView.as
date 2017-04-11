package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.views.components.Flake;
	
	import starling.events.Event;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class SnowView extends View 
	{		
		private static const flakes:uint = 1000;
		private var snowFlakes:Vector.<Flake> = new Vector.<Flake>(flakes, true);
		
		private var snowing:Boolean = false;
		
		public function SnowView() 
		{
			super();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			touchable = false;			
			generateSnow();
			
			dispatchEvent(new ViewEvent(ViewEvent.ON_VIEW_INIT_COMPLETE));
		}
		
		public function start():void 
		{
			for (var i:uint = 0; i < flakes; i++)
			{
				snowFlakes[i].startSnowing();
			}
		}
		
		public function stop():void 
		{
			for (var i:uint = 0; i < flakes; i++)
			{
				snowFlakes[i].stopSnowing();
			}
		}
		
		private function generateSnow():void
		{
			Flake.snowTexture = assetManager.getTexture("Static_Snow01");
			
			for (var i:uint = 0; i < flakes; i++)
			{				
				var easedScale:Number = 1-(easeOutExpo(i, 0, 1, flakes));
				
				if (easedScale < 0.015)
				{
					easedScale = 0.015;
				}
				
				snowFlakes[i] = new Flake(easedScale);
				addChild(snowFlakes[i]);
			}
		}
		
		private static function easeOutExpo(currentPos : Number, baseValue: Number, changeInValue: Number, totalFrames: Number):Number
		{
			return changeInValue * ( -Math.pow( 2, -10 * currentPos/totalFrames ) + 1 ) + baseValue;
		}
	}
}