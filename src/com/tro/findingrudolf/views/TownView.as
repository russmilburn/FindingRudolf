package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.views.animations.ElfzillaAnimation;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TownView extends View 
	{
		private var townDay:Image;
		private var _townNight:Image;
		
		private var _elfzilla:ElfzillaAnimation;
		
		private var _smallLight1:Image;
		private var _smallLight2:Image;
		private var _smallLight3:Image;
		
		public function TownView() 
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
			elfzilla = new ElfzillaAnimation(assetManager.getTexture("elfzilla_body"), assetManager.getTextures("EZ_Arm"), assetManager.getTexture("elfzilla_right_arm"), assetManager.getTexture("elfzilla_head_01"), assetManager.getTexture("elfzilla_head_02"));
			addChild(elfzilla);
			
			townDay = new Image(assetManager.getTexture("Static_WholeTownDay"));
			addChild(townDay);
			
			_townNight = new Image(assetManager.getTexture("Static_WholeTownNight"));
			_townNight.alpha = 0;
			addChild(_townNight);
			
			_smallLight1 = new Image(assetManager.getTexture("Light_Pole01"));
			_smallLight1.visible = false;
			addChild(_smallLight1);
			
			_smallLight2 = new Image(assetManager.getTexture("Light_Pole02"));
			_smallLight2.visible = false;
			addChild(_smallLight2);
			
			_smallLight3 = new Image(assetManager.getTexture("Light_Pole03"));
			_smallLight3.visible = false;
			addChild(_smallLight3);
		}
		
		public function get townNight():Image 
		{
			return _townNight;
		}
		
		public function set townNight(value:Image):void 
		{
			_townNight = value;
		}
		
		public function get smallLight1():Image 
		{
			return _smallLight1;
		}
		
		public function set smallLight1(value:Image):void 
		{
			_smallLight1 = value;
		}
		
		public function get smallLight2():Image 
		{
			return _smallLight2;
		}
		
		public function set smallLight2(value:Image):void 
		{
			_smallLight2 = value;
		}
		
		public function get smallLight3():Image 
		{
			return _smallLight3;
		}
		
		public function set smallLight3(value:Image):void 
		{
			_smallLight3 = value;
		}
		
		public function get elfzilla():ElfzillaAnimation 
		{
			return _elfzilla;
		}
		
		public function set elfzilla(value:ElfzillaAnimation):void 
		{
			_elfzilla = value;
		}
	}
}