/**
 * Created by russellmilburn on 27/10/15.
 */
package com.tro.findingrudolf.interfaces
{

	import starling.display.MovieClip;

	public interface IAnimationClip
	{
		function get assetID() : String;
		function set assetID(value : String) : void;
		function set frameRate(value : Number) : void;
		function get frameRate() : Number;
		function play():void;
		function pause():void;
		function stop():void;
		function isScripted() : Boolean;
		function get isLayerDependent() : Boolean;
		function set isLayerDependent(value : Boolean) : void;
		function hasSound() : Boolean;
		function get layerId() : String;
		function set layerId(value : String) : void;
		function get loop():Boolean
		function set loop(value:Boolean):void
		function set movieClip(value : MovieClip) : void
		function get movieClip() : MovieClip;
		function addEventListener(type:String, listener:Function):void
		function removeEventListener(type:String, listener:Function):void
		function removeEventListeners(type:String = null):void
		function removeFromParent(dispose:Boolean = false):void
		function dispose():void
	}
}
