/**
 * Created by russellmilburn on 09/11/15.
 */
package com.tro.findingrudolf.commands
{

	import com.tro.findingrudolf.models.ClockModel;

	public class ToggleClockSpeedCommand extends BaseCommand
	{
		[Inject]
		public var clockModel : ClockModel;


		public function ToggleClockSpeedCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			if (clockModel.isDebugClock == false)
			{
				clockModel.isDebugClock = true;
			}
			else
			{
				clockModel.isDebugClock = false;
			}
		}
	}
}
