/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.events
{

	import flash.events.Event;

	public class AssetLoaderModelEvent extends Event
	{
		public static const ON_START_LOAD_ASSETS : String = "onStartLoadAssets";
		public static const ON_COMPLETE_LOAD_ASSETS : String = "onCompleteLoadAssets";

		public function AssetLoaderModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			var evt : AssetLoaderModelEvent  = new AssetLoaderModelEvent(type, bubbles, cancelable);
			return evt;
		}
	}
}
