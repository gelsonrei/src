package GameBontempo
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.*;
	
	
	/**
	 * ...
	 * @author gelson
	 */
	public class AuthUpDown extends Sprite
	{
		private var END_POINT:String = ("http://game.bontempo.com.br/logingame/");
		
		//you need to set your email/password required for Bloglines access.
		private var usuario:String = "bontempovendas";
		private var senha:String = "s5uXA0esM6";
		
		
		public function AuthUpDown():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			login();
		}
		
		public function logout(evt:MouseEvent=null):void
		{
			
			
			var urlLoader:URLLoader = new URLLoader();
			var previewRequest:URLRequest = new URLRequest("http://game.bontempo.com.br/logingame/logoutuser/");
			previewRequest.method = URLRequestMethod.POST;
			
			urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			urlLoader.load(previewRequest);
			
			trace("LOGOUT");
		}
		
		public function login(evt:MouseEvent=null):void
		{
			
			//logout();
			
			var urlLoader:URLLoader = new URLLoader();
			var previewRequest:URLRequest = new URLRequest(END_POINT);
			previewRequest.method = URLRequestMethod.POST;
			
			var dataPass:URLVariables = new URLVariables();
			
			dataPass.username = usuario;
			dataPass.password = senha;
			
			urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			previewRequest.data = dataPass;
			
			urlLoader.load(previewRequest);
			
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
		
		}
		
		private function onComplete(event:Event):void
		{
			
			var loader:URLLoader = URLLoader(event.target);
			
			//TF.appendText(loader.data);
			
			
			var authEvt:AuthEvents;
			if (loader.data.login=="false")
			{
				authEvt = new AuthEvents("onAuthError");
				authEvt.customMessage = "Erro de Autenticação";
				
			}
			else
			{
				authEvt = new AuthEvents("onAuthSucess");
				authEvt.customMessage = "Logado com sucesso";
			}
			trace(authEvt.customMessage);
			dispatchEvent(authEvt);
		}
		
		
		
		private function onProgress(event:ProgressEvent):void
		{
			//bytesTotal is not accurate, and its 0 if server doesn't send Content-Length header.
			trace("Event: progress:-\n" + "bytesLoaded: " + event.bytesLoaded + "\n\n");
			//TF.appendText("\n Event: progress:-\n" + "bytesLoaded: " + event.bytesLoaded + "\n\n");
		}
		
		private function onHTTPStatus(event:HTTPStatusEvent):void
		{
			//if httpStatus is 401, 403, 404, 500, 501, socket is closed.
			
			trace("Event: httpStatus (" + event.status + ")\n\n");
			//TF.appendText("\n Event: httpStatus (" + event.status + ")\n\n");
		}
		
		private function httpStatusHandler(e:HTTPStatusEvent):void
		{
			trace("httpStatusHandler:" + e.status);
			//TF.appendText("\n httpStatusHandler:" + e.status + "\n");
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void
		{
			trace("securityErrorHandler:" + e);
			//TF.appendText("\n securityErrorHandler:" + e + "\n");
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			trace("ORNLoader:ioErrorHandler: " + e);
			//TF.appendText("\n ORNLoader:ioErrorHandler: " + e + "\n");
			dispatchEvent(e);
		}
	
	}

}