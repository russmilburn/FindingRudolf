package com.tro.findingrudolf.views.mediators 
{
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.views.CloudView;
	import com.tro.findingrudolf.views.components.Cloud;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class CloudViewMediator extends BaseMediator 
	{
		[Inject]
		public var view:CloudView;
		
		
		private var _cloud:Cloud;
		
		private var _currentLeftCloud:Cloud;
		private var _currentRightCloud:Cloud;
		
		private var baseSpeed:Number = 1;
		
		private var cloudTextureVector:Vector.<Texture> = new <Texture>[];
		
		private var backgroundCloudVector:Vector.<Cloud> = new <Cloud>[];
		private var midgroundCloudVector:Vector.<Cloud> = new <Cloud>[];
		private var foregroundCloudVector:Vector.<Cloud> = new <Cloud>[];
		
		private var backgroundClouds:int = 2;
		private var midgroundClouds:int = 2;
		private var foregroundClouds:int = 2;
		
		private var lastBackgroundCloud:Cloud;
		private var lastMidgroundCloud:Cloud;
		private var lastForegroundCloud:Cloud;
		
		private var spedup:Number = 0.5;
		
		public function CloudViewMediator() 
		{
			super();
		}
		
		override public function initialize():void
		{
			view.logger = logger;
			view.assetManager = assetLoaderModel.assetManager;
			
			addContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			addContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			
			addContextListener(ClockModelEvent.ON_DUSK_START, onDuskStart);
			addContextListener(ClockModelEvent.ON_DUSK_END, onDuskEnd);
			
			addContextListener(ClockModelEvent.ON_DAWN_START, onDawnStart);
			addContextListener(ClockModelEvent.ON_DAWN_END, onDawnEnd);
			
			createCloudVector();
			
			addBackgroundClouds();
			addMidgroundClouds();
			addForegroundClouds();
		}
		
		private function createCloudVector():void 
		{
			cloudTextureVector.push(assetLoaderModel.assetManager.getTexture("Static_Clouds01_Day"), assetLoaderModel.assetManager.getTexture("Static_Clouds02_Day"), assetLoaderModel.assetManager.getTexture("Static_Clouds03_Day"));
		}
		
		private function onDayStart(event:ClockModelEvent):void
		{
			removeContextListener(ClockModelEvent.ON_DAY_START, onDayStart);
			
			for (var i:int = 0; i < backgroundCloudVector.length; i++)
			{
				backgroundCloudVector[i].nightCloud.alpha = 0;
				midgroundCloudVector[i].nightCloud.alpha = 0;
				foregroundCloudVector[i].nightCloud.alpha = 0;
			}
		}
		
		private function onNightStart(event:ClockModelEvent):void
		{
			removeContextListener(ClockModelEvent.ON_NIGHT_START, onNightStart);
			
			for (var i:int = 0; i < backgroundCloudVector.length; i++)
			{
				backgroundCloudVector[i].nightCloud.alpha = 1;
				midgroundCloudVector[i].nightCloud.alpha = 1;
				foregroundCloudVector[i].nightCloud.alpha = 1;
			}
		}
		
		private function onDawnStart(event:ClockModelEvent):void 
		{
			addContextListener(ClockModelEvent.ON_TIMER, onDawnTransition);
		}
		
		private function onDawnEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, onDawnTransition);
		}
		
		private function onDuskStart(event:ClockModelEvent):void 
		{
			addContextListener(ClockModelEvent.ON_TIMER, onDuskTransition);
		}
		
		private function onDuskEnd(event:ClockModelEvent):void 
		{
			removeContextListener(ClockModelEvent.ON_TIMER, onDuskTransition);
		}
		
		private function onDawnTransition(event:ClockModelEvent):void 
		{
			for (var i:int = 0; i < backgroundCloudVector.length; i++)
			{
				backgroundCloudVector[i].nightCloud.alpha = 1 - event.twilightLinearPercent;
				midgroundCloudVector[i].nightCloud.alpha = 1 - event.twilightLinearPercent;
				foregroundCloudVector[i].nightCloud.alpha = 1 - event.twilightLinearPercent;
			}
		}
		
		private function onDuskTransition(event:ClockModelEvent):void 
		{
			for (var i:int = 0; i < backgroundCloudVector.length; i++)
			{
				backgroundCloudVector[i].nightCloud.alpha = event.twilightLinearPercent;
				midgroundCloudVector[i].nightCloud.alpha = event.twilightLinearPercent;
				foregroundCloudVector[i].nightCloud.alpha = event.twilightLinearPercent;
			}
		}
		
		private function addBackgroundClouds():void 
		{
			for (var i:Number = 0; i < backgroundClouds; i++)
			{
				_cloud = new Cloud();
				_cloud.setImageTexture(getRandomTexture());
				_cloud.x = xPos(i);
				_cloud.type = "background";
				_cloud.addEventListener(EnterFrameEvent.ENTER_FRAME, moveCloudBackground);
				_cloud.pivotY = _cloud.height * 2;
				_cloud.y = view.stage.stageHeight / 2 + _cloud.height * 1.3;
				_cloud.setNightColour(0x000044);
				backgroundCloudVector.push(_cloud);
				view.addChild(_cloud);
			}
			
			lastBackgroundCloud = backgroundCloudVector[backgroundCloudVector.length - 1];
		}
		
		private function addMidgroundClouds():void 
		{
			for (var i:Number = 0; i < midgroundClouds; i++)
			{
				_cloud = new Cloud();
				_cloud.setImageTexture(getRandomTexture());
				_cloud.scaleImage(0.75);
				_cloud.x = xPos(i);
				_cloud.type = "midground";
				_cloud.addEventListener(EnterFrameEvent.ENTER_FRAME, moveCloudMidground);
				_cloud.pivotY = _cloud.height * 2;
				_cloud.y = view.stage.stageHeight / 2 + _cloud.height * 1.3;
				_cloud.setNightColour(0x000066);
				midgroundCloudVector.push(_cloud);
				view.addChild(_cloud);
			}
			
			lastMidgroundCloud = midgroundCloudVector[midgroundCloudVector.length - 1];
		}
		
		private function addForegroundClouds():void 
		{
			for (var i:Number = 0; i < foregroundClouds; i++)
			{
				_cloud = new Cloud();
				_cloud.setImageTexture(getRandomTexture());
				_cloud.scaleImage(0.5);
				_cloud.x = xPos(i);
				_cloud.type = "foreground";
				_cloud.addEventListener(EnterFrameEvent.ENTER_FRAME, moveCloudForeground);
				_cloud.pivotY = _cloud.height * 2;
				_cloud.y = view.stage.stageHeight / 2 + _cloud.height * 1.3;
				_cloud.setNightColour(0x000088);
				foregroundCloudVector.push(_cloud);
				view.addChild(_cloud);
			}
			
			lastForegroundCloud = foregroundCloudVector[foregroundCloudVector.length - 1];
		}
		
		private function xPos(i:Number):Number
		{
			return (view.stage.stageWidth - _cloud.width) -_cloud.width * i;
		}
		
		private function getRandomTexture():Texture 
		{
			var random:Number = Math.floor(Math.random() * cloudTextureVector.length);
			var texture:Texture = cloudTextureVector[random];
			return texture;
		}
		
		private function moveCloudBackground(event:EnterFrameEvent):void
		{			
			var cloud:Cloud = Cloud(event.target);
			
			cloud.x += (baseSpeed / 10) * spedup;
			
			if (cloud.x > view.stage.stageWidth)
			{
				cloud.x = lastBackgroundCloud.x - cloud.width;
				lastBackgroundCloud = cloud;
			}
		} 
			
		private function moveCloudMidground(event:EnterFrameEvent):void
		{
			var cloud:Cloud = Cloud(event.target);
			
			if (cloud.type === "midground")
			
			cloud.x += (baseSpeed / 7.5) * spedup;
			
			if (cloud.x > view.stage.stageWidth)
			{
				cloud.x = lastMidgroundCloud.x - cloud.width;
				lastMidgroundCloud = cloud;
			}
		}
			
		private function moveCloudForeground(event:EnterFrameEvent):void
		{
			var cloud:Cloud = Cloud(event.target);
			
			cloud.x += (baseSpeed / 5) * spedup;
			
			if (cloud.x > view.stage.stageWidth)
			{
				cloud.x = lastForegroundCloud.x - cloud.width;
				cloud.changeImageTexture(getRandomTexture());
				lastForegroundCloud = cloud;
			}
		}
	}
}