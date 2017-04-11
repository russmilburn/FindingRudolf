/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.commands
{
	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.models.CommsModel;
	import com.tro.findingrudolf.models.TownLightsModel;
	import com.tro.findingrudolf.models.vos.InteractionDataVo;


	public class StartUpCompleteCommand extends BaseCommand
	{
		[Inject]
		public var townLightsModel:TownLightsModel; 
		
		[Inject]
		public var commsModel:CommsModel;
		
		public function StartUpCompleteCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			logger.debug("COMMAND: Execute");

			townLightsModel.init();
		
			//commsModel.testAnimation();
			
			dispatch(new AppEvent(AppEvent.START_CLOCK));



		}
	}
}
