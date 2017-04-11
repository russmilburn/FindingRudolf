package com.tro.findingrudolf.events
{
	import com.tro.findingrudolf.models.vos.DataPacketVo;
	import flash.events.Event;
	import flash.net.Socket;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class NetSocketEvent extends Event
	{
		public static const NEW_DATA:String = "newData"; // Incoming new data.
		public var data:DataPacketVo = new DataPacketVo();
		
		public function NetSocketEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}

}