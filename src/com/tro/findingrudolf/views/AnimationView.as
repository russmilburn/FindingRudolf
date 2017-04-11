package com.tro.findingrudolf.views 
{
	import com.tro.findingrudolf.events.ViewEvent;
	import com.tro.findingrudolf.interfaces.IAnimationClip;
	import com.tro.findingrudolf.views.animations.AbstractAnimation;
	import com.tro.findingrudolf.views.animations.AnimationClip;
	import com.tro.findingrudolf.views.animations.AnimationList;


	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class AnimationView extends View 
	{
		private var _background : Sprite;
		private var _midground : Sprite;
		private var _foreground : Sprite;

		private var _snowman : Sprite;
		private var _bump : Sprite;
		private var _leftBush : Sprite;
		private var _rightBush : Sprite;
		private var _log : Sprite;
		private var _sign : Sprite;
		private var _tree : Sprite;
		private var _branch : Sprite;
		private var _lamps : AnimationClip;
		private var _litSign : AnimationClip;

		public function AnimationView()
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
			_branch = getTexturesSprite("Static_SnowBranch");
			_branch.x = -10;
			addChild(_branch);

			background = new Sprite();
			midground = new Sprite();
			foreground = new Sprite();


			_lamps = new AnimationClip(assetManager.getTextures(AnimationList.R1_10));
			_lamps.movieClip.visible = false;
			_lamps.frameRate = 6;
			_litSign = new AnimationClip(assetManager.getTextures(AnimationList.R1_08));
			_lamps.movieClip.visible = false;

			_snowman = getTexturesSprite("Static_Snowman");
			_bump = getTexturesSprite("Static_SnowMound");
			_leftBush = getTexturesSprite("Static_BushLeft");
			_rightBush = getTexturesSprite("Static_BushRight");

			_log = getTexturesSprite("Static_Log");
			_sign = getTexturesSprite("Static_Sign");
			_tree = getTexturesSprite("Static_SmallTreeDay_01");

			addChild(_lamps.movieClip);

			addChild(background);

			addChild(_sign);
			addChild(_litSign.movieClip);
			addChild(midground);
			addChild(foreground);

			midground.addChild(_log);

			midground.addChild(_tree);
			midground.addChild(_snowman);

			foreground.addChild(_bump);

			addChild(_leftBush);
			addChild(_rightBush);

		}



		public function get background():Sprite
		{
			return _background;
		}

		public function set background(value:Sprite):void
		{
			_background = value;
		}

		public function get midground():Sprite
		{
			return _midground;
		}

		public function set midground(value:Sprite):void
		{
			_midground = value;
		}

		public function get foreground():Sprite
		{
			return _foreground;
		}

		public function set foreground(value:Sprite):void
		{
			_foreground = value;
		}


		public function get branch():Sprite
		{
			return _branch;
		}

		public function set branch(value:Sprite):void
		{
			_branch = value;
		}


		public function get lamps():AnimationClip
		{
			return _lamps;
		}

		public function set lamps(value:AnimationClip):void
		{
			_lamps = value;
		}


		public function get litSign():AnimationClip
		{
			return _litSign;
		}

		public function set litSign(value:AnimationClip):void
		{
			_litSign = value;
		}
	}
}