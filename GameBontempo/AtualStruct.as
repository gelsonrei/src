package GameBontempo
{
	import adobe.utils.CustomActions;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author gelson
	 */
	public class AtualStruct
	{
		
		public var perfil:int = 0;
		public var perfilNome :Array = new Array("Casal", "Homo",  "Amigas", "Solteiro", "Especificador");
		public var perfilNome2:Array = new Array("Cliente 1", "Cliente 2", "Cliente 3", "Cliente 4", "Especificador");//compatibilizar com nomes da hadi
		public var etapa:int = 0;
		public var tela:int = 0;
		public var pergunta:int = 0;
		public var qtTela:int = 0;
		public var qtPergunta:int = 0;
		public var perguntaQtMulti:int = 0;
		public var opcaoOrdem = 0;
		public var lastPos:structLastPos = new structLastPos();
		public var replayTo:structLastPos = new structLastPos();
		public var totalPointGame:Number = 0;
		public var totalTimeGame:Number = 0;
		public var sexoPV:String;
		public var etapaLabel:TextField;
		
		public var qtPergFeitasParaCLi:Number = 0;
		
		
		public var PontosFerramBT:Array = [0, 0];
		public var PontosFerramChamaGerente:Array = [0, 0, 0];
		public var PontosFerramConv:Array = [0, 0];
		public var PontosFerramMarca:Array = [0, 0];
		public var PontosFerramPastaCli:Array = [0, 0];
		
		public var pulaTela:Array = new Array();
		
		public var pesoTotal:Number = 0;
		
		public var PontosFerramentas:Array = new Array();
		
		public var isEnd:Boolean = false;
		
		public var isReplayGame:Boolean = false;
		public var origOrd:Array;
		public var idx:Number = 0;
		
		public var perdeuNegocio:Number = -1;
		
		private var dados:Array;
		
		public function isBegin():Boolean
		{
			return (etapa == 0 && tela == 0 && pergunta == 0)
		}
		
		public function prevPergunta():void
		{
			pergunta--;
			if (pergunta < 0)
				pergunta = 0;
		}
		
		/** usado em replay mode
		 */
		public function prevTela():void
		{
			tela--;
			if (tela < 0)
				prevEtapa();
		}
		
		/** usado em replay mode
		 */
		public function prevEtapa():void
		{
			idx--;
			if (idx < 0)
			{
				idx = 0;
			}
			etapa = origOrd[idx];
			tela = dados[etapa].telas.length - 1
		}
		
		public function nextPergunta():void
		{
			UpdateLastPosition();
			pergunta++;
			if (pergunta >= dados[etapa].telas[tela].perguntas.length)
			{
				pergunta = 0;
				nextTela();
			}
		}
		
		public function nextTela():void
		{
			var showSavingTimer:MyTimer = new MyTimer();
			trace("nextTela +1", tela);
			
			if (etapaLabel != null && !isReplayGame)
			{
				etapaLabel.text = "Salvando ...";
				showSavingTimer.init(500, 2);
				showSavingTimer.addEventListener(MyTimerEvents.ON_IDLE_REACHED, hideSavingTitle);
				showSavingTimer.start();
			}
			UpdateLastPosition();
			tela++;
			if (tela >= dados[etapa].telas.length)
			{
				tela = 0;
				nextEtapa();
			}
			
			function hideSavingTitle(evt:MyTimerEvents):void
			{
				showSavingTimer.stop();
				showSavingTimer.removeEventListener(MyTimerEvents.ON_IDLE_REACHED, hideSavingTitle);
				etapaLabel.text = StructEtapa(dados[etapa]).desc;
			}
		
		}
		
		public function nextEtapa():Number
		{
			
			idx++;
			if (idx == origOrd.length)
			{
				//idx = 0;
				isEnd = true;
				return etapa;
			}
			
			UpdateLastPosition();
			
			pergunta = 0;
			tela = 0;
			etapa = origOrd[idx];
			
			return etapa;
		}
		
		public function gotoEtapa(et:Number):Number
		{
			
			for (var i = 0; i < origOrd.length; i++)
			{
				if (et == origOrd[i]){
					idx = i;
					UpdateLastPosition();
			
					pergunta = 0;
					tela = 0;
					etapa = origOrd[idx];
					break;
				}
			}
			
			return idx;
		}
		
		public function compare(st:structLastPos):int
		{
			var at:Number = etapa * 10000 + tela * 10 + pergunta;
			var par:Number = st.etapa * 10000 + st.tela * 10 + st.pergunta;
			
			trace(etapa + " " + tela + "  " + pergunta);
			trace(par + " " + at)
			
			if (at > par)
				return -1;
			else if (at < par)
				return 1;
			else
				return 0;
		
		}
		
		public function testReachReplayEnd():Boolean
		{
			
			if (isReplayGame && (compare(replayTo) <= 0)) //mesma etapa tela pergunta
			{
				trace("end replay game");
				//isReplayGame = false;
				return true;
			}
			
			return false;
		}
		
		public function setGameSavedPoint():void
		{
			idx = origOrd.indexOf(replayTo.etapa, 0);
			etapa = origOrd[idx];
			tela = replayTo.tela;
			pergunta = replayTo.pergunta;
			nextPergunta();
		}
		
		private function UpdateLastPosition():void
		{
			lastPos.etapa = etapa;
			lastPos.tela = tela;
			lastPos.pergunta = pergunta;
		}
		
		public function setEtapa(id:int):void
		{
			idx = origOrd.indexOf(id, 0);
			etapa = idx;
			pergunta = 0;
			tela = 0;
		}
		
		/*
		   public function chageEtapaOrder(a:int,b:int):void
		   {
		   var aux:int;
		   var posa:int;
		   var posb:int;
		
		   trace(a + " " + b);
		   trace("antes");
		   for each (var it:Number in origOrd)
		   trace(it + " ");
		
		   posa = origOrd.indexOf(a, 0);
		   posb = origOrd.indexOf(b, 0);
		
		   trace(posa +"  " + posb);
		
		   //if (posa > posb) // troca só se o a estiver depois do b na lista, pois foi marcado como primeiro pelo usuario
		   //{
		   aux = origOrd[posa];
		   origOrd[posa] = origOrd[posb];
		   origOrd[posb] = aux ;
		   trace("trocou");
		   //}
		
		   trace("depois");
		   for each (var i:Number in origOrd)
		   trace(i + " ");
		   }
		 */
		
		public function somaPontosFerramentas():Number
		{
			var soma:Number = 0;
			for each (var it:Array in PontosFerramentas)
			{
				for each (var p:Number in it)
					soma += p;
			}
			trace("soma pontos ferramentas " + soma);
			return soma;
		}
		
		public function setPtFerramentas(valores:XML):void
		{
			var itens:XMLList = new XMLList();
			var j:int = 0;
			var i:int = 0;
			
			itens = valores.item;
			
			for each (var v:XML in itens)
			{
				
				PontosFerramentas[i][j] = Number(v.@valor);
				j++;
				if (j >= PontosFerramentas[i].length)
				{
					j = 0;
					i++;
				}
				if (i >= PontosFerramentas.length)
					return;
			}
		}
		
		public function addPulaTela(et:int, tl:int):void
		{
			var tupla:etapaTelaTupla = new etapaTelaTupla(et,tl);
			pulaTela.push(tupla);
		}
		
		public function isPulaTela(et:int, tl:int):Boolean 
		{
			trace(pulaTela);
			for each(var it:etapaTelaTupla in pulaTela)
			{
				trace(pulaTela);
				trace("Testa Pulo ", et, tl, it.etapa, it.tela);
				if ((it.etapa == et) && (it.tela == tl)){
					trace("isPulaTela true ", it.etapa, it.tela);
					return true;
				}
			}
			return false;
		}
		
		public function isPulaTelaAtual():Boolean 
		{
			return isPulaTela(etapa, tela);
		}
		
		public function AtualStruct(arr:Array)
		{
			dados = arr;
			
			PontosFerramentas.push(PontosFerramBT);
			PontosFerramentas.push(PontosFerramChamaGerente);
			PontosFerramentas.push(PontosFerramConv);
			PontosFerramentas.push(PontosFerramMarca);
			PontosFerramentas.push(PontosFerramPastaCli);
			
			origOrd = new Array();
			for each (var et:StructEtapa in dados)
			{
				origOrd.push(et.id);
				pesoTotal += et.peso;
			}
			
			etapa = 0;
		}
	
	}

}