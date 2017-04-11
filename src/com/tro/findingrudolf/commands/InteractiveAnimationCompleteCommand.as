/**
 * Created by russellmilburn on 09/11/15.
 */
package com.tro.findingrudolf.commands
{

	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.models.AnimationFactory;
	import com.tro.findingrudolf.views.animations.AnimationList;

	public class InteractiveAnimationCompleteCommand extends BaseCommand
	{
		[Inject]
		public var event : AppEvent;

		[Inject]
		public var animationFactory : AnimationFactory;


		public function InteractiveAnimationCompleteCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			var id : String = event.animationId;

			if (id.search(AnimationList.BOOK + "1") !=  -1)
			{
				animationFactory.isPlayingRed = false;
			}
			else if (id.search(AnimationList.BOOK + "2") !=  -1)
			{
				animationFactory.isPlayingGreen = false;
			}
			else if (id.search(AnimationList.BOOK + "3") !=  -1)
			{
				animationFactory.isPlayingBlue = false;
			}

		}


	}
}
