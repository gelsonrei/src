package  
{
	import caurina.transitions.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.*;
	import flash.net.*;
	import GameBontempo.DefinesLoader;
	import postitClass;
	import GameBontempo.*;
	
	public class MiniGamePreparaClass extends MovieClip 
	{
		private var dataPass:URLVariables; 
		private	var urlLoader:URLLoader; 
		private	var previewRequest:URLRequest; 
		
		//private var urlRequest:URLRequest = new URLRequest(XMLLoader.SERVER_PATH+"xmls/MiniGamePrep.xml");
		//private var urlLoader:URLLoader = new URLLoader();
		private var myXML:XML = new XML();
		private var xmlList:XMLList;
		
		private var postits:Array; 
		
		private var sel:Array;
		public  var replaySelArray:Array;
		public var isReplayGame = false;
		private var dragging:Boolean = false;
		public var maxPoints:Number = 0;
		public var selPoints:Number = 0;
		private var qtPoint:Number = 0;
		private var maxSel:int = 8;
		private var countSel:int = 0;
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			myXML.ignoreWhitespace = true;
			
			downLoadXML("MiniGamePrep.xml");
			urlLoader.addEventListener(Event.COMPLETE, fileLoaded);
			
			hitTestMC.alpha = 0.5;
			if (GameBontempo.DefinesLoader.DEBUG_MOD == "true")
				EtapaPT.visible = true;
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
		
		private function randRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		function fileLoaded(event:Event):void
		{
			var post:postitClass;
			myXML = XML(event.target.data);
			xmlList = myXML.opcao;
			postits = new Array();
			
			for (var i:int = 0; i < xmlList.length(); i++)
			{
				trace(xmlList[i].@texto);
				post = new postitClass(xmlList[i].@texto,Number(xmlList[i].@valor));
				maxPoints += Number(xmlList[i].@nivel )>0?Number(xmlList[i].@valor ):0;
				if (Number(xmlList[i].@nivel >0))
					qtPoint++;
				
				post.x = i % 2 == 0? randRange (1, (300-post.width)):randRange (1010, (1280-post.width));
				post.y = randRange (1, (height - post.height));
				post.iniX = post.x;
				post.iniY = post.y;
				
				post.addEventListener(MouseEvent.MOUSE_UP, drop);
				post.addEventListener(MouseEvent.MOUSE_DOWN, drag);
				post.addEventListener(MouseEvent.MOUSE_MOVE, testOverHit);
				addChild(post);
				postits.push(post);
				
				if (GameBontempo.DefinesLoader.DEBUG_MOD == "true")
					if (post.valor > 0) post.setAtiva(true); 
			}
			
			if (replaySelArray != null)
				setSelected(replaySelArray);
				
			setChildIndex( btOk_MC, this.numChildren - 1); 
		}
		
		private function drag(e:MouseEvent)
		{
			if (isReplayGame)
				return;
				
			setChildIndex( postitClass(e.currentTarget), this.numChildren - 1); 
			
			dragging = true;
			hitTestMC.alpha = 0.5;
		}
		
		private function testOverPostit(curr:postitClass):Boolean
		{
			for each (var it:postitClass in postits) //testa se dropou sobre outro e retorna
			{
				if (it != curr)
				   if ( curr.hitTestObject(it) )
				   {
						return true;
				   }
			}
			
			return false;
		}
		
		private function drop(e:MouseEvent)
		{
			if (isReplayGame)
				return;
			
			dragging = false;
			hitTestMC.alpha = 0.5;
			
			trace("Count " + countSel);
			
			if ((countSel >= maxSel && !e.currentTarget.sel) /*|| testOverPostit(postitClass(e.currentTarget))*/){
				e.currentTarget.backDrag();
				return;
			}
			else if (e.currentTarget.hitTestObject(hitTestMC))
			{
				if (!e.currentTarget.sel) {
					selPoints += e.currentTarget.valor;
					countSel++;
				}
				e.currentTarget.sel = true;
				e.currentTarget.setAtiva(true);
				trace("dentro " + e.currentTarget.texto);
				var onDroppedEvt:MiniGameEvents= new MiniGameEvents("onHitAreaDropped");
				onDroppedEvt.customMessage = "Postit Dropped in hit area";
				dispatchEvent(onDroppedEvt);
			}
			else
			{
				if (e.currentTarget.sel) {
					selPoints -= e.currentTarget.valor;
					countSel--;
				}
				e.currentTarget.sel = false;
				e.currentTarget.setAtiva(false);
				trace("fora " + e.currentTarget.texto);
				var outDroppedEvt:MiniGameEvents= new MiniGameEvents("outHitAreaDropped");
				outDroppedEvt.customMessage = "Postit Dropped out hit area";
				dispatchEvent(outDroppedEvt);
			}
			
		}
		
		private function testOverHit(e:MouseEvent)
		{
			if (!dragging) return;
			
			if (isReplayGame)
				return;
			
			if (e.currentTarget.hitTestObject(hitTestMC))
			{
				hitTestMC.alpha = 1.0;
				e.currentTarget.setAtiva(true);
			}
			else
			{
				hitTestMC.alpha = 0.5;
				e.currentTarget.setAtiva(false);
			}
		}
		
		public function getSelected():Array
		{
			var selec = new Array();
			for each (var it:postitClass in postits)
			{
				if (it.sel){
					selec.push(it);
				}
			}
			
			return selec;
		}
		
		public function setSelected(prs:Array):void
		{
			for each (var ts:String in prs)
			{
				for each (var it:postitClass in postits)
				{
					if (it.texto == ts)
					{
						it.x = randRange (300, (1000-it.width));
						it.y = randRange (100, (600-it.height));
						it.sel = true;
						it.setAtiva(true);
						
					}
					it.isReplayGame = true;
					it.removeEventListener(MouseEvent.MOUSE_UP, drop);
					it.removeEventListener(MouseEvent.MOUSE_DOWN, drag);
					it.removeEventListener(MouseEvent.MOUSE_MOVE, testOverHit);
				}
			}
			
			isReplayGame = true;
			
			if (isReplayGame)
				btOk_MC.visible = false;
		}
		
		public function calculaPontos():Number
		{
			if (selPoints == maxPoints && countSel==qtPoint)
				return 10;
			if (selPoints == maxPoints && countSel>qtPoint)
				return 7;
			if (selPoints == maxPoints-10)
				return 5;
			
			return 0;
		}
		
		public function MiniGamePreparaClass(selArr:Array=null) 
		{
			replaySelArray = selArr;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		
	}

}