package com.tro.findingrudolf.views.animations
{

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * ...
	 * @author Andrew Day
	 */
	public class ElvesWindowSinging extends AnimationClip 
	{
		private var movieClipA : MovieClip;
		private var movieClipB : MovieClip;
		private var movieClipC : MovieClip;
		private var movieClipD : MovieClip;
		private var movieClipE : MovieClip;
		private var movieClipF : MovieClip;
		
		public function ElvesWindowSinging(textures:Vector.<Texture> = null, fps:Number=12) 
		{
			super(textures, fps);
			
			_isScripted = true;
			
			if (movieClip.stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init); 
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init); 
			addChild(movieClip);
		}
		
		public function createAnimations(allTextures:Vector.<Vector.<Texture>>):void
		{
			movieClipA = new MovieClip(allTextures[0], frameRate);
			movieClipB = new MovieClip(allTextures[1], frameRate);
			movieClipC = new MovieClip(allTextures[2], frameRate);
			movieClipD = new MovieClip(allTextures[3], frameRate);
			movieClipE = new MovieClip(allTextures[4], frameRate);
			movieClipF = new MovieClip(allTextures[5], frameRate);
			
			addChild(movieClipA);
			addChild(movieClipB);
			addChild(movieClipC);
			addChild(movieClipD);
			addChild(movieClipE);
			addChild(movieClipF);
			
			Starling.juggler.add(movieClipA);
			Starling.juggler.add(movieClipB);
			Starling.juggler.add(movieClipC);
			Starling.juggler.add(movieClipD);
			Starling.juggler.add(movieClipE);
			Starling.juggler.add(movieClipF);

		}
		
		
		override public function dispose():void
		{	
			Starling.juggler.remove(movieClipA);
			Starling.juggler.remove(movieClipB);
			Starling.juggler.remove(movieClipC);
			Starling.juggler.remove(movieClipD);
			Starling.juggler.remove(movieClipE);
			Starling.juggler.remove(movieClipF);
			
			movieClipA.dispose();
			movieClipB.dispose();
			movieClipC.dispose();
			movieClipD.dispose();
			movieClipE.dispose();
			movieClipF.dispose();
			
			super.dispose();
		}
		
		
		override public function get loop():Boolean
		{
			return super.loop;
		}
		
		override public function set loop(value:Boolean):void
		{
			//movieClip.loop = value;
			super.loop = value;
			movieClipA.loop = value;
			movieClipB.loop = value;
			movieClipC.loop = value;
			movieClipD.loop = value;
			movieClipE.loop = value;
			movieClipF.loop = value;
		}
		
		override public function play():void
		{
			super.play();

			movieClipA.play();
			movieClipB.play();
			movieClipC.play();
			movieClipD.play();
			movieClipE.play();
			movieClipF.play();
		}
		
		override public function pause():void
		{
			super.pause();
			movieClipA.pause();
			movieClipB.pause();
			movieClipC.pause();
			movieClipD.pause();
			movieClipE.pause();
			movieClipF.pause();
		}
		
		override public function stop():void
		{
			super.stop();
			movieClipA.stop();
			movieClipB.stop();
			movieClipC.stop();
			movieClipD.stop();
			movieClipE.stop();
			movieClipF.stop();
		}
		
		override public function set frameRate(value:Number):void
		{
			super.frameRate = value;
			movieClipA.fps = value;
			movieClipB.fps = value;
			movieClipC.fps = value;
			movieClipD.fps = value;
			movieClipE.fps = value;
			movieClipF.fps = value;
		}
	}
}