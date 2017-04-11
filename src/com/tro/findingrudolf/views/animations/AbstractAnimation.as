/**
 * Created by russellmilburn on 27/10/15.
 */
package com.tro.findingrudolf.views.animations
{

	import com.tro.findingrudolf.interfaces.IAnimationClip;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class AbstractAnimation extends Sprite implements IAnimationClip
	{
		public static const BACK_LAYER : String = "back";
		public static const MID_LAYER : String = "mid";
		public static const FRONT_LAYER : String = "front";

		protected var _movieClip : MovieClip;
		protected var _isScripted : Boolean;
		protected var _assetId : String;
		protected var _isLayerDependent : Boolean;
		protected var _layerId : String;
		protected var _hasSound : Boolean = false;

		public function AbstractAnimation(textures:Vector.<Texture>=null, fps:Number=12)
		{
			super();
			if (textures != null)
			{
				movieClip = new MovieClip(textures, fps);
				Starling.juggler.add(movieClip);
				movieClip.addEventListener(Event.COMPLETE, onMovieClipComplete);
			}

		}

		protected function onMovieClipComplete(event:Event):void
		{
			movieClip.removeEventListener(Event.COMPLETE, onMovieClipComplete);
			onAnimationComplete();
		}

		protected function onAnimationComplete() : void
		{
			dispatchEvent(new AnimationClipEvent(AnimationClipEvent.ANIMATION_COMPLETE));
		}


		override public function dispose():void
		{
			super.dispose();
			Starling.juggler.remove(_movieClip);
			_movieClip.dispose();
			_movieClip.removeFromParent(true);

		}

		public function set assetID(value:String):void
		{
			_assetId = value;
		}

		public function get assetID():String
		{
			return _assetId;
		}

		public function set frameRate(value:Number):void
		{
			movieClip.fps = value;
		}

		public function get frameRate():Number
		{
			return movieClip.fps;
		}

		public function isScripted():Boolean
		{
			return _isScripted;
		}

		public function get isLayerDependent():Boolean
		{
			return _isLayerDependent;
		}

		public function set isLayerDependent(value:Boolean) : void
		{
			_isLayerDependent = true;
		}

		public function hasSound():Boolean
		{
			return _hasSound;
		}

		public function get layerId():String
		{
			return _layerId;
		}

		public function set layerId(value:String):void
		{
			_layerId = value;
		}


		public function get movieClip():MovieClip
		{
			return _movieClip;
		}

		public function set movieClip(value:MovieClip):void
		{
			_movieClip = value;
		}

		public function play():void
		{
			movieClip.play();
		}

		public function pause():void
		{
			movieClip.pause();
		}

		public function stop():void
		{
			movieClip.stop();
		}

		public function get loop():Boolean
		{
			return movieClip.loop;
		}

		public function set loop(value:Boolean):void
		{
			movieClip.loop = value;
		}
	}
}
