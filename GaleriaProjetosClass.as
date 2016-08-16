package
{
	/**
	 * ...
	 * @author Gelson
	 */
	import caurina.transitions.*;
	import fl.containers.UILoader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.*;
	import GameBontempo.StructProjetoPerfil;
	import GameBontempo.ThumbStruct;
	import GameBontempo.DefinesLoader;
	import GameBontempo.XMLLoader;
	
	public class GaleriaProjetosClass extends MovieClip
	{
		
		private var dataPass:URLVariables; 
		private	var urlLoader:URLLoader; 
		private	var previewRequest:URLRequest; 
		
		//private var urlRequest:URLRequest = new URLRequest(XMLLoader.SERVER_PATH+"xmls/pics.xml");
		//private var urlLoader:URLLoader = new URLLoader();
		private var myXML:XML = new XML();
		private var xmlList:XMLList;
		
		private var arrayURL:Array = new Array();
		private var arrayName:Array = new Array();
		private var holderArray:Array = new Array();
		public var replaySelArray:Array;
		public var projetosPerfil:Array;
		public var isReplayGame:Boolean = false;
		private var prjSelec:Array = new Array();
		
		private var nrColumns:uint = 10;
		
		private var thumbsHolder:Sprite = new Sprite();
		private var photoLoader:UILoader = new UILoader();
		private var sprite:Sprite = new Sprite();
		private var thumb:Thumbnail;
		private var abaAtual:int = 0;
		
		public function GaleriaProjetosClass(selArr:Array = null, projPerfil:Array = null)
		{
			
			replaySelArray = selArr;
			projetosPerfil = projPerfil;
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function downLoadXML(filename:String):void 
		{
			dataPass= new URLVariables();
			urlLoader= new URLLoader();
			//previewRequest = new URLRequest(DefinesLoader.SERVER_PATH + "loading-xml.php");
			//previewRequest = new URLRequest(DefinesLoader.SERVER_PATH + "loading-xml"+"_base.php");
			previewRequest = new URLRequest(DefinesLoader.LOAD_BASE);
			
			previewRequest.method = URLRequestMethod.POST;
			 
			dataPass.hash =  XMLLoader.HashChave();
			dataPass.action = "base";
			dataPass.filename = filename;
			
			dataPass.tipo = "1";
			
			previewRequest.data = dataPass;
			 
			// calling the PHP or loading the PHP
			urlLoader.load(previewRequest);
		}
		
		
		private function init(e:Event = null):void
		{
			
			sprite.addChild(thumbsHolder);
			sprite.addChild(loaderHolderMC);
			
			photoLoader.width = 540;
			photoLoader.height = 320;
			photoLoader.y = 10;
			photoLoader.x = 10;
			photoLoader.buttonMode = true;
			btNext_MC.buttonMode = true;
			btPrev_MC.buttonMode = true;
			
			loaderHolderMC.addChild(photoLoader);
			
			btNext_MC.alpha = 0.5;
			btPrev_MC.alpha = 0.5;
			
			btNext_MC.addEventListener(MouseEvent.CLICK, nextAba);
			btNext_MC.addEventListener(MouseEvent.MOUSE_OVER, btOver);
			btNext_MC.addEventListener(MouseEvent.MOUSE_OUT, btOut);
			
			btPrev_MC.addEventListener(MouseEvent.CLICK, prevAba);
			btPrev_MC.addEventListener(MouseEvent.MOUSE_OVER, btOver);
			btPrev_MC.addEventListener(MouseEvent.MOUSE_OUT, btOut);
			
			myXML.ignoreWhitespace = true;
			
			downLoadXML("pics.xml");
			urlLoader.addEventListener(Event.COMPLETE, fileLoaded);
			
			
			addChild(sprite);
		
		}
		
		private function fileLoaded(event:Event):void
		{
			myXML = XML(event.target.data);
			xmlList = myXML.children();
			for (var i:int = 0; i < xmlList.length(); i++)
			{
				var picURL:String = xmlList[i].url;
				var picName:String = xmlList[i].big_url;
				arrayURL.push(picURL);
				arrayName.push(picName);
				holderArray[i] = new Thumbnail(arrayURL[i], i, arrayName[i]);
				holderArray[i].addEventListener(MouseEvent.MOUSE_OVER, onOver);
				holderArray[i].name = arrayName[i];
				holderArray[i].buttonMode = true;
			}
			photoLoader.source = holderArray[0].url;
			populaAba();
			
			if (replaySelArray != null)
			{
				setSelected(replaySelArray);
				btOk_MC.visible = false;
			}
			
			function onOver(event:MouseEvent):void
			{
				photoLoader.source = Thumbnail(event.currentTarget).url;
			}
			
			hiProjPerfil(projetosPerfil);
			loaderHolderMC.loadingIconMC.visible = false;
		}
		
		private function nextAba(event:MouseEvent = null):void
		{
			var abaOld:int = abaAtual;
			
			abaAtual++;
			
			if (abaAtual > int(holderArray.length / 20))
			{
				
				abaAtual = abaOld;
				return;
			}
			
			removeBts(abaOld);
			populaAba();
		}
		
		private function prevAba(event:MouseEvent = null):void
		{
			var abaOld:int = abaAtual;
			
			abaAtual--;
			
			if (abaAtual < 0)
			{
				abaAtual = abaOld;
				return;
			}
			
			removeBts(abaOld);
			populaAba();
		}
		
		private function populaAba():void
		{
			var qt:int = 0;
			
			for (var i:int = abaAtual * 20; i < holderArray.length && qt < 20; i++, qt++)
			{
				if (qt < nrColumns)
				{
					holderArray[i].y = 460 + 60;
					holderArray[i].x = qt * 120 + 100;
				}
				else
				{
					holderArray[i].y = holderArray[i - nrColumns].y + 120;
					holderArray[i].x = holderArray[i - nrColumns].x;
				}
				thumbsHolder.addChild(holderArray[i]);
			}
		}
		
		private function removeBts(aba:int):void
		{
			var q:int = 0;
			
			for (var j:int = aba * 20; j < holderArray.length && q < 20; j++, q++)
			{
				thumbsHolder.removeChild(holderArray[j]);
			}
		}
		
		public function printSelected():void
		{
			for each (var bt:Thumbnail in prjSelec)
			{
				trace("Selecionado: " + bt.url);
			}
		}
		
		public function getSelected():Array
		{
			
			prjSelec = new Array();
			
			for each (var bt:Thumbnail in holderArray)
			{
				if (bt.isSelected)
				{
					prjSelec.push(bt);
				}
			}
			return prjSelec;
		}
		
		public function calculaPontos():Number
		{
			getSelected();
			var valor:Number = 0;
			for each (var bt:Thumbnail in holderArray)
			{
				if (bt.isSelected)
				{
					valor+=bt.valor;
				}
			}
			return valor/(projetosPerfil.length<prjSelec.length?prjSelec.length:projetosPerfil.length);
		}
		
		public function hiProjPerfil(prs:Array):void
		{
			for each (var bt:Thumbnail in holderArray)
			{
				for each (var ts:StructProjetoPerfil in prs)
				{
					if (bt.url == ts.url )
					{
						if (GameBontempo.DefinesLoader.DEBUG_MOD=="true")
							bt.setHi(); //destaca os validos
						bt.valor = 10;
						break;
					}
				}
			}
		}
		
		
		public function setSelected(prs:Array):void
		{
			for each (var bt:Thumbnail in holderArray)
			{
				for each (var ts:ThumbStruct in prs)
				{
					if (bt.url == ts.url && bt.id == ts.id)
					{
						bt.isSelected = true;
						bt.setAtiva(bt.isSelected);
					}
					
				}
				bt.isReplayGame = true;
			}
			isReplayGame = true;
		}
		
		function btOver(event:MouseEvent):void
		{
			event.currentTarget.alpha = 1.0;
		}
		
		function btOut(event:MouseEvent):void
		{
			event.currentTarget.alpha = 0.5;
		}
	
	}

}