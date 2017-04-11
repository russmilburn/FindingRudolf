package com.tro.findingrudolf.models
{

	import com.tro.findingrudolf.events.AppEvent;
	import com.tro.findingrudolf.events.ClockModelEvent;
	import com.tro.findingrudolf.events.TownLightsModelEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Andrew Day
	 */
	public class ClockModel extends BaseModel
	{
		/*public static const DAWN_START_HOUR:Number = 4;
		public static const DAWN_END_HOUR:Number = 8;
		
		public static const DUSK_START_HOUR:Number = 16;
		public static const DUSK_END_HOUR:Number = 20;  */
		
		public static const DAWN_START_HOUR:Number = 7;
		public static const DAWN_END_HOUR:Number = 9;
		
		public static const DUSK_START_HOUR:Number = 20;
		public static const DUSK_END_HOUR:Number = 22;
		
		public static const DAY_START_HOUR:Number = 8;
		public static const DAY_END_HOUR:Number = 21;
		
		public static const TOTAL_HOURS:int = 24;
		private static const MINUTES_IN_HOUR:int = 60;
		
		private var timer:Timer;
		
		private var date:Date;
		
		private var _isDay:Boolean = false;
		
		private var _isDusk:Boolean = false;
		private var _isDawn:Boolean = false;
		
		private var _dayNightPercent:Number = 0;
		private var _dayNightPercentMinusTwilight:Number = 0;
		private var _dayNightPercentMinusTwilightZeroOneZero:Number = 0;
		private var _twilightPercent:Number = 0;
		private var _lunarPercent:Number = 0;
		private var _twilightLinearPercent:Number = 0;
		
		private var _hours:int;
		private var _minutes:int;
		private var _seconds: int;
		
		private var _testHour:Number = 0;
		private var _testMinutes:Number = 0;
		private var _testSeconds:Number = 0;
		
		private var _isInit:Boolean = true;
		private var _isDebugClock : Boolean = false;
		
		public function ClockModel()
		{
			super();
			
			//timer = new Timer(20);
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		private function onTimer(event:TimerEvent):void
		{
			setMockDateObject();
			
			update();
		}
		
		private function setMockDateObject():void
		{
			_testSeconds ++;
			
			if (_testSeconds == 60)
			{
				_testSeconds = 0;
				//_testMinutes ++;
			}
			
			_testMinutes++;
			
			if (_testMinutes == 60)
			{
				_testMinutes = 0;
				_testHour++;
			}
			
			if (_testHour == TOTAL_HOURS)
			{
				_testHour = 0;
			}
			//logger.info("HOURS: " + hours);
		}
		
		private function update():void
		{
			date = new Date();

			if (isDebugClock == true)
			{
				hours = _testHour;
				minutes = _testMinutes;
				seconds = _testSeconds;
			}
			else
			{

				hours = date.hours;
				minutes = date.minutes;
				seconds = date.seconds;
			}

			//TODO: CHANGE IF TESTING

			
			//logger.info("seconds: " +seconds + " modulo Seconds: " + (seconds % 20));


			
			if (seconds % 12 == 0)
			{
				//logger.info("TRIGGER RANDOM");
				if (isDay)
				{
					dispatch(new AppEvent(AppEvent.CREATE_RANDOM_ANIMATION));
				}
			}

			isDayTime();
			isDawnOrDusk();
			
			dayNightPercent = calcDayNightPercent();
			lunarPercent = calcLunarPercent();
			dayNightPercentMinusTwilight = calcDayNightPercentMinusTwilight();
			dayNightPercentMinusTwilightZeroOneZero = calcDayNightPercentMinusTwilightZeroOneZero();
			
			var evt:ClockModelEvent = new ClockModelEvent(ClockModelEvent.ON_TIMER);
			evt.dayNightPercent = dayNightPercent;
			evt.twilightPercent = twilightPercent;
			evt.twilightLinearPercent = twilightLinearPercent;
			evt.lunarPercent = lunarPercent;
			evt.dayNightPercentMinusTwilight = dayNightPercentMinusTwilight;
			evt.dayNightPercentMinusTwilightZeroOneZero = dayNightPercentMinusTwilightZeroOneZero;
			dispatch(evt);
			
			_isInit = false;
		}
		
		private function isDayTime():void
		{
			// if hour are not within this range it will be night
			if (hours >= DAY_START_HOUR && hours < DAY_END_HOUR)
			{
				isDay = true;
			}
			else
			{
				isDay = false;
			}
		}
		
		private function isDawnOrDusk():void
		{
			if (hours >= DAWN_START_HOUR && hours < DAWN_END_HOUR)
			{
				isDawn = true;
				twilightPercent = calcTwilightPercent(DAWN_START_HOUR);
				twilightLinearPercent = calcTwilightLinearPercent(DAWN_START_HOUR);
			}
			else
			{
				isDawn = false;
			}
			
			if (hours >= DUSK_START_HOUR && hours < DUSK_END_HOUR)
			{
				isDusk = true;
				twilightPercent = calcTwilightPercent(DUSK_START_HOUR);
				twilightLinearPercent = calcTwilightLinearPercent(DUSK_START_HOUR);
			}
			else
			{
				isDusk = false;
			}
		}
		
		//TODO: Maybe create a cloud percent much like a twilight percent
		private function calcTwilightPercent(start:Number):Number
		{
			var numberOfHours:int = hours - start;
			var totalMinutes:int = (numberOfHours * MINUTES_IN_HOUR) + minutes;
			
			var dawnSpan:int = DAWN_END_HOUR - DAWN_START_HOUR;
			var duskSpan:int = DUSK_END_HOUR - DUSK_START_HOUR;
			
			var twilightSpan:int;
			
			var percent:Number = 0;
			
			if (isDawn)
			{
				twilightSpan = dawnSpan;
			} else if (isDusk)
			{
				twilightSpan = duskSpan;
			}
			
			if (numberOfHours < ((twilightSpan)/2))
			{
				percent = totalMinutes / ((twilightSpan * MINUTES_IN_HOUR)/2);
			} else {
				percent = 2 - (((totalMinutes) / ((twilightSpan * MINUTES_IN_HOUR)/2)));
			}
			
			return percent;
		}
		
		private function calcTwilightLinearPercent(start:Number):Number
		{
			var numberOfHours:int = hours - start;
			var numberOfMinutes:int = (numberOfHours * MINUTES_IN_HOUR) + minutes;
			var totalMinutes:int;
			
			var dawnSpan:int = DAWN_END_HOUR - DAWN_START_HOUR;
			var duskSpan:int = DUSK_END_HOUR - DUSK_START_HOUR;
			
			var twilightSpan:int;
			
			if (isDawn)
			{
				twilightSpan = dawnSpan;
			} else if (isDusk)
			{
				twilightSpan = duskSpan;
			}
			
			var percent:Number = ((numberOfMinutes) / ((MINUTES_IN_HOUR) * twilightSpan));
			
			return percent;
		}
		
		///Will give percentage from end of dawn til start of dusk - not finished 
		private function calcDayNightPercentMinusTwilight():Number
		{
			if (!_isDawn && !_isDusk)
			{
				var percent:Number;
				var numberOfTotalHours:int = ((TOTAL_HOURS / 2)) - ((DAWN_END_HOUR - DAWN_START_HOUR) / 2) - ((DUSK_END_HOUR - DUSK_START_HOUR) / 2);
				var numberOfHours:int = getCurrentHourInDayCycleMinusTwilightCycle();
				var numberOfTotalMinutes:int = (numberOfTotalHours * MINUTES_IN_HOUR);
				var numberOfMinutes:int = (numberOfHours * MINUTES_IN_HOUR) + minutes;
				
				percent = numberOfMinutes / numberOfTotalMinutes;
				
				return percent;
			}
			
			return 0;
		}
		
		private function calcDayNightPercentMinusTwilightZeroOneZero():Number
		{
			if (!_isDawn && !_isDusk)
			{
				var percent:Number;
				var numberOfHours:int = getCurrentHourInDayCycleMinusTwilightCycle();
				
				var numberOfMinutes:int = (numberOfHours * MINUTES_IN_HOUR) + minutes;
				
				var twilightDuration:Number = ((DUSK_END_HOUR - DUSK_START_HOUR)/2) + ((DAWN_END_HOUR - DAWN_START_HOUR)/2);
				
				var totalMinutes:Number = (12 - twilightDuration) * MINUTES_IN_HOUR;
				
				percent = (numberOfMinutes / totalMinutes) * 2;
				
				if (numberOfMinutes >= (totalMinutes/2))
				{
					percent = 2 - (numberOfMinutes / ((12 - twilightDuration) * MINUTES_IN_HOUR)) * 2;
				} 
				
				return percent;
			}
			
			return 0;
		}
		
		private function getCurrentHourInDayCycleMinusTwilightCycle():Number
		{
			var numberOfHours:Number;
			var dawnPeriod:int = DAWN_END_HOUR - DAWN_START_HOUR;
			var duskPeriod:int = DUSK_END_HOUR - DUSK_START_HOUR;
			
			// Day time between 6AM and 6PM
			if (hours >= (DAY_START_HOUR + (dawnPeriod / 2)) && hours <= (DAY_END_HOUR - (duskPeriod / 2)))
			{
				numberOfHours = (hours - DAY_START_HOUR) - (dawnPeriod / 2);
			}
			// Night time between 6PM it midnight
			else if (hours >= DAY_END_HOUR - (duskPeriod / 2))
			{
				numberOfHours = (hours - DAY_END_HOUR) - (duskPeriod / 2);
			}
			//Night time from midnight till 6AM
			else if (hours <= DAY_START_HOUR + (dawnPeriod / 2))
			{
				numberOfHours = (hours + DAY_START_HOUR) - (dawnPeriod / 2);
			}
			
			return numberOfHours;
		}
		
		// caluclate progression percent the sky at 0 - 1 - 0 zero being 0%
		private function calcDayNightPercent():Number
		{
			var percent:Number;
			var numberOfHours:int = getCurrentHourIn12HourCycle();
			var numberOfMinutes:int = (numberOfHours * MINUTES_IN_HOUR) + minutes;
			
			percent = numberOfMinutes / (6 * MINUTES_IN_HOUR);
			
			if (numberOfMinutes >= (6 * MINUTES_IN_HOUR))
			{
				numberOfMinutes = numberOfMinutes - (6 * MINUTES_IN_HOUR);
				percent = 1 - ((numberOfMinutes / (12 * MINUTES_IN_HOUR)) * 2);
			}
			
			return percent;
		}
		
		// caluclate progression of sun or moon across the sky
		private function calcLunarPercent():Number
		{
			var percent:Number;
			var numberOfHours:int = getCurrentHourIn12HourCycle();

			var numberOfSeconds : int = (((numberOfHours * MINUTES_IN_HOUR) + minutes) * 60) + seconds;

			logger.info("numberOfHours: " + numberOfHours +  ", Hour:  " + hours);
			//var numberOfMinutes:int = ((numberOfHours * MINUTES_IN_HOUR) + minutes) * 60;
			percent = numberOfSeconds / (13 * MINUTES_IN_HOUR * 60);
			//logger.info("percent: " + percent);
			return percent;
		}
		
		private function getCurrentHourIn12HourCycle():Number
		{
			var numberOfHours:Number;
			
			// Day time between 6AM and 6PM
			if (hours >= DAY_START_HOUR && hours < DAY_END_HOUR)
			{
				numberOfHours = hours - DAY_START_HOUR;
			}
			// Night time between 6PM it midnight
			else if (hours >= DAY_END_HOUR)
			{
				numberOfHours = hours - DAY_END_HOUR;
			}
			//Night time from midnight till 6AM
			else if (hours < DAY_START_HOUR)
			{
				numberOfHours = hours + 3;
			}
			
			return numberOfHours;
		}
		
		public function startTimer():void
		{
			update();
			timer.start();
		}
		
		public function stopTimer():void
		{
			timer.stop();
		}
		
		public function get isDay():Boolean
		{
			return _isDay;
		}
		
		public function set isDay(value:Boolean):void
		{
			
			if (_isDay != value || _isInit == true)
			{
				// the value has changed so we need to tell the view
				_isDay = value;
				
				if (_isDay == true)
				{
					//logger.debug("ON_NIGHT_END && ON_DAY_START");
					dispatch(new ClockModelEvent(ClockModelEvent.ON_NIGHT_END));
					dispatch(new ClockModelEvent(ClockModelEvent.ON_DAY_START));
				}
				else
				{
					//logger.debug("ON_DAY_END && ON_NIGHT_START");
					dispatch(new ClockModelEvent(ClockModelEvent.ON_DAY_END));
					dispatch(new ClockModelEvent(ClockModelEvent.ON_NIGHT_START));
					
					if (_isInit)
					{
						dispatch(new ClockModelEvent(ClockModelEvent.UPDATE_NIGHT_DISPLAY));
					}
				}
			}
		}
		
		public function get isDusk():Boolean
		{
			return _isDusk;
		}
		
		public function set isDusk(value:Boolean):void
		{
			
			
			// check to see if the value is different to isDusk
			// if it has not changed there is no need to send and event to the view
			
			if (_isDusk != value || _isInit == true)// || _isInit == true
			{
				// the value has changed so we need to tell the view
				
				//logger.info(value + " value");
				//logger.info(_isDusk + " _isDusk");
				
				_isDusk = value;
				
				// what do we need to tell the view
				// these event will only be fired once when the value changes
				// i.e. when dawn starts or finishes.
				var evt:ClockModelEvent;
				
				if (_isDusk == true)
				{
					// isDusk is true and has just changed
					//logger.debug("ON_DUSK_START");
					evt = new ClockModelEvent(ClockModelEvent.ON_DUSK_START);
					dispatch(evt);
					
				}
				else
				{
					// isDusk is false and has just changed
					//logger.debug("ON_DUSK_END");
					if ( !_isInit)
					{
						evt = new ClockModelEvent(ClockModelEvent.ON_DUSK_END);
						dispatch(evt);
					}
				}
			}
		}
		
		public function get isDawn():Boolean
		{
			return _isDawn;
		}
		
		public function set isDawn(value:Boolean):void
		{
			// check to see if the value is different to isDawn
			// if it has not changed there is no need to send and event to the view
			
			//ANDY
			//I've put this here so an event gets fired on startup.
			//Otherwise - if isDawn == false on startup - no event will get fired.
			
			if (_isDawn != value || _isInit == true)//
			{
				// the value has changed so we need to tell the view
				_isDawn = value;
				
				// what do we need to tell the view
				// these event will only be fired once when the value changes
				// i.e. when dawn starts or finishes.
				
				var evt:ClockModelEvent;
				if (_isDawn == true)
				{
					// isDawn is true and has just changed
					evt = new ClockModelEvent(ClockModelEvent.ON_DAWN_START);
					dispatch(evt);
				}
				else
				{
					// isDawn is false and has just changed
					if ( !_isInit)
					{
						evt = new ClockModelEvent(ClockModelEvent.ON_DAWN_END);
						dispatch(evt);
						
						
					}
				}
			}
		}
		
		public function get hours():int
		{
			return _hours;
		}
		
		public function set hours(value:int):void
		{
			_hours = value;
		}

		public function get minutes():int
		{
			return _minutes;
		}

		public function set minutes(value:int):void
		{
			_minutes = value;
		}

		public function get seconds():int
		{
			return _seconds;
		}

		public function set seconds(value:int):void
		{
			_seconds = value;
		}

		public function get twilightPercent():Number
		{
			return _twilightPercent;
		}
		
		public function set twilightPercent(value:Number):void
		{
			_twilightPercent = value;
		}
		
		public function get dayNightPercent():Number
		{
			return _dayNightPercent;
		}
		
		public function set dayNightPercent(value:Number):void
		{
			_dayNightPercent = value;
		}
		
		public function get lunarPercent():Number
		{
			return _lunarPercent;
		}
		
		public function set lunarPercent(value:Number):void
		{
			_lunarPercent = value;
		}
		

		
		public function get dayNightPercentMinusTwilight():Number
		{
			return _dayNightPercentMinusTwilight;
		}
		
		public function set dayNightPercentMinusTwilight(value:Number):void
		{
			_dayNightPercentMinusTwilight = value;
		}
		
		public function get twilightLinearPercent():Number
		{
			return _twilightLinearPercent;
		}
		
		public function set twilightLinearPercent(value:Number):void
		{
			_twilightLinearPercent = value;
		}
		
		public function get dayNightPercentMinusTwilightZeroOneZero():Number 
		{
			return _dayNightPercentMinusTwilightZeroOneZero;
		}
		
		public function set dayNightPercentMinusTwilightZeroOneZero(value:Number):void 
		{
			_dayNightPercentMinusTwilightZeroOneZero = value;
		}


		public function get isDebugClock():Boolean
		{
			return _isDebugClock;
		}

		public function set isDebugClock(value:Boolean):void
		{
			_isDebugClock = value;

			if (_isDebugClock)
			{
				timer.delay = 20;
			}
			else
			{
				timer.delay = 1000;
			}
		}
	}
}