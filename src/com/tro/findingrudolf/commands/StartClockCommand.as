/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.commands
{
	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.models.ClockModel;


	public class StartClockCommand extends BaseCommand
	{
		[Inject]
		public var clockModel:ClockModel;
		
		public function StartClockCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			//logger.debug("COMMAND: Execute");
			
			clockModel.startTimer();


		}
	}
}
