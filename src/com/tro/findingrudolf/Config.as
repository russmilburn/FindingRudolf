/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf
{

	import com.tro.findingrudolf.commands.CreateInteractiveAnimationCommand;
	import com.tro.findingrudolf.commands.CreateRandomAnimationCommand;
	import com.tro.findingrudolf.commands.InteractiveAnimationCompleteCommand;
	import com.tro.findingrudolf.commands.StartClockCommand;
	import com.tro.findingrudolf.commands.StartUpCommand;
	import com.tro.findingrudolf.commands.StartUpCompleteCommand;
	import com.tro.findingrudolf.commands.ToggleClockSpeedCommand;
	import com.tro.findingrudolf.commands.TurnTownLightsOffCommand;
	import com.tro.findingrudolf.commands.TurnTownLightsOnCommand;
	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.models.AnimationFactory;
	import com.tro.findingrudolf.models.AssetLoaderModel;
	import com.tro.findingrudolf.models.ClockModel;
	import com.tro.findingrudolf.models.CommsModel;
	import com.tro.findingrudolf.models.FloxModel;
	import com.tro.findingrudolf.models.TownLightsModel;
	import com.tro.findingrudolf.views.AnimationView;
	import com.tro.findingrudolf.views.CloudView;
	import com.tro.findingrudolf.views.LunarView;
	import com.tro.findingrudolf.views.MountainView;
	import com.tro.findingrudolf.views.AtmosphereView;
	import com.tro.findingrudolf.views.SkyView;
	import com.tro.findingrudolf.views.SnowView;
	import com.tro.findingrudolf.views.StarView;
	import com.tro.findingrudolf.views.StarlingContextView;
	import com.tro.findingrudolf.views.TownLightsView;
	import com.tro.findingrudolf.views.TownView;
	import com.tro.findingrudolf.views.TwilightView;
	import com.tro.findingrudolf.views.mediators.AnimationViewMediator;
	import com.tro.findingrudolf.views.mediators.CloudViewMediator;
	import com.tro.findingrudolf.views.mediators.LunarViewMediator;
	import com.tro.findingrudolf.views.mediators.MountainViewMediator;
	import com.tro.findingrudolf.views.mediators.AtmosphereViewMediator;
	import com.tro.findingrudolf.views.mediators.SkyViewMediator;
	import com.tro.findingrudolf.views.mediators.SnowViewMediator;
	import com.tro.findingrudolf.views.mediators.StarViewMediator;
	import com.tro.findingrudolf.views.mediators.StarlingContextViewMediator;
	import com.tro.findingrudolf.views.mediators.TownLightsViewMediator;
	import com.tro.findingrudolf.views.mediators.TownViewMediator;
	import com.tro.findingrudolf.views.mediators.TwilightViewMediator;

	import flash.events.IEventDispatcher;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.ILogger;

	public class Config implements IConfig
	{
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var injector:IInjector;
		
		public function Config()
		{
		
		}
		
		public function configure():void
		{
			logger.debug("CONFIG: configure");
			
			//Map The models
			injector.map(AssetLoaderModel).asSingleton();
			injector.map(ClockModel).asSingleton();
			injector.map(TownLightsModel).asSingleton();
			injector.map(AnimationFactory).asSingleton();
			injector.map(CommsModel).asSingleton();
			injector.map(FloxModel).asSingleton();
			
			//Map Commands
			commandMap.map(AppEvent.START_UP, AppEvent).toCommand(StartUpCommand);
			commandMap.map(AppEvent.START_UP_COMPLETE, AppEvent).toCommand(StartUpCompleteCommand);
			commandMap.map(AppEvent.START_CLOCK, AppEvent).toCommand(StartClockCommand);
			commandMap.map(AppEvent.CREATE_INTERACTIVE_ANIMATION, AppEvent).toCommand(CreateInteractiveAnimationCommand);
			commandMap.map(AppEvent.CREATE_RANDOM_ANIMATION, AppEvent).toCommand(CreateRandomAnimationCommand);
			commandMap.map(AppEvent.INTERACTIVE_ANIMATION_COMPLETE, AppEvent).toCommand(InteractiveAnimationCompleteCommand);
			commandMap.map(AppEvent.TOGGLE_CLOCK_SPEED, AppEvent).toCommand(ToggleClockSpeedCommand);

			commandMap.map(ClockModelEvent.ON_DUSK_START).toCommand(TurnTownLightsOnCommand);
			commandMap.map(ClockModelEvent.ON_DAWN_END).toCommand(TurnTownLightsOffCommand);
			
			//Map View to Mediators
			mediatorMap.map(StarlingContextView).toMediator(StarlingContextViewMediator);
			mediatorMap.map(StarView).toMediator(StarViewMediator);
			mediatorMap.map(TownView).toMediator(TownViewMediator);
			mediatorMap.map(SkyView).toMediator(SkyViewMediator);
			mediatorMap.map(TwilightView).toMediator(TwilightViewMediator);
			mediatorMap.map(TownLightsView).toMediator(TownLightsViewMediator);
			mediatorMap.map(LunarView).toMediator(LunarViewMediator);
			mediatorMap.map(MountainView).toMediator(MountainViewMediator);
			mediatorMap.map(CloudView).toMediator(CloudViewMediator);
			mediatorMap.map(SnowView).toMediator(SnowViewMediator);
			mediatorMap.map(AtmosphereView).toMediator(AtmosphereViewMediator);
			mediatorMap.map(AnimationView).toMediator(AnimationViewMediator);
		}
	}
}
