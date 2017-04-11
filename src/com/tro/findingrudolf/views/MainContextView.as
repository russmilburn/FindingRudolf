/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.views
{
	import com.tro.findingrudolf.Config;
	import com.tro.findingrudolf.ConfigComplete;
	import flash.display.Shape;
	import flash.display.StageDisplayState;
	import flash.ui.Mouse;
	import starling.events.ResizeEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;
	
	import starling.core.Starling;
	
	public class MainContextView extends Sprite
	{
		private var _starlingUI:Starling;
		private var _context:IContext;
		private var _viewPort:Rectangle;
		private var shapeScaler:Shape;
		
		public function MainContextView()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			mouseChildren = false;
			mouseEnabled = false;
			Mouse.hide();
			
			initStarling();
			
			initFramework();
		}
		
		private function initFramework():void
		{
			_context = new Context();
			_context.logLevel = LogLevel.DEBUG;
			_context.install(MVCSBundle, StarlingViewMapExtension).configure(Config, ConfigComplete).configure(_starlingUI, new ContextView(this));
		}
		
		private function initStarling():void
		{
			_viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			shapeScaler = new Shape();
			shapeScaler.graphics.beginFill(0);
			shapeScaler.graphics.drawRect(_viewPort.x, _viewPort.y, _viewPort.width, _viewPort.height);
			shapeScaler.graphics.endFill();
			
			Starling.handleLostContext = true;
			
			_starlingUI = new Starling(StarlingContextView, stage, _viewPort, null, "auto", "standard");
			//_starlingUI.showStatsAt("left", "top", 5);
			
			Starling.current.stage.addEventListener(ResizeEvent.RESIZE, starlingStageResizeListener);
			
			_starlingUI.simulateMultitouch = false;
			_starlingUI.antiAliasing = 0;
			_starlingUI.start();
			
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		private function starlingStageResizeListener(event:ResizeEvent):void
		{
			starlingStageResize(event.width, event.height);
		}
		
		private function starlingStageResize(_width:Number, _height:Number):void 
		{
			shapeScaler.width = _width;
			shapeScaler.height = _height;
 
			// choose the larger scale property and match the other to it;
			if (shapeScaler.scaleX < shapeScaler.scaleY)
			{
				shapeScaler.scaleY = shapeScaler.scaleX
			} else {
				shapeScaler.scaleX = shapeScaler.scaleY;
			}
				
			// choose the smaller scale property and match the other to it;
			if ( shapeScaler.scaleX > shapeScaler.scaleY ) 
			{
				shapeScaler.scaleY = shapeScaler.scaleX;
			} else {
				shapeScaler.scaleX = shapeScaler.scaleY;
			}
			
			//Starling.current.viewPort = new Rectangle((_width - shapeScaler.width)/2,(_height - shapeScaler.height)/2,shapeScaler.width,shapeScaler.height);
			
			// Sydney's Central Feature
			//Starling.current.viewPort = new Rectangle(_width * 0.075, 0, _width * 0.85, _height * 0.8590625); // old
			//Starling.current.viewPort = new Rectangle(_width * 0.075, 0, _width * 0.85, _height * 0.859375); // new			
			
			// choose the smaller scale property and match the other to it;
			
			//Uncommenting these lines destroys the scaling capability completely, does not keep things in perspective...
			//Starling.current.stage.stageWidth = shapeScaler.width;
			//Starling.current.stage.stageHeight = shapeScaler.height;
			
			// Auto fit any resolution.
			Starling.current.viewPort = new Rectangle(0, 0, _width, _height);
			
			trace('stage resized to:', _width,_height,' and viewPort resized to',shapeScaler.width,shapeScaler.height);
		}
	}
}
