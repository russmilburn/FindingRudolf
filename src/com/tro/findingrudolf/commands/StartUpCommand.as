/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.commands
{

	import com.tro.findingrudolf.models.AnimationFactory;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.CommsModel;
	import com.tro.findingrudolf.models.FloxModel;
	
	public class StartUpCommand extends BaseCommand
	{
		[Inject]
		public var assetModel:AssetLoaderModel;
		
		[Inject]
		public var animationFactory:AnimationFactory;
		
		[Inject]
		public var commsModel:CommsModel;
		
		[Inject]
		public var floxModel:FloxModel;
		
		public function StartUpCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			//logger.debug("COMMAND: Execute");
			
			assetModel.loadAssets();
			
			animationFactory.init();
			
			commsModel.init();
			
			floxModel.init("Melbourne Icon");
		}
	}
}
