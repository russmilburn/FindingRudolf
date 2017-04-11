package com.tro.findingrudolf.models
{
	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.events.NetSocketEvent;
	import com.tro.findingrudolf.models.services.NetSocket;
	import com.tro.findingrudolf.models.vos.DataPacketVo;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class CommsModel extends BaseModel
	{
		private var netSocket:NetSocket;
		
		public static const DEVICE1:int = 100;
		public static const DEVICE2:int = 101;
		public static const DEVICE3:int = 102;
		
		private const easterEggDelay:Number = 1000;
		private var heartbeatTimer:Timer;
		
		private var device1Timer:Timer;
		private var device2Timer:Timer;
		private var device3Timer:Timer;
		
		public function CommsModel()
		{
			super();
		}
		
		public function init():void
		{
			netSocket = new NetSocket("0.0.0.0", 3121);
			netSocket.addEventListener(NetSocketEvent.NEW_DATA, newData);
			
			device1Timer = new Timer(easterEggDelay, 1);
			device2Timer = new Timer(easterEggDelay, 1);
			device3Timer = new Timer(easterEggDelay, 1);
			
			heartbeatTimer = new Timer(10000, 0);
			heartbeatTimer.addEventListener(TimerEvent.TIMER, heartbeatHandler);
			heartbeatTimer.start();
		}
		
		public function testAnimation():void
		{
			var evt:NetSocketEvent;
			var vo:DataPacketVo;
			
			evt = new NetSocketEvent(NetSocketEvent.NEW_DATA);
			vo = new DataPacketVo();
			vo.device_ID = 100;
			evt.data = vo;
			
			newData(evt);
			
			evt = new NetSocketEvent(NetSocketEvent.NEW_DATA);
			vo = new DataPacketVo();
			vo.device_ID = 101;
			evt.data = vo;
			
			newData(evt);
			
			evt = new NetSocketEvent(NetSocketEvent.NEW_DATA);
			vo = new DataPacketVo();
			vo.device_ID = 102;
			evt.data = vo;
			
			newData(evt);
		}
		
		private function handleDeviceTimer():void
		{
			logger.info("handleDeviceTimer()");
			
			if (device1Timer.running && device2Timer.running && device3Timer.running)
			{
				logger.info("AppEvent.TRIGGER_EASTER_EGG");
				
				device1Timer.reset();
				device2Timer.reset();
				device3Timer.reset();
				
				var evt:AppEvent = new AppEvent(AppEvent.TRIGGER_EASTER_EGG);
				dispatch(evt);
			}
		}
		
		private function newData(e:NetSocketEvent):void
		{
			logger.info("Received new data: " + e.data.device_ID);
			//+ " " + e.data.touched +" " + e.data.touch_ID + " " + e.data.message);
			
			if (e.data.touched)
			{
				var evt:AppEvent = new AppEvent(AppEvent.CREATE_INTERACTIVE_ANIMATION);
				evt.data = e.data;
				dispatch(evt);
			}			
			
			switch (e.data.device_ID)
			{
			case DEVICE1: 
				device1Timer.reset();
				device1Timer.start();
				break;
			
			case DEVICE2: 
				device2Timer.reset();
				device2Timer.start();
				break;
			
			case DEVICE3: 
				device3Timer.reset();
				device3Timer.start();
				break;
			
			default: 
				logger.info("Default Net Socket :" + e.data.device_ID);
				break;
			}
			
			handleDeviceTimer();		
		}
		
		private function heartbeatHandler(e:TimerEvent):void 
		{
			var data:DataPacketVo = new DataPacketVo();
			data.heartbeat = true;
			netSocket.sendToAll(data);
		}
	}
}