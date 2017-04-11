/**
 * Created by russellmilburn on 29/10/15.
 */
package com.tro.findingrudolf.models.vos
{
	import flash.net.Socket;

	public class InteractionDataVo
	{
		public var device_ID : int;
		public var touch_ID : int;
		public var touched : Boolean;
		public var socket : Socket;

		public function InteractionDataVo()
		{
		}
	}
}
