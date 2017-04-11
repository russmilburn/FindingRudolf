/**
 * Created by russellmilburn on 27/10/15.
 */
package com.tro.findingrudolf.commands
{
	
	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.models.AnimationFactory;
	import com.tro.findingrudolf.models.CommsModel;
	import com.tro.findingrudolf.models.FloxModel;
	import com.tro.findingrudolf.models.vos.DataPacketVo;
	
	public class CreateInteractiveAnimationCommand extends BaseCommand
	{
		[Inject]
		public var event:AppEvent;
		
		[Inject]
		public var animationFactory:AnimationFactory;
		
		[Inject]
		public var floxModel:FloxModel;
		
		[Inject]
		public var commsModel:CommsModel;
		
		public function CreateInteractiveAnimationCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			
			logger.debug("Command  : execute");
			
			commsModel.testAnimation();
			
			var dataPacket:DataPacketVo = event.data;
			var animations:Array;
			
			switch (dataPacket.device_ID)
			{
			case 100: 
				animations = animationFactory.redAnimations;

				if (animationFactory.isPlayingRed)
				{
					return;
				}

				if (animations.length == 0)
				{
					animations = animationFactory.generateRedAnimationsInOrder().slice();
					animationFactory.redAnimations = animations;
				}
				break;
			
			case 101: 
				animations = animationFactory.greenAnimations;

				if (animationFactory.isPlayingGreen)
				{
					return;
				}

				if (animations.length == 0)
				{
					animations = animationFactory.generateGreenAnimationsInOrder().slice();
					animationFactory.greenAnimations = animations;
				}
				break;
			case 102: 
				animations = animationFactory.blueAnimations;

				if (animationFactory.isPlayingBlue)
				{
					return;
				}

				if (animations.length == 0)
				{
					animations = animationFactory.generateBlueAnimationsInOrder().slice();
					animationFactory.blueAnimations = animations;
				}
				break;
			
			default: 
				logger.error("Device ID not recognised: " + dataPacket.device_ID);
				return;
				break;
			}
			
			floxModel.trackInteraction(dataPacket.device_ID, String(animations[0]));
			
			animationFactory.createInteractiveAnimation(animations.shift());
		}
	}
}
