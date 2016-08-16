package GameBontempo
{
	/**
	 * ...
	 * @author Gelson
	 */
	
	import com.adobe.crypto.MD5;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import flash.utils.*;
	import com.greensock.*;
	
	public class XMLSaver extends Sprite
	{
		
		private var myXML:XML =   <etapas/>;
		private var myXMLDLG:XML;
		private var dados:Array;
		private var dadosDLG:Array;
		//private var date:Date = new Date();
		
		private var etapas:XML = new XML();
		private var telas:XML = new XML();
		private var perguntas:XML = new XML();
		private var respostas:XML = new XML();
		
		private var perguntasDLG:XML;
		private var ferramentas:XML;
		private var ptFerramentas:XML;
		private var pastaCliClicados:XML;
		private var galeriaItens:XML;
		private var preparaItens:XML;
		private var userName:String;
		private var playerName:String;
		private var atual:AtualStruct;
		private var textoFinal:XML;
		
		private var fr:FileReference = new FileReference();
		public var filteredFileName:String;
		
		private var dataPass:URLVariables; 
		private var previewRequest:URLRequest; 
		private var urlLoader:URLLoader;
		
		private var testeAuth:GameBontempo.AuthUpDown;
		
		private function upLoadXML(filename:String, xmlcontents:XML):void
		{
			var tempfile = userName + "_" + atual.sexoPV + "_temp.xml";
			
			dataPass = new URLVariables();
						
			dataPass.hash = MD5.hash(xmlcontents.toString()) + MD5.hash(XMLLoader.chave);
			//dataPass.action = atual.isEnd ? "finish" : "temp"; 
			dataPass.action = atual.isEnd ? "2" : "1"; 
			dataPass.filename = filename;
			dataPass.filenametemp = tempfile;
			dataPass.filecontent =  xmlcontents.toString();
			dataPass.filecontents =  xmlcontents.toString(); //mater compatibilidade com server urizen remover no futuro
			
			
			dataPass.tipo = "1";
			dataPass.uid = userName;
			dataPass.nome = playerName;
			
			previewRequest = new URLRequest(DefinesLoader.SAVE_XML);
			
			previewRequest.method = URLRequestMethod.POST;
			previewRequest.data = dataPass;
			
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
				
			
			urlLoader.addEventListener(Event.COMPLETE, testaRetorno);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			if (DefinesLoader.SERVER_PATH.search("game.bontempo.com.br") >= 0)
			{
				autentica();
				
				if (DefinesLoader.SERVER_PATH!="" && atual.isEnd)
					backupSave(filename, xmlcontents);
			}
			else 
				urlLoader.load(previewRequest);
			
			
		}
		
		
		private function autentica():void
		{
			testeAuth = new AuthUpDown();
			testeAuth.addEventListener(GameBontempo.AuthEvents.ON_SUCESS,loadPreviewRequest);
			testeAuth.addEventListener(GameBontempo.AuthEvents.ON_EROOR, onErrorAutentica);
			testeAuth.addEventListener(IOErrorEvent.IO_ERROR,onErrorAutentica);
			addChild(testeAuth);
			
		}
		
		
		private function loadPreviewRequest(evt:Event = null):void
		{
			testeAuth.removeEventListener(GameBontempo.AuthEvents.ON_SUCESS,loadPreviewRequest);
			testeAuth.removeEventListener(GameBontempo.AuthEvents.ON_EROOR, onErrorAutentica);
			removeChild(testeAuth);
			urlLoader.load(previewRequest);
		}
		
		private function onErrorAutentica(evt:Event=null):void
		{
			onError(IOErrorEvent(evt));
		}
		
		private function onError(evt:Event):void
		{
			erroConexaoClass(parent.getChildByName("erroTela")).erro.appendText(evt.toString());
			erroConexaoClass(parent.getChildByName("erroTela")).visible = true;
			erroConexaoClass(parent.getChildByName("erroTela")).BTContinua.visible = false;
			erroConexaoClass(parent.getChildByName("erroTela")).tryConnLabel.visible = true;
			erroConexaoClass(parent.getChildByName("erroTela")).tryConnEngines.visible = true;
			erroConexaoClass(parent.getChildByName("erroTela")).BTSair.visible = false;
			saveXmlEtapas();
			dispatchEvent(evt);
		}
		
		private function testaRetorno(e:Event):void 
		{
			
			trace ("Salvou", e.target.data.retorno); 
			
			if (e.target.data.retorno == "false")
			{
				erroConexaoClass(parent.getChildByName("erroTela")).erro.appendText("XMLSaver: Erro ao tentar salvar no servidor. Retorno="+e.target.data.retorno);
				erroConexaoClass(parent.getChildByName("erroTela")).visible = true;
				erroConexaoClass(parent.getChildByName("erroTela")).BTContinua.visible = false;
				erroConexaoClass(parent.getChildByName("erroTela")).tryConnLabel.visible = true;
				erroConexaoClass(parent.getChildByName("erroTela")).tryConnEngines.visible = true;
				saveXmlEtapas();
				dispatchEvent(e);
			}
			else
			{
				//if (atual.isEnd)
				//	TelaFinalClass(parent.getChildByName("TelaFinal")).BTSair.visible = true;
				if (erroConexaoClass(parent.getChildByName("erroTela")).visible == true){
					erroConexaoClass(parent.getChildByName("erroTela")).tryConnLabel.visible = false;
					erroConexaoClass(parent.getChildByName("erroTela")).tryConnEngines.visible = false;
					erroConexaoClass(parent.getChildByName("erroTela")).BTContinua.visible = true;
				}
				urlLoader.removeEventListener(Event.COMPLETE, testaRetorno);
				dispatchEvent(e);
			}
			
		}
		
		private function backupSave(filename:String, xmlcontents:XML):void
		{
			var tempfile = userName + "_" + atual.sexoPV + "_temp.xml";
			
			var dataPass:URLVariables = new URLVariables();
						
			dataPass.hash = MD5.hash(xmlcontents.toString()) + MD5.hash(XMLLoader.chave);
			dataPass.action =  "finish";
			dataPass.filename = filename;
			dataPass.filenametemp = tempfile;
			dataPass.filecontent =  xmlcontents.toString();
			dataPass.filecontents =  xmlcontents.toString();
			
			var previewRequest:URLRequest = new URLRequest(DefinesLoader.BACKUP_SAVE + "saving-xml.php");
			previewRequest.method = URLRequestMethod.POST;
			previewRequest.data = dataPass;
			
			var urlLoader:URLLoader = new URLLoader();
			//urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			urlLoader.load(previewRequest);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onErrorBackup);
		}
		
		private function onErrorBackup(evt:IOErrorEvent):void
		{
			trace("Erro backup", evt.toString);
		}
		
		
		public function XMLSaver(user:String, player:String, dt:Array, dial:Array, _atual:AtualStruct)
		{
			dados = dt;
			dadosDLG = dial;
			userName = user;
			playerName = player;
			atual = _atual;
		}
		
		
		/*
		public function saveXmlFiltered():String
		{
			
			filterXMLEtapa();
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(myXML);
			
			var util: Util = new Util();
			util.addEventListener(Event.COMPLETE, onGetNtpDate);//retornou a data do server NTP
			util.requestNTPTime();
			
			function onGetNtpDate()
			{
			
				filteredFileName = "etapas_" + util.getDateString() + ".xml";
				fr.save(ba, filteredFileName);
				fr.addEventListener(Event.SELECT, onRefSelect);
				
				return filteredFileName;
			}
		}
		*/
		
		public function setTextoFinal(tFinal:XML = null):void
		{
			if (tFinal!=null)
				textoFinal = tFinal;
		}
		
		public function saveXmlEtapas(filename:String = null):void
		{
			processaEtapas();
			addEventListener(NTPEvents.ON_ETPROCESS, onEtProcessadas);
		
			function onEtProcessadas(e:NTPEvents)
			{
				removeEventListener(NTPEvents.ON_ETPROCESS, onEtProcessadas);
					
				var fn:String = String(userName + "_");
				
				var util: Util = new Util();
				fn += atual.isEnd ? (util.getDateString(!atual.isEnd) + ".xml") : (atual.sexoPV+"_"+"temp.xml"); //pega a data global em caso de isEnd, que ja foi requisitada recentemente no processaEtapas()
				upLoadXML((filename == null ? fn : filename), myXML);
				
				/*
				   var fr:FileReference = new FileReference();
				   fr.save(ba, (filename == null?fn:filename));
				   var ba:ByteArray = new ByteArray();
				   ba.writeUTFBytes(myXML);
				 */
			}
		}
		
		public function saveXmlDialogo(filename = null):void
		{
			processaDialogos();
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(myXMLDLG);
			var fr:FileReference = new FileReference();
			fr.save(ba, (filename == null ? "filenameDlg.xml" : filename));
		
		}
		
		private function onRefSelect(e:Event):void
		{
			fr.removeEventListener(Event.SELECT, onRefSelect);
			fr.addEventListener(Event.COMPLETE, onCompleteSave);
		}
		
		private function onRefCancel(e:Event):void
		{
			trace('cancel');
		}
		
		private function onCompleteSave(e:Event):void
		{
			fr.removeEventListener(Event.COMPLETE, onCompleteSave);
			
			var saveEvt:XMLSaveEvents = new XMLSaveEvents("onXmlSaved");
			saveEvt.customMessage = "XML file Saved";
			dispatchEvent(saveEvt);
		}
		
		public function addCallTool(tool:String):void
		{
			if (ferramentas == null)
				ferramentas =  <ferramentas/>;
			
			var util: Util = new Util();
			
			var ferramenta:XML =   <ferramenta date={util.getDateString()} nome={tool} etapa={atual.etapa} tela={atual.tela} pergunta={atual.pergunta}/>;
			ferramentas.appendChild(ferramenta);
		}
		
		public function addPtTools(pt:Array):XML
		{
			
			ptFerramentas =  <ptFerramentas/>;
			
			var soma:Number = 0;
			for each(var it:Array in pt)
			{
				for each(var p:Number in it){
					var item:XML =   <item valor={p.toFixed(2)}/>;
					ptFerramentas.appendChild(item);
					soma += p;
				}
			}	
			return ptFerramentas;
		}
		
		public function addMiniGameGaleria(PrjSel:Array):void
		{
			
			if (galeriaItens == null)
				galeriaItens =  <projetos/>; 
			
			for each (var it:Thumbnail in PrjSel)
			{
				var miniGame:XML =   <selecao url={it.url} id={it.id} thumb={it.nume}/>;
				galeriaItens.appendChild(miniGame);
			}
		}
		
		public function addMiniGamePrepara(Sel:Array):void
		{
			if (preparaItens == null)
				preparaItens =  <preparacao/>; 
			
			for each (var it:postitClass in Sel)
			{
				var miniGame:XML =   <selecao texto={it.texto}/>;
				preparaItens.appendChild(miniGame);
			}
		}
		
		public function setFerramentasXML(itXML:XML):void
		{
			if (itXML != null)
				ferramentas = itXML;
		}
		
		public function setMiniGaleriaXML(itXML:XML):void
		{
			if (itXML != null)
				galeriaItens = itXML;
		}
		
		public function setMiniPreparaXML(itXML:XML):void
		{
			if (itXML != null)
				preparaItens = itXML;
		}
		
		
		public function setClicadosPastaCli(clicados:Array):void
		{
			pastaCliClicados = <pastaCliClicados/>
			for each (var it:int in clicados)
			{
				var item:XML =   <item idx={it}/>;
				pastaCliClicados.appendChild(item);
			}
		}
		
				
		
		private function filterXMLEtapa():void
		{
			myXML =   <etapas/>;
			var game:XML = <game  status={atual.isReplayGame ? "replay" : "play"} lastEt={atual.isReplayGame ? atual.replayTo.etapa : atual.lastPos.etapa} lastTe={atual.isReplayGame ? atual.replayTo.tela : atual.lastPos.tela} lastPe={atual.isReplayGame ? atual.replayTo.pergunta : atual.lastPos.pergunta}  qtPergToCli={atual.qtPergFeitasParaCLi}></game>;
			myXML.appendChild(game);
			if (ferramentas != null)
				myXML.appendChild(ferramentas);
			
			var etId:int = 0;
			for each (var itEta:StructEtapa in dados)
			{
				var teId:int = 0;
				etapas =   <etapa id={ etId} desc={itEta.desc} peso={itEta.peso} aux={itEta.aux} note={itEta.anotacoes} textoConceito={itEta.textoConceito}></etapa>;
				for each (var itTel:StructTela in itEta.telas)
				{
					var peId:int = 0;
					
					telas =   <tela time={itTel.time} date={itTel.date} rm={itTel.removido} lk={itTel.link} estilo={Estilo.Lista[Number(itTel.estilo)]} id={ /*itTel.id*/teId} desc={itTel.desc} som={itTel.som} video={itTel.video} vdsufixo={itTel.vdsufixo} imgMask={itTel.imgMask} ajuda={itTel.ajuda} ajudaSom={itTel.ajudaSom}></tela>;
					if (itTel.estilo == Estilo.MINIGAME && itTel.desc == "GaleriaProjetos" && galeriaItens != null)
					{
						telas.appendChild(galeriaItens);
					}
					if (itTel.estilo == Estilo.MINIGAME && itTel.desc == "PreparaApresentacao" && preparaItens != null)
					{
						telas.appendChild(preparaItens);
					}
					
					if (itTel.estilo == Estilo.DIALOGO && itTel.desc == "briefing" && perguntasDLG != null) // se existir mais que uma etapa com Dialogo deve ser testado por código de etapa
					{
						telas.appendChild(perguntasDLG);
					}
					
					for each (var itPerg:StructPerguntas in itTel.perguntas)
					{
						var opId:int = 0;
						perguntas =   <pergunta nivel={itPerg.nivel} id={peId} multi={itPerg.multi} ordenado={itPerg.ordenado ? 1 : 0} BT={itPerg.isBT ? 1 : 0} BE={itPerg.isBE ? 1 : 0} SisMod={itPerg.isSisMod ? 1 : 0} desc={itPerg.desc}></pergunta>
						for each (var itResp:StructRespostas in itPerg.respostas)
						{
							var respostas:XML =   <opcao lk={itResp.link} nivel={opId} valor={itResp.valor} prioridade={itResp.pri} ordem={itResp.ord == " " ? "" : itResp.ord} BT={itResp.haveBTMark ? 1 : 0} BE={itResp.haveBEMark ? 1 : 0} SisMod={itResp.haveSisModMark ? 1 : 0} texto={itResp.desc}/>
							perguntas.appendChild(respostas);
							opId++;
						}
						telas.appendChild(perguntas);
						peId++;
					}
					etapas.appendChild(telas);
					teId++;
				}
				myXML.appendChild(etapas);
				etId++;
			}
		}
		
		
		private function showError(b:Boolean=true, evt:Event=null)
		{
			if (parent.getChildByName("erroTela") != null) {
				if (evt!=null) erroConexaoClass(parent.getChildByName("erroTela")).erro.appendText(evt.toString());
				erroConexaoClass(parent.getChildByName("erroTela")).visible = b;
				erroConexaoClass(parent.getChildByName("erroTela")).BTContinua.visible = false;
				erroConexaoClass(parent.getChildByName("erroTela")).tryConnLabel.visible = b;
				erroConexaoClass(parent.getChildByName("erroTela")).tryConnEngines.visible = b;
				erroConexaoClass(parent.getChildByName("erroTela")).BTSair.visible = !b;
				if (parent.getChildByName("aguardeTela") != null)
					parent.getChildByName("aguardeTela").visible = !b;
			}
		}
		
		
		
		private function processaEtapas():void  
		{
			myXML =   <etapas/>;
			var etId:int = 0;
		
			var util: Util = new Util();
			
			function request():void
			{
				util.requestNTPTime();
			}
			
			function onErrorNTP(evt:Event):void
			{
				util.removeEventListener(NTPEvents.ON_EROOR, onErrorNTP);
				util.removeEventListener(NTPEvents.ON_SUCESS, onGetNtpDate);
				showError(true, evt);
				requestData(evt);
			}
			
			function requestData(e:Event = null)
			{
				util.addEventListener(NTPEvents.ON_SUCESS, onGetNtpDate);//retornou a data do server NTP
				util.addEventListener(NTPEvents.ON_EROOR, onErrorNTP);
				if (e!=null)
					TweenLite.delayedCall(2, request) ;
				else
					request();
			}
			
			function onGetNtpDate(evt:Event)
			{
				util.removeEventListener(NTPEvents.ON_SUCESS, onGetNtpDate);
				util.removeEventListener(NTPEvents.ON_EROOR, onErrorNTP);
				showError(false);
				if (atual.etapa == 2 && atual.tela == 0)
				{
					dados[0].telas[0].date = util.getDateString(false);//grava data inicial global
				}
				if (atual.isEnd)
				{
					dados[dados.length - 1].telas[0].date = util.getDateString(false);//grava data final global
				}
				continua();
			}
			
			if ((atual.etapa == 2 && atual.tela == 0) || atual.isEnd) // se a primeira etapa tela da primeira etapa, ou final, pega hora global para gravar no relatorio
				requestData();
			else
				continua();
			
			function continua()
			{
				var dtIni:String = Util.extractDate(dados[0].telas[0].date);
				var dtFim:String = Util.extractDate(dados[dados.length - 1].telas[0].date);
				var hrIni:String = Util.extractHour(dados[0].telas[0].date);
				var hrFim:String = Util.extractHour(dados[dados.length - 1].telas[0].date);
				
				var game:XML = <game player={playerName} status={atual.isEnd?"completed":"replay"} cliIdFluxo={atual.perfil} cliNomeFluxo={atual.perfilNome2[atual.perfil]} PN={atual.perdeuNegocio} lastEt={atual.lastPos.etapa} lastTe={atual.lastPos.tela} lastPe={atual.lastPos.pergunta} qtPergToCli={atual.qtPergFeitasParaCLi} totPontos={atual.totalPointGame.toFixed(2)}  DataIni={dtIni} hrIni={hrIni} DataFim={dtFim} hrFim={hrFim}  totTime={atual.totalTimeGame}></game>;
				myXML.appendChild(game);
				if (ferramentas != null)
					myXML.appendChild(ferramentas);
				myXML.appendChild(addPtTools(atual.PontosFerramentas));
				myXML.appendChild(pastaCliClicados);
				
				
				
				for each (var itEta:StructEtapa in dados)
				{
					var teId:int = 0;
					
					etapas =   <etapa id={ itEta.id} desc={itEta.desc} peso={itEta.peso} pontos={itEta.totPoints} aux={itEta.aux} note={itEta.anotacoes} textoConceito={itEta.textoConceito}></etapa>;
					for each (var itTel:StructTela in itEta.telas)
					{
						
						var peId:int = 0;
						telas =   <tela time={itTel.time} date={itTel.date} rm={itTel.removido} lk={itTel.link} estilo={Estilo.Lista[Number(itTel.estilo)]} id={itTel.id} pt={itTel.pontuacao} desc={itTel.desc} som={itTel.som} video={itTel.video} vdsufixo={itTel.vdsufixo} imgMask={itTel.imgMask} ajuda={itTel.ajuda} ajudaSom={itTel.ajudaSom}></tela>;
						if (itTel.estilo == Estilo.MINIGAME && itTel.desc == "GaleriaProjetos" && galeriaItens != null)
						{
							telas.appendChild(galeriaItens);
						}
						if (itTel.estilo == Estilo.MINIGAME && itTel.desc == "PreparaApresentacao" && preparaItens != null)
						{
							telas.appendChild(preparaItens);
						}
						
						if (itTel.estilo == Estilo.DIALOGO && itTel.desc == "briefing" && perguntasDLG != null) // se existir mais que uma etapa com Dialogo deve ser testado por código de etapa
						{
							telas.appendChild(perguntasDLG);
						}
						
						for each (var itPerg:StructPerguntas in itTel.perguntas)
						{
							var opId:int = 0;
							perguntas =   <pergunta nivel={itPerg.nivel} id={itPerg.id} multi={itPerg.multi} ordenado={itPerg.ordenado ? 1 : 0} BT={itPerg.isBT ? 1 : 0} BE={itPerg.isBE ? 1 : 0} SisMod={itPerg.isSisMod ? 1 : 0} desc={itPerg.desc} okClk={itPerg.okCliked ? 1 : 0} maxOrd={itPerg.opcaoOrdem}></pergunta>
							for each (var itResp:StructRespostas in itPerg.respostas)
							{
								
								var respostas:XML;
								if (itPerg.okCliked)
									respostas =   <opcao lk={itResp.link} nivel={itResp.nivel} valor={itResp.valor} prioridade={itResp.pri} ordem={itResp.ord} BT={itResp.isBT ? 1 : 0} BE={itResp.isBE ? 1 : 0} SisMod={itResp.isSisMod ? 1 : 0} BT_mk={itResp.haveBTMark ? 1 : 0} BE_mk={itResp.haveBEMark ? 1 : 0} SisMod_mk={itResp.haveSisModMark ? 1 : 0} texto={itResp.desc}/>
								else
									respostas =   <opcao lk={itResp.link} nivel={itResp.nivel} valor={itResp.valor} prioridade={itResp.pri} ordem="" BT={itResp.isBT ? 1 : 0} BE={itResp.isBE ? 1 : 0} SisMod={itResp.isSisMod ? 1 : 0} BT_mk="0" BE_mk="0" SisMod_mk="0" texto={itResp.desc}/>
								perguntas.appendChild(respostas);
								opId++;
								
							}
							telas.appendChild(perguntas);
							peId++;
						}
						etapas.appendChild(telas);
						teId++;
					}
					
					myXML.appendChild(etapas);
					etId++;
				}
				if (textoFinal != null)
				{
					myXML.appendChild(textoFinal);
				}
				dispatchEvent(new NTPEvents(NTPEvents.ON_ETPROCESS));
			}
		}
		
		private function processaDialogos():void
		{
			myXMLDLG =   <dialogos/>;
			
			for each (var itEta:StructEtapaDLG in dadosDLG)
			{
				var etapa:XML =   <etapa id={itEta.id} desc={itEta.desc} som={itEta.som} video={itEta.video}></etapa>;
				for each (var itPerf:StructPerfilDLG in itEta.perfis)
				{
					var perfil:XML =   <perfil id={itPerf.id} desc={itPerf.desc}></perfil>;
					for each (var itPerg:StructPerguntaDLG in itPerf.perguntas)
					{
						var pergunta:XML =  <pergunta agente={itPerg.agente == StructBase.AGENTE_PV ? "PV" : "C"} id={itPerg.id} valor={itPerg.valor} EtPulo={itPerg.EtPulo} TlPulo={itPerg.TlPulo} BT={itPerg.isBT ? 1 : 0} BE={itPerg.isBE ? 1 : 0} SisMod={itPerg.isSisMod ? 1 : 0} som={itPerg.som} video={itPerg.video} desc={itPerg.desc} video2={itPerg.video2} resp={itPerg.resposta}/>
						perfil.appendChild(pergunta);
					}
					etapa.appendChild(perfil);
				}
				myXMLDLG.appendChild(etapa);
			}
		
		}
		
		public function setPergDLG(itXML:XML):Array
		{
			var arrRet:Array=new Array();
			
			if (itXML != null){
				perguntasDLG = itXML;
				
				var perguntas:XMLList = new XMLList();
				
				arrRet = new Array();
				
				perguntas = perguntasDLG.pergunta; 
				for each (var p:XML in perguntas)
				{
					arrRet.push(p.@desc);
				}
			}
			return arrRet;
		}
		
		
		
		public function addPergDLG(pe:StructPerguntaDLG, re:OptBotaoRespClass = null):void
		{
			if (perguntasDLG == null)
				perguntasDLG =  <perguntasDLG/>;
			
			var util: Util = new Util();
			var pergunta:XML =   <pergunta date={util.getDateString()} agente={pe.agente == StructBase.AGENTE_PV ? "PV" : "C"} id={pe.id} valor={pe.valor} EtPulo={pe.EtPulo} TlPulo={pe.TlPulo} BT={pe.haveBTMark ? 1 : 0} BE={pe.haveBEMark ? 1 : 0} SisMod={pe.haveSisModMark ? 1 : 0} desc={pe.desc} resp={re == null ? pe.resposta : (re.correta ? re.dados.resposta : re.dados.respErr)}/>;
			perguntasDLG.appendChild(pergunta);
		}
	
	}

}