package com.tro.findingrudolf.models 
{
	import com.tro.findingrudolf.events.TownLightsModelEvent;
	import com.tro.findingrudolf.models.vos.TownLightsVo;
	import com.tro.findingrudolf.views.components.TownLight;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class TownLightsModel extends BaseModel 
	{
		private var townLightsVector:Vector.<TownLightsVo> = new <TownLightsVo>[];
		private var vector:Vector.<TownLightsVo> = new <TownLightsVo>[];
		private var changeLightsTimer:Timer;
		private var lightsOn:Boolean;
		
		public function TownLightsModel() 
		{
			super();
		}
		
		public function init():void
		{
			logger.info("init");
			
			
			createLightVos();
			
			changeLightsTimer = new Timer(randomizeTimer(), townLightsVector.length);
			changeLightsTimer.addEventListener(TimerEvent.TIMER, changeLightsTimerHandler);
			changeLightsTimer.addEventListener(TimerEvent.TIMER_COMPLETE, changeLightsTimerCompleteHandler);
		}
		
		private function createLightVos():void
		{
			townLightsVector.push(getLightsVo(0, 0));
			townLightsVector.push(getLightsVo(0, 1));
			townLightsVector.push(getLightsVo(0, 2));
			townLightsVector.push(getLightsVo(1, 3));
			townLightsVector.push(getLightsVo(1, 4));
			townLightsVector.push(getLightsVo(2, 5));
			townLightsVector.push(getLightsVo(3, 6));
			townLightsVector.push(getLightsVo(3, 7));
			townLightsVector.push(getLightsVo(3, 8));
			townLightsVector.push(getLightsVo(4, 9));
			townLightsVector.push(getLightsVo(4, 10));
			townLightsVector.push(getLightsVo(5, 11));
			townLightsVector.push(getLightsVo(6, 12));
			townLightsVector.push(getLightsVo(6, 13));
			townLightsVector.push(getLightsVo(6, 14));
			townLightsVector.push(getLightsVo(6, 15));
			townLightsVector.push(getLightsVo(6, 16));
			townLightsVector.push(getLightsVo(6, 17));
			townLightsVector.push(getLightsVo(6, 18));
			townLightsVector.push(getLightsVo(6, 19));
		}
		
		private function getLightsVo(houseId:int, lightId:int):TownLightsVo
		{
			var vo:TownLightsVo = new TownLightsVo();
			vo.houseId = houseId;
			vo.lightId = lightId;
			return vo;
		}
		
		private function randomizeArray(arr:Vector.<TownLightsVo>):Vector.<TownLightsVo>
		{
		   var len:int = arr.length;
		   var temp:*;
		   var i:int = len;
		   
		   while (i--)
		   {
			  var rand:int = Math.floor(Math.random() * len);
			  temp = arr[i];
			  arr[i] = arr[rand];
			  arr[rand] = temp;
		   }
		   
		   return arr;
		}
		public function turnLightsOn():void
		{
			vector = randomizeArray(townLightsVector);
			lightsOn = true;
			changeLightsTimer.start();
		}
		
		public function turnLightsOff():void
		{
			vector = randomizeArray(townLightsVector);
			lightsOn = false;
			changeLightsTimer.start();
		}
		
		private function changeLightsTimerHandler(event:TimerEvent):void 
		{
			changeLightsTimer.delay = randomizeTimer();
			
			vector[changeLightsTimer.currentCount - 1].lightsOn = lightsOn;
			
			var evt:TownLightsModelEvent = new TownLightsModelEvent(TownLightsModelEvent.UPDATE);
			evt.vo = vector[changeLightsTimer.currentCount - 1];
			dispatch(evt);
		}
		
		private function changeLightsTimerCompleteHandler(event:TimerEvent):void 
		{
			changeLightsTimer.reset();
		}
		
		private function randomizeTimer():Number
		{
			var randomTime:Number = Math.random () * 1000;
			
			return randomTime;
		}
	}
}