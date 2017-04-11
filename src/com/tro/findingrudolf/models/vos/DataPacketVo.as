package com.tro.findingrudolf.models.vos 
{
	import flash.net.Socket;
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class DataPacketVo 
	{
		public var heartbeat : Boolean;
		public var touched : Boolean;
		public var device_ID : int;
		public var touch_ID : int;
		public var message : String;
		
		public function DataPacketVo() 
		{
			
		}
		
	}

}