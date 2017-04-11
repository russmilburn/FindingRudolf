package com.tro.findingrudolf.views.animations
{

	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * ...
	 * @author Andrew Day
	 */
	public class SnowLandsOnElf extends AnimationClip 
	{
		
		public function SnowLandsOnElf(textures:Vector.<Texture>, fps:Number=12) 
		{
			super(textures, fps);
			
			_isScripted = true;

			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init); 
			
			addChild(movieClip);


			var evt:AnimationClipEvent = new AnimationClipEvent(AnimationClipEvent.SET_BRANCH_VISIBILITY, true);
			evt.isBranchVisible = false;
			dispatchEvent(evt);
		}
		
		override protected function onMovieClipComplete(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init); 
			
			var evt:AnimationClipEvent = new AnimationClipEvent(AnimationClipEvent.SET_BRANCH_VISIBILITY, true);
			evt.isBranchVisible = true;
			dispatchEvent(evt);
			
			onAnimationComplete();
		}
	}
}