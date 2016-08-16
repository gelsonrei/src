package GameBontempo 
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	
	
	/**
	 * ...
	 * @author gelson
	 */
	public class Auth extends Sprite
	{
		
		
		private var END_POINT:String = "http://pep.bontempo.com.br/login_form";
		private var UID_END_POINT:String = "http://pep.bontempo.com.br/ViewAuthenticatePortalMember";
		
		//you need to set your email/password required for Bloglines access.
		private var email:String = "gelsonrei@gmail.com";
		private var password:String = "gelsonrei";
		
		private var  previewRequest:URLRequest=new URLRequest();
		private var urlLoader:URLLoader = new URLLoader();
		private var dataPass:URLVariables = new URLVariables();
		
		
		public function Auth(u:String=null,p:String=null):void
		{
			email = u;
			password = p;
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		public function setUser(u:String):void
		{
			email = u;
		}
		
		public function setPass(p:String):void
		{
			password = p;
		}
		
		
			
		public function login(evt:MouseEvent=null):void
		{
			
			previewRequest.url = END_POINT;
			previewRequest.method = URLRequestMethod.POST;
			
			// setting dataPass variables to be passed 
			dataPass.__ac_name = email;
			dataPass.__ac_password = password;
			
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			
			previewRequest.data = dataPass;
			previewRequest.manageCookies = true;
			urlLoader.load(previewRequest);
			
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		
		}
		
		public function getUID():void
		{
			//var urlLoader:URLLoader = new URLLoader();
			previewRequest.url = UID_END_POINT;
				
			urlLoader.load(previewRequest);
			
			urlLoader.addEventListener(Event.COMPLETE, onCompleteUID);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandlerUID);
			
			var UID_FromPortal:String = "erro";
			
			
			function onCompleteUID(event:Event):void
			{
				
				var loader:URLLoader = URLLoader(event.target);
				UID_FromPortal = String(loader.data);
				
				var istr:String = '<div id="uid">';
				var estr:String = '</div>';
				
				var spos:int = UID_FromPortal.search(istr);
				var epos:int = UID_FromPortal.search(estr);
				
				var UID:String = UID_FromPortal.substring(spos+istr.length, epos);
				
				var authEvt:AuthEvents;
				authEvt = new AuthEvents("onGetUID");
				authEvt.customMessage = UID;
				trace("UID OK", UID);
				dispatchEvent(authEvt);
				
			}
			function ioErrorHandlerUID(e:IOErrorEvent):void
			{
				trace("ioErrorHandlerUID: " + e);
				dispatchEvent(e);
				
				var authEvt:AuthEvents= new AuthEvents("onAuthError");
				authEvt.customMessage = "Erro ao carregar UID " + e.toString();
				trace("UID ERRO");
				dispatchEvent(authEvt);
			}
			
		}
		
		private function onComplete(event:Event):void
		{
			
			var loader:URLLoader = URLLoader(event.target);
			var result:String = String(loader.data);
			var match:String = '<a id="user-name" href="http://pep.bontempo.com.br/useractions">';
			var pos:int = result.search(match);
			var next:String = result.substr(pos, 1000);
			var endTag:int = next.search("</a>");
			
			trace(next.substring(match.length, endTag)); //64  tamanho da string de login acima
			var resposta:String = (pos == -1 || endTag == -1) ? "Erro user||pwd" : next.substring(match.length, endTag);
			//TF.appendText("NOME: " + resposta + "\n\n");
			
			var authEvt:AuthEvents;
			if ((pos == -1 || endTag == -1))
			{
				authEvt = new AuthEvents("onAuthError");
				authEvt.customMessage = "Erro de Autenticação";
				
			}
			else
			{
				authEvt = new AuthEvents("onAuthSucess");
				authEvt.customMessage = resposta;
			}
			
			urlLoader.removeEventListener(Event.COMPLETE, onComplete);
			urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
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
			
			var authEvt:AuthEvents= new AuthEvents("onAuthError");
			authEvt.customMessage = "Erro de Autenticação "+e.toString();
			dispatchEvent(authEvt);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			trace("ORNLoader:ioErrorHandler: " + e);
			//TF.appendText("\n ORNLoader:ioErrorHandler: " + e + "\n");
			dispatchEvent(e);
			
			var authEvt:AuthEvents= new AuthEvents("onAuthError");
			authEvt.customMessage = "Erro de Autenticação "+e.toString();
			dispatchEvent(authEvt);
		}
	
	}

}

