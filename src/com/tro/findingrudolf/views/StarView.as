package com.tro.findingrudolf.views
{
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.views.components.Star;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.deg2rad;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class StarView extends View
	{
		private var _backgroundStars:Image;
		private var _starHolder:Sprite;
		private var star:Star;
		private var starArray:Array = [];
		private var amountOfStars:int = 500;
		private var lowerY:Number = 0;
		private var starsYRange:Number = 0;
		private var numRange:Number = 0;
		
		public function StarView()
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
			createStars();
		}
		
		private function createStars():void
		{
			starHolder = new Sprite();
			
			for (var i:int = 0; i < amountOfStars; i++)
			{
				star = new Star();
				star.setStarTexture(assetManager.getTexture("Static_Star"));
				star.setTimer();
				star.y = ((easeIn(i / amountOfStars)) * (stage.stageHeight / 2.5)) + (stage.stageHeight/2);//getYRange() + (stage.stageHeight);
				star.pivotY = stage.stageHeight;
				star.alpha = randomPercent();
				starArray.push(star);
				starHolder.addChild(star);
			}
			
			starHolder.x = stage.stageWidth / 2;
			starHolder.y = stage.stageHeight - (stage.stageHeight / 8);
			starHolder.pivotX = starHolder.width / 2;
			starHolder.pivotY = starHolder.height;
			addChild(starHolder);
			
			for (var j:int = 0; j < starArray.length; j++)
			{
				starArray[j].rotation = getXRange();
			}
			
			starsAlphaLinearReduction();
		}
		
		protected static function easeIn(ratio:Number):Number
        {
            return ratio * ratio * ratio;
        }
		
		private function starsAlphaLinearReduction():void
		{
			for (var i:Number = 0; i < starArray.length; i++)
			{
				var starRange:Number = starArray[i].y - stage.stageHeight;
				
				starArray[i].alpha = 1 - (starRange) / (starsYRange);
			}
		}
		
		private function getYRange():Number
		{
			var yRange:Number = Math.random() * ((stage.stageHeight) - (stage.stageHeight/4)) - stage.stageHeight/2;
			
			if (yRange > starsYRange)
			{
				starsYRange = yRange;
			}
			
			return yRange;
		}
		
		private function getXRange():Number
		{
			var range:Number = 135;
			
			var random:Number = (Math.random() * range) - range/2
			
			return deg2rad(random);
		}
		
		public function randomPercent():Number
		{
			var percent:Number = Math.random();
			
			return percent;
		}
		
		public function get starHolder():Sprite 
		{
			return _starHolder;
		}
		
		public function set starHolder(value:Sprite):void 
		{
			_starHolder = value;
		}
		
		public function get backgroundStars():Image 
		{
			return _backgroundStars;
		}
		
		public function set backgroundStars(value:Image):void 
		{
			_backgroundStars = value;
		}
	}
}