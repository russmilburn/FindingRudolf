/**
 * Created by russellmilburn on 06/11/15.
 */
package com.tro.findingrudolf.commands
{

	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.models.AnimationFactory;

	public class CreateRandomAnimationCommand extends BaseCommand
	{
		[Inject]
		public var event:AppEvent;

		[Inject]
		public var animationFactory:AnimationFactory;

		public function CreateRandomAnimationCommand()
		{
			super();
		}


		override public function execute():void
		{
			super.execute();

			var animations:Array = animationFactory.randomAnimations;

			if (animations.length == 0)
			{
				animations = animationFactory.generateRandomAnimationsInOrder().slice();
				animationFactory.randomAnimations = animations;
			}
			//logger.info(animations[0]);

			animationFactory.createRandomAnimation(animations.shift());

		}
	}
}
