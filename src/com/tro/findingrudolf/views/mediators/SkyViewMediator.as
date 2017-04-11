package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.SkyView;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.BlendMode;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class SkyViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:SkyView;
		
		private var shootinStarMate:MovieClip;
		private var shootingStarTimer:Timer;
		private var randomTime:Number;
		
		public function SkyViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			addContextListener(ClockModelEvent.ON_DAY_END, onDayEnd); 
			
			addContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			addContextListener(ClockModelEvent.ON_NIGHT_END, onNightEnd);
			
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
			
			shootingStarTimer = new Timer(getRandom());
			shootingStarTimer.addEventListener(TimerEvent.TIMER, handleStarTimer);
		}
		
		private function onNightEnd(event:ClockModelEvent):void 
		{
			stopShootingStarTimer();
		}
		
		private function onNightStart(event:ClockModelEvent):void 
		{	
			startShootingStarTimer();
		}
		
		private function getRandom():Number
		{
			var random:Number = (60000 * 2.5)  + Math.random() * (60000 * 5);
			
			return random;
		}
		
		private function stopShootingStarTimer():void 
		{
			shootingStarTimer.stop();
		}
		
		private function startShootingStarTimer():void 
		{
			shootingStarTimer.start();
		}
		
		private function handleStarTimer(event:TimerEvent):void 
		{
			var starAnimation:MovieClip = new MovieClip(assetLoaderModel.assetManager.getTextures("Random_07_ShootingStar"), 24);
			starAnimation.addEventListener(Event.COMPLETE, disposeMovieClip);
			starAnimation.loop = false;
			
			var point : Point = getStarPos(starAnimation);
			
			starAnimation.x = point.x; 
			starAnimation.y = point.y; 
			
			view.addChildAt(starAnimation, view.numChildren);
			
			starAnimation.play();
			
			Starling.juggler.add(starAnimation);
			
			shootingStarTimer.delay = getRandom();
		}
		
		private function getStarPos(starAnimation:MovieClip):Point 
		{
			var span:Number = Math.random() * view.stage.stageWidth;
			
			var point:Point = new Point();
			
			if (span > view.stage.stageWidth / 2)
			{
				//671 is the hardcoded width of the shooting star
				point.x = span - 671;
			} else {
				point.x = span;
			}
			
			point.y = Math.random() * view.stage.stageHeight / 4;
		
			return point;
		}
		
		private function disposeMovieClip(event:Event):void 
		{
			var starAnimation:MovieClip = MovieClip(event.target);
			
			Starling.juggler.remove(starAnimation);
			
			starAnimation.removeEventListener(Event.COMPLETE, disposeMovieClip);
			view.removeChild(starAnimation);
			starAnimation.dispose();
			starAnimation = null;
		}
		
		private function onDayEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, onDayClockTimer);
			
			view.day.alpha = 0;
		}
		
		private function onDayStart(event:ClockModelEvent):void 
		{
			addContextListener(ClockModelEvent.ON_TIMER, onDayClockTimer);
		}
		
		private function onDayClockTimer(event:ClockModelEvent):void 
		{
			view.day.alpha = event.dayNightPercent; 
			
		}
		
		private function onNightClockTimer(event:ClockModelEvent):void 
		{
			view.night.alpha = event.dayNightPercent;
		}
	}
}