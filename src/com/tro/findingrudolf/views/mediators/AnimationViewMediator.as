/**
 * Created by russellmilburn on 04/11/15.
 */
package com.tro.findingrudolf.views.mediators
{

	import com.tro.findingrudolf.events.AnimationFactoryEvent;
	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.interfaces.IAnimationClip;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.models.CommsModel;
	import com.tro.findingrudolf.models.vos.DataPacketVo;
	import com.tro.findingrudolf.views.AnimationView;
	import com.tro.findingrudolf.views.animations.AbstractAnimation;
	import com.tro.findingrudolf.views.animations.AnimationClipEvent;

	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;

	public class AnimationViewMediator extends BaseMediator
	{
		
		[Inject]
		public var view:AnimationView;

		[Inject]
		public var clockModel:ClockModel;


		private var currentAnim:IAnimationClip;

		public function AnimationViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
			
			addContextListener(AnimationFactoryEvent.ON_CREATE_ANIMATION, onCreateAnimation);
			
			addContextListener(ClockModelEvent.ON_DAY_START, onFirstClockUpdate);
			addContextListener(ClockModelEvent.ON_NIGHT_START, onFirstClockUpdate);

			addContextListener(ClockModelEvent.ON_DUSK_START, onDuskStart);
			addContextListener(ClockModelEvent.ON_DAWN_END, onDawnEnd);
			
			view.addEventListener(AnimationClipEvent.SET_BRANCH_VISIBILITY, onBranchVisibility);

			view.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		}

		private function onFirstClockUpdate(event : ClockModelEvent):void
		{
			setLampsAndSignState();
		}

		private function setLampsAndSignState() : void
		{
			removeContextListener(ClockModelEvent.ON_DAY_START, onFirstClockUpdate);
			removeContextListener(ClockModelEvent.ON_NIGHT_START, onFirstClockUpdate);

			if (clockModel.isDay)
			{
				view.lamps.pause();
				view.lamps.movieClip.visible = false;
				view.litSign.pause();
				view.litSign.movieClip.visible = false;
			}
			else
			{
				view.lamps.play();
				view.lamps.movieClip.visible = true;
				view.litSign.play();
				view.litSign.movieClip.visible = true;
			}
		}
		
		private function onDawnEnd(event:ClockModelEvent):void
		{
			logger.info("onDawnEnd");
			view.lamps.pause();
			view.lamps.movieClip.visible = false;
			view.litSign.pause();
			view.litSign.movieClip.visible = false;
		}
		
		private function onDuskStart(event:ClockModelEvent):void
		{
			logger.info("onDuskStart");
			view.lamps.play();
			view.lamps.movieClip.visible = true;
			view.litSign.play();
			view.litSign.movieClip.visible = true;
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var evt:AppEvent = new AppEvent(AppEvent.CREATE_INTERACTIVE_ANIMATION);
			var data:DataPacketVo = new DataPacketVo();
			
			if (event.keyCode == 49)
			{
				data.touch_ID = 1;
				data.device_ID = CommsModel.DEVICE1;
			}
			else if (event.keyCode == 50)
			{
				
				data.touch_ID = 1;
				data.device_ID = CommsModel.DEVICE2;
			}
			else if (event.keyCode == 51)
			{
				data.touch_ID = 1;
				data.device_ID = CommsModel.DEVICE3;
			}
			else if (event.keyCode == 90)
			{
				dispatch(new AppEvent(AppEvent.TOGGLE_CLOCK_SPEED));
				return;
			}

			else
			{
				return;
			}
			
			evt.data = data;
			dispatch(evt);
		}
		
		private function onCreateAnimation(event:AnimationFactoryEvent):void
		{
			currentAnim = event.anim;
			
			if (currentAnim.isScripted() == true)
			{
				addScriptedAnim(currentAnim);
				currentAnim.addEventListener(AnimationClipEvent.ANIMATION_COMPLETE, onScriptedAnimationComplete);
			}
			
			if (currentAnim.isScripted() == false)
			{
				addMovieClip(currentAnim);
				currentAnim.addEventListener(AnimationClipEvent.ANIMATION_COMPLETE, onAnimationComplete);
			}
		}
		
		private function onScriptedAnimationComplete(event:AnimationClipEvent):void
		{
			var anim:IAnimationClip = IAnimationClip(event.currentTarget);
			anim.removeEventListeners();
			Starling.juggler.remove(anim.movieClip);
			fadeOut(Sprite(anim), anim);
		}
		
		private function onAnimationComplete(event:AnimationClipEvent):void
		{
			var anim:IAnimationClip = IAnimationClip(event.currentTarget);
			anim.removeEventListeners();
			Starling.juggler.remove(anim.movieClip);
			fadeOut(anim.movieClip, anim);
		}
		
		private function fadeOut(displayObject:DisplayObject, animation:IAnimationClip):void
		{
			var tween:Tween = new Tween(displayObject, 1);
			tween.fadeTo(0);
			tween.onComplete = disposeAnimation;
			tween.onCompleteArgs = [animation];
			Starling.juggler.add(tween);
		}
		
		private function disposeAnimation(anim:IAnimationClip):void
		{
			var target:IAnimationClip = IAnimationClip(anim);

			target.removeEventListeners();
			target.dispose();
			target.removeFromParent(true);

			var evt : AppEvent = new AppEvent(AppEvent.INTERACTIVE_ANIMATION_COMPLETE);
			evt.animationId = target.assetID;
			dispatch(evt);
		}
		
		private function addMovieClip(anim:IAnimationClip):void
		{
			getLayerSprite(anim.layerId).addChild(anim.movieClip);
			anim.movieClip.play();
		}
		
		private function addScriptedAnim(anim:IAnimationClip):void
		{
			getLayerSprite(anim.layerId).addChild(Sprite(anim));
			anim.movieClip.play();
		}
		
		private function getLayerSprite(id:String):Sprite
		{
			if (id == AbstractAnimation.BACK_LAYER)
			{
				return view.background;
			}
			else if (id == AbstractAnimation.MID_LAYER)
			{
				return view.midground;
			}
			else if (id == AbstractAnimation.FRONT_LAYER)
			{
				return view.foreground;
			}
			return null;
		}
		
		private function onBranchVisibility(event:AnimationClipEvent):void
		{
			view.branch.visible = event.isBranchVisible;
		}
	}
}
