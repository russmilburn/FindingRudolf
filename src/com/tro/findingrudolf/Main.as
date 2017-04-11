package com.tro.findingrudolf {

    import com.tro.findingrudolf.views.MainContextView;

    import flash.display.Sprite;
    import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
    import flash.events.Event;

	import starling.display.Stage;

	public class Main extends Sprite
	{
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var mainContextView : MainContextView = new MainContextView();
			addChild(mainContextView);
		}
	}
}
