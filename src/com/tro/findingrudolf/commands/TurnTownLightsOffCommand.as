/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.commands
{
	import com.tro.findingrudolf.models.TownLightsModel;

	public class TurnTownLightsOffCommand extends BaseCommand
	{
		[Inject]
		public var townLightsModel:TownLightsModel;
		
		public function TurnTownLightsOffCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			//logger.debug("COMMAND: Execute");
			
			townLightsModel.turnLightsOff();
		}
	}
}