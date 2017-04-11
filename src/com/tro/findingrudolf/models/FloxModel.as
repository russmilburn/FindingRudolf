package com.tro.findingrudolf.models 
{
	import com.gamua.flox.Flox;	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class FloxModel extends BaseModel
	{
		private static const weekdays:Vector.<String> = new <String>["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		private static var _storeName:String;
		
		public function FloxModel() 
		{
			
		}
		
		public function init(storeName:String = "StoreName"):void
		{
			_storeName = storeName;
			Flox.init("6rUmc0DSFi2FnnzI", "2uJJRpMTLbNJcKZM", "0.9");
		}
		
		public function trackInteraction(touchID:int, triggeredInteraction:String):void
		{
			var touchName:String;
			
			switch(touchID)
			{
				case CommsModel.DEVICE1:
					touchName = "Book 1";
					break;
					
				case CommsModel.DEVICE2:
					touchName = "Book 2";
					break;
					
				case CommsModel.DEVICE3:
					touchName = "Book 3";
					break;
					
				default:
					touchName = "Unspecified";
					break;
			}
			
			
			var date:Date = new Date();
			var data:Object = new Object();
			data.Day = weekdays[date.getDay()];
			data.Hour = date.getHours();			
			data.Date = date.getDate();
			data.Month = (date.getMonth() + 1);
			data.TouchID = touchName;
			data.TriggeredInteraction = triggeredInteraction;
			
			Flox.logEvent(_storeName + " Interactions", data);
			
			//logger.info(JSON.stringify(data));
		}
	}
}