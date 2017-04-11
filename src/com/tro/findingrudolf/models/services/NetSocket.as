package com.tro.findingrudolf.models.services
{
	import com.tro.findingrudolf.models.vos.DataPacketVo;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import com.tro.findingrudolf.events.NetSocketEvent;
	import com.tro.findingrudolf.models.vos.SocketDataVo;
	import com.tro.findingrudolf.models.vos.DataPacketVo;
	
	/**
	 * ...
	 * @author David Armstrong
	 */
	public class NetSocket extends EventDispatcher
	{
		private static const EOL:String = "END";
		
		private var serverSocket:ServerSocket = new ServerSocket();
		protected var clients:Vector.<Socket>;
		
		private var localIP:String;
		private var localPort:int;
		
		public function NetSocket(localIP:String = "0.0.0.0", localPort:int = 0)
		{
			super();
			
			this.localIP = localIP;
			this.localPort = localPort;
			
			init();
		}
		
		private function init():void
		{
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, appExit);
			
			clients = new Vector.<Socket>();
			
			bind();
		}
		
		private function onConnect(event:ServerSocketConnectEvent):void
		{
			var myClient:Socket;
			trace("NetSocket: New client connecting: " + event.socket.remoteAddress + ":" + event.socket.remotePort + ".");
			
			myClient = event.socket;
			myClient.addEventListener(ProgressEvent.SOCKET_DATA, onClientSocketData);
			myClient.addEventListener(Event.CLOSE, clientDisconnectedHandler);
			clients.push(myClient);
			trace("NetSocket: Client " + event.socket.remoteAddress + " now connected.");
		}
		
		private function findClient(address:String):int
		{
			var cliLength:int = clients.length;
			var cliNumber:int = -1;
			
			for (var i:uint = 0; i < cliLength; i++)
			{
				if (clients[i].remoteAddress == address)
				{
					cliNumber = i;
					break;
				}
			}
			
			return cliNumber;
		}
		
		private function onClientSocketData(e:ProgressEvent):void
		{
			var bytes:ByteArray = new ByteArray();
			e.target.readBytes(bytes);
			
			/*
			var evt:NetSocketEvent = new NetSocketEvent(NetSocketEvent.NEW_DATA);
			evt.data.device_ID = int(bytes.readShort());
			dispatchEvent(evt);			
			*/
			
			if (bytes.length > 0)
			{
				
				//trace("touch_ID: " + bytes.readShort());
				//trace("touched: " + bytes.readBoolean());
				
				var jsonIn:String = bytes.readUTFBytes(bytes.length);
				var array:Array = jsonIn.split(EOL);
				var messages:int = array.length - 1;
				
				for (var i:int = 0; i < messages; i++)
				{
					if (array[i].indexOf("{") != -1 && array[i].lastIndexOf("}") != -1)
					{
						trace("NetSocket: Incoming JSON: " + array[i]);
						var object:Object = JSON.parse(array[i]);
						var evt:NetSocketEvent = new NetSocketEvent(NetSocketEvent.NEW_DATA)
						
						evt.data.touched = Boolean(object.touched);
						evt.data.device_ID = int(object.device_ID);
						evt.data.touch_ID = int(object.touch_ID);
						
						dispatchEvent(evt);
					}
					else
					{
						trace("NetSocket: ERROR, incomplete JSON:", array[i]);
					}
				}
			}
		}
		
		private function clientDisconnectedHandler(event:Event):void
		{
			var cli:int = findClient(event.target.remoteAddress);
			
			if (cli != -1)
			{
				trace("NetSocket: About to remove client. Current clients: " + clients.length + ".");
				clients.splice(cli, 1);
			}
			
			trace("NetSocket: Client removed. Current clients: " + clients.length + ".");
			event.target.removeEventListener(Event.CLOSE, clientDisconnectedHandler);
		}
		
		private function bind():void
		{
			if (serverSocket.bound)
			{
				trace("NetSocket: Socket bound already, closing.");
				serverSocket.close();
				serverSocket = new ServerSocket();
				
			}
			serverSocket.bind(localPort, localIP);
			serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT, onConnect);
			serverSocket.listen();
			trace("NetSocket: Bound to: " + serverSocket.localAddress + ":" + serverSocket.localPort + ".");
		}
		
		public function send(targetSocket:Socket, data:DataPacketVo):void
		{
			try
			{
				if (targetSocket != null && targetSocket.connected)
				{
					var json:String = JSON.stringify(data);
					targetSocket.writeUTFBytes(json + EOL);
					targetSocket.flush();
					trace("NetJSON: Sent message to " + targetSocket.remoteAddress + ":" + targetSocket.remotePort + ".");
					trace(json + EOL);
				}
				else
				{
					trace("NetJSON: No socket connection (" + targetSocket.remoteAddress + ":" + targetSocket.remotePort + ").");
				}
			}
			catch (error:Error)
			{
				trace(error.message);
			}
		}
		
		public function sendToAll(data:DataPacketVo):void
		{			
			var cli:int = clients.length;
			
			if (cli > 0)
			{
				trace("NetSocket: Sending data to all Clients.");
				var json:String = JSON.stringify(data);
				
				for (var i:uint = 0; i < cli; i++)
				{
					try
					{
						if (clients[i] != null && clients[i].connected)
						{
							clients[i].writeUTFBytes(json + EOL);
							clients[i].flush();
							trace("NetSocket: Sending to " + clients[i].remoteAddress + ":" + clients[i].remotePort + ".");
							trace(json + EOL);
						}
						else
						{
							trace("NetSocket: No socket connection (" + clients[i].remoteAddress + ":" + clients[i].remotePort + ").");
						}
					}
					catch (error:Error)
					{
						trace(error.message);
					}
				}
			}
		}
		
		private function appExit(event:Event):void
		{
			for each (var cli:Socket in clients)
			{
				cli.close();
			}
		}
		
		private function remove(event:Event = null):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, remove);
		}
	}

}