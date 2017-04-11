/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.views.mediators
{

	import com.tro.findingrudolf.models.AssetLoaderModel;
	import flash.events.IEventDispatcher;

	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	public class BaseMediator extends StarlingMediator
	{
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var assetLoaderModel:AssetLoaderModel;

		public function BaseMediator()
		{
			super();
		}
		
		
	}
}
