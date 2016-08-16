package GameBontempo 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import GameBontempo.*;
	
	
	/**
	 * ...
	 * @author gelson
	 */
	public class DefinesLoader extends Sprite 
	{
		private static var idServers:Array = ["http://www.urizen.com.br", "http://game.bontempo.com.br"];
		public static  var SERVER_CONFIG:String = idServers[0];
		
		public static  var ASSETS_PATH:String = "";// "http://game.joaoluistavares.com.br/";// "http://www.urizen.com.br/bontempo/SimVendBT/";
		public static  var SERVER_PATH:String = " http://game.bontempo.com.br/content/";// "http://www.urizen.com.br/bontempo/SimVendBT/"; //"http://game.joaoluistavares.com.br/";// 
		
		public static  var SAVE_XML 	:String = "http://game.bontempo.com.br/content/";
		public static  var EXISTS_TEMP  :String = "http://game.bontempo.com.br/content/consulttemp/";
		public static  var LOAD_BASE 	:String = "http://game.bontempo.com.br/content/getbasecontent/";
		public static  var LOAD_TEMP 	:String = "http://game.bontempo.com.br/content/gettempcontent/";
		
				
		public static  var DEBUG_MOD:String = "true";
		public static  var BACKUP_SAVE:String = "";// "http://www.urizen.com.br/bontempo/SimVendBT/xmls/finish/";
		
		
		private var fileName:String;
		
		private var dataPass:URLVariables; 
		private	var urlLoader:URLLoader; 
		private	var previewRequest:URLRequest; 
		private var testeAuth:AuthUpDown;
		
		
		public function DefinesLoader():void 
		{
			trace("DefinesLoader");
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			fileName = "config.xml";
			loadLocal(fileName);
		}
		
		public function loadLocal(filename:String):void
		{
			urlLoader= new URLLoader();
			previewRequest = new URLRequest(filename);
			urlLoader.load(previewRequest);
			urlLoader.addEventListener(Event.COMPLETE, processConfig);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, loadRemoto);
			trace("Tentando carregar configs local",fileName);
		}
		
		public function loadRemoto(evt:Event=null):void
		{
			trace("Erro ao carregar configs local", fileName);
			trace("Tentando carregar configs remoto", fileName);
			loadServer("server.txt");
		}
		
		
		public function loadServer(filename:String):void
		{
			var myTextLoader:URLLoader = new URLLoader();
			myTextLoader.addEventListener(Event.COMPLETE, onLoadedServer);
			myTextLoader.addEventListener(IOErrorEvent.IO_ERROR, onErrorServer);
			myTextLoader.load(new URLRequest(filename));
		}
		
		private function onLoadedServer(e:Event):void {
			trace(e.target.data);
			
			if (String(e.target.data).search(idServers[1]) >= 0){
				SERVER_CONFIG = "http://game.bontempo.com.br/content/getbasecontent/";
				trace("Definido server de config, se remoto", SERVER_CONFIG);
				autentica();
			}
			else
			{
				SERVER_CONFIG = "http://www.urizen.com.br/bontempo/SimVendBT/loading-xml.php";
				trace("Definido server de config, se remoto", SERVER_CONFIG);
				downLoadXML(fileName);
			}	
		}
		
		private function onErrorServer(e:Event):void {
				trace("Erro load txt server",e.target.data);
				SERVER_CONFIG = "http://www.urizen.com.br/bontempo/SimVendBT/loading-xml.php";
				downLoadXML(fileName);	
		}
		
		private function autentica():void
		{
			testeAuth = new AuthUpDown();
			testeAuth.addEventListener(GameBontempo.AuthEvents.ON_SUCESS,onloadRemoto);
			testeAuth.addEventListener(GameBontempo.AuthEvents.ON_EROOR,onErrorAutentica);
			addChild(testeAuth);
			trace("Autenticando load Defines");
			
		}
		
		private function onloadRemoto(evt:Event = null):void
		{
			trace("onloadRemoto pos autenticação", SERVER_CONFIG, evt.toString());
			testeAuth.removeEventListener(GameBontempo.AuthEvents.ON_SUCESS,onloadRemoto);
			testeAuth.removeEventListener(GameBontempo.AuthEvents.ON_EROOR, onErrorAutentica);
			removeChild(testeAuth);
			downLoadXML(fileName);
		}
		
		private function onErrorAutentica(evt:GameBontempo.AuthEvents=null):void
		{
			trace("onErrorAutentica",evt.toString());
		}
		
		
		public function downLoadXML(filename:String, action:String="base"):void 
		{
		
			dataPass= new URLVariables();
			urlLoader= new URLLoader();
			previewRequest = new URLRequest(SERVER_CONFIG);
			previewRequest.method = URLRequestMethod.POST;
			
			dataPass.hash =  XMLLoader.HashChave();
			dataPass.action = action;
			dataPass.filename = filename;
						
			dataPass.tipo = "1";
			dataPass.uid = "gelsonrei@gmail.com";
			 
			//urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			previewRequest.data = dataPass;
			 
			// calling the PHP or loading the PHP
			urlLoader.load(previewRequest);
			urlLoader.addEventListener(Event.COMPLETE, processConfig);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			trace("Carregando configs remoto",SERVER_CONFIG);
		}
		
		
		private function onError(evt:IOErrorEvent):void
		{
			var erroTela:erroConexaoClass = new erroConexaoClass();
			erroTela.erro.text = "Erro ao abrir arquivo de configuração! Comunique ao administrador do sistema.";
			erroTela.erro.appendText("loadConfig "+fileName+ ": "+ evt.toString());
			parent.addChild(erroTela);
			trace("erro lendo config", evt.toString());
			
			var processEvt:XMLOptLoaderEvents = new XMLOptLoaderEvents("onXmlError");
			processEvt.customMessage = "Error Processing of XML file";
			dispatchEvent(processEvt);
			dispatchEvent(evt);
		}
		
		private  function processConfig(e:Event):void {
			
			var conf		:XMLList = new XMLList();
			var dataXML:XML = new XML(e.target.data);
			
			conf = dataXML.children();
			for (var i:int = 0; i < conf.length(); i++)
			{
				ASSETS_PATH = conf[i].host_assets;
				SERVER_PATH = conf[i].host_xml;
				
				SAVE_XML 	= conf[i].save_xml;
				EXISTS_TEMP = conf[i].exists_temp;
				LOAD_BASE 	= conf[i].load_base;
				LOAD_TEMP 	= conf[i].load_temp;
				
				DEBUG_MOD   = conf[i].debug;
				BACKUP_SAVE = conf[i].backup_save;
			}
			
			trace(ASSETS_PATH, SERVER_PATH);
			
			var processEvt:XMLOptLoaderEvents = new XMLOptLoaderEvents("onXmlProcessed");
			processEvt.customMessage = "Finished Processing of XML file";
			dispatchEvent(processEvt);
			
			
		}
		
		
	}

}