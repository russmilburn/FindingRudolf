package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.events.ElfzillaEvent;
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.components.House;
	import com.tro.findingrudolf.views.TownView;
	import starling.core.Starling;
	import starling.display.MovieClip;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TownViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:TownView;

		[Inject]
		public var clockModel:ClockModel;
		
		private var elfZillaPlaying:Boolean;
		
		public function TownViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
			
			view.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onViewInitComplete);
			
			addContextListener(ClockModelEvent.ON_DUSK_START, onDuskStart);
			addContextListener(ClockModelEvent.ON_DUSK_END, onDuskEnd);
			
			addContextListener(ClockModelEvent.ON_DAWN_START, onDawnStart);
			addContextListener(ClockModelEvent.ON_DAWN_END, onDawnEnd);
			
			addContextListener(ClockModelEvent.UPDATE_NIGHT_DISPLAY, updateDisplayToNight);
			
			addContextListener(AppEvent.TRIGGER_EASTER_EGG, playElfzillaAnimation);
		}
		
		private function onViewInitComplete(event:ViewEvent):void 
		{
			view.elfzilla.addEventListener(ElfzillaEvent.ANIMATION_COMPLETE, onElfzillaComplete);
			view.elfzilla.addEventListener(ElfzillaEvent.ANIMATION_START, onElfzillaStart);
			view.elfzilla.addEventListener(ElfzillaEvent.FOOT_STEP, onElfFootStep);
		}
		
		private function onElfFootStep(event:ElfzillaEvent):void 
		{
			dispatch(new AppEvent(AppEvent.SHAKE_MAIN_VIEW));
		}
		
		private function onElfzillaStart(e:ElfzillaEvent):void 
		{
			logger.info("onElfzillaStart");
			
			dispatch(new AppEvent(AppEvent.ENLARGE_MAIN_VIEW));
			
			elfZillaPlaying = true;
		}
		
		private function onElfzillaComplete(event:ElfzillaEvent):void 
		{
			logger.info("onElfzillaComplete");
			
			dispatch(new AppEvent(AppEvent.REDUCE_MAIN_VIEW));
			
			elfZillaPlaying = false;
		}
		
		private function updateDisplayToNight(event:ClockModelEvent):void 
		{
			view.townNight.alpha = 1;
			toggleLights(true);
		}
		
		private function onDawnStart(event:ClockModelEvent):void 
		{
			addContextListener(ClockModelEvent.ON_TIMER, onDawnTimer);
		}
		
		private function onDawnEnd(event:ClockModelEvent):void
		{
			toggleLights(false);
			removeContextListener(ClockModelEvent.ON_TIMER, onDawnTimer);			
		}
		
		private function onDawnTimer(event:ClockModelEvent):void
		{
			view.townNight.alpha = 1 - event.twilightLinearPercent;
		}
		
		private function onDuskStart(event:ClockModelEvent):void 
		{
			toggleLights(true);
			addContextListener(ClockModelEvent.ON_TIMER, onDuskTimer);
		}
		
		private function toggleLights(value:Boolean):void 
		{
			view.smallLight1.visible = value;
			view.smallLight2.visible = value;
			view.smallLight3.visible = value;
		}
		
		private function onDuskTimer(event:ClockModelEvent):void
		{
			view.townNight.alpha = event.twilightLinearPercent;
		}
		
		private function onDuskEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, onDuskTimer);
		}
		
		public function playElfzillaAnimation(event:AppEvent):void
		{
			if (!elfZillaPlaying)
			{
				view.elfzilla.animate();
			}
		}
	}
}