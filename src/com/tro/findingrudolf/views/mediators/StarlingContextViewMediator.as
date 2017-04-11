/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.views.mediators
{

	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.events.AssetLoaderModelEvent;
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.AnimationView;
	import com.tro.findingrudolf.views.CloudView;
	import com.tro.findingrudolf.views.LunarView;
	import com.tro.findingrudolf.views.MountainView;
	import com.tro.findingrudolf.views.AtmosphereView;
	import com.tro.findingrudolf.views.SkyView;
	import com.tro.findingrudolf.views.SnowView;
	import com.tro.findingrudolf.views.StarView;
	import com.tro.findingrudolf.views.StarlingContextView;
	import com.tro.findingrudolf.views.TownLightsView;
	import com.tro.findingrudolf.views.TownView;
	import com.tro.findingrudolf.views.TwilightView;
	import com.tro.findingrudolf.views.View;
	import com.tro.findingrudolf.views.ViewList;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;

	import flash.utils.Dictionary;

	import starling.events.Event;

	public class StarlingContextViewMediator extends BaseMediator
	{
		[Inject]
		public var view:StarlingContextView;
		
		private var viewDictionary:Dictionary;
		
		[Inject]
		public var clockModel:ClockModel;
		
		private var numberOfViews:int = 0;
		private var numberOfViewsInitialised:int = 0;
		
		private var shaken:Boolean;
		
		public function StarlingContextViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			logger.debug("initialize");
			
			dispatch(new AppEvent(AppEvent.START_UP));
			
			viewDictionary = new Dictionary();
			
			addContextListener(AssetLoaderModelEvent.ON_START_LOAD_ASSETS, onStartLoadAssets);
			addContextListener(AssetLoaderModelEvent.ON_COMPLETE_LOAD_ASSETS, onCompleteLoadAssets);
			
			addContextListener(AppEvent.SHAKE_MAIN_VIEW, shakeMainView);
			addContextListener(AppEvent.ENLARGE_MAIN_VIEW, enlargeMainView);
			addContextListener(AppEvent.REDUCE_MAIN_VIEW, reduceMainView);
			
			view.touchGroup = true;
			view.touchable = false;
			
		}
		
		private function onStartLoadAssets(event:AssetLoaderModelEvent):void
		{
			logger.debug("MEDIATOR: onStartLoadAssets");
		}
		
		private function onCompleteLoadAssets(event:AssetLoaderModelEvent):void
		{
			logger.debug("MEDIATOR: onCompleteLoadAssets");
			
			createChildren();
		}
		
		private function createChildren():void
		{
			var townView:TownView = new TownView();
			var skyView:SkyView = new SkyView();
			var starView:StarView = new StarView();
			var twilightView:TwilightView = new TwilightView();
			var townLightView:TownLightsView = new TownLightsView();
			var lunarView:LunarView = new LunarView();
			var mountainView:MountainView = new MountainView();
			var cloudView:CloudView = new CloudView();
			var animationView:AnimationView = new AnimationView();
			var snowView:SnowView = new SnowView();
			var atmosphereView:AtmosphereView = new AtmosphereView();
			
			viewDictionary[ViewList.TOWN_VIEW] = townView;
			viewDictionary[ViewList.SKY_VIEW] = skyView;
			viewDictionary[ViewList.STAR_VIEW] = starView;
			viewDictionary[ViewList.TWILIGHT_VIEW] = twilightView;
			viewDictionary[ViewList.LUNAR_VIEW] = lunarView;
			viewDictionary[ViewList.MOUNTAIN_VIEW] = mountainView;
			viewDictionary[ViewList.CLOUD_VIEW] = cloudView;
			viewDictionary[ViewList.ANIMATION_VIEW] = animationView;
			viewDictionary[ViewList.TOWN_LIGHT_VIEW] = townLightView;
			viewDictionary[ViewList.SNOW_VIEW] = snowView;
			viewDictionary[ViewList.ATMOSPHERE_VIEW] = atmosphereView;

			for each (var iView:View in viewDictionary)
			{
				numberOfViews++;
				iView.addEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onCreateViewComplete);
				iView.hide();
			}
			
			view.addChild(skyView);
			view.addChild(starView);			
			view.addChild(lunarView);
			view.addChild(cloudView);
			view.addChild(mountainView);
			view.addChild(townView);
			view.addChild(townLightView);
			view.addChild(animationView);
			view.addChild(snowView);
			view.addChild(atmosphereView);
			view.addChild(twilightView);			
			
			skyView.show();
			twilightView.show();
			starView.show();
			lunarView.show();
			mountainView.show();
			cloudView.show();
			townView.show();
			townLightView.show();
			snowView.show();
			atmosphereView.show();
			animationView.show();
		}
		
		private function onCreateViewComplete(event:Event):void
		{
			numberOfViewsInitialised++;
			
			if (numberOfViewsInitialised == numberOfViews)
			{
				view.pivotX = view.stage.stageWidth / 2;
				view.pivotY = view.stage.stageHeight / 2;
				
				view.x = view.stage.stageWidth / 2;
				view.y = view.stage.stageHeight / 2;
				
				event.target.removeEventListener(ViewEvent.ON_VIEW_INIT_COMPLETE, onCreateViewComplete);
				dispatch(new AppEvent(AppEvent.START_UP_COMPLETE));
			}
		}
		
		private function enlargeMainView(event:AppEvent):void 
		{
			Starling.juggler.removeTweens(view);
			
			var enlargeTween:Tween = new Tween(view, 5, Transitions.EASE_IN_OUT);
			enlargeTween.scaleTo(1.02);
			
			Starling.juggler.add(enlargeTween);
		}
		
		private function reduceMainView(event:AppEvent):void 
		{
			Starling.juggler.removeTweens(view);
			
			var reduceTween:Tween = new Tween(view, 5, Transitions.EASE_IN_OUT);
			reduceTween.scaleTo(1);
			
			Starling.juggler.add(reduceTween);
		}
		
		private function shakeMainView(event:AppEvent):void 
		{
			var shakeTween:Tween;
			
			if (!shaken)
			{
				Starling.juggler.removeTweens(view);
				
				shakeTween = new Tween(view, 0.2, Transitions.EASE_OUT_IN_BOUNCE);
				shakeTween.moveTo(view.stage.stageWidth/2 + 3, view.stage.stageHeight/2 + 15);
				shakeTween.reverse = true;
				shakeTween.repeatCount = 2;
				Starling.juggler.add(shakeTween);
				shaken = true;
				
			} else {
				shakeTween = new Tween(view, 0.2, Transitions.EASE_OUT_IN_BOUNCE);
				shakeTween.moveTo(view.stage.stageWidth/2 - 3, view.stage.stageHeight/2 + 15);
				shakeTween.reverse = true;
				shakeTween.repeatCount = 2;
				Starling.juggler.add(shakeTween);
				shaken = false;
			}
		}
	}
}
