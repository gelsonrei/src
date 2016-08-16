package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import flash.utils.ByteArray;
	import GameBontempo.XMLOptLoaderEvents;
	import com.adobe.crypto.MD5;
	
	
	public class XMLLoader extends Sprite  
	{
		
		private var dataPass:URLVariables; 
		private	var urlLoader:URLLoader; 
		private	var previewRequest:URLRequest; 
			
		
		
		private var myXML:XML;
		private var myLoader:URLLoader;
		
				
		public static const chave:String = "0ylLPAExR6y24AWJBBQ8Qp0t6Tg3CSFz8vcgiJvZ2sc";
		public static function HashChave():String
		{
			return MD5.hash(chave);
		}
				
		private var myXMLDLG:XML;
		private var myLoaderDLG:URLLoader;
		
		private var myXMLPRJ:XML;
		private var myLoaderPRJ:URLLoader;
		
		public var galSelArray:Array;
		public var prepSelArray:Array;
		public var miniGaleriaXML:XML;
		public var miniPreparaXML:XML;
		
		public var perguntasDLG:XML;
		public var ferramentasXML:XML;
		public var ptFerramentasXML:XML;
		public var pastaCliClicados:XML;
		
		private var opcoesList:Array;
		
		private var dados:Array;
		private var dadosDLG:Array;
		private var dadosPRJ:Array;
		private var etapasSeq:Array;
		
		public var isReplayGame:Boolean = false;
		public var replayTo:structLastPos = new structLastPos();
		
		public var somaPesos:Number = 0;
		
		public var fileDialogos:String = "Dialogos.xml";
		public var fileEtapas:String = "etapasOrigOrd.xml";
		public var fileProjetos:String = "ProjetoPerfil.xml";
		private var useUserFolder:Boolean = false;
		public var userName:String;
		
		private var testeAuth:GameBontempo.AuthUpDown;
		
		/** chama browser se file=null 
		 */
		public function XMLLoader(file:String=null, action:String="base",user:String=null) 
		{
			
			userName = user;
			fileEtapas = file;
			
			if (file==null)
				loadEtapaBrowse();
			else
			{
				loadEtapa(fileEtapas,action);
			}
		}
		
		
		public function downLoadXML(filename:String,  action:String="base"):void 
		{
			dataPass= new URLVariables();
			//previewRequest = new URLRequest(DefinesLoader.SERVER_PATH + "loading-xml.php");
			//previewRequest = new URLRequest(DefinesLoader.SERVER_PATH + "loading-xml"+"_"+action+".php");
			
			//if (filename == "Dialogos.xml")
			//	previewRequest = new URLRequest( "http://www.urizen.com.br/bontempo/SimVendBT/temp/loading-xml_base.php");
			//else
			
			if (action == "temp")
				previewRequest = new URLRequest(DefinesLoader.LOAD_TEMP);
			else
				previewRequest = new URLRequest(DefinesLoader.LOAD_BASE);
			
			previewRequest.method = URLRequestMethod.POST;
			
			dataPass.hash =  HashChave();
			dataPass.action = action;
			dataPass.filename = filename;
			
			dataPass.tipo = "1";
			dataPass.uid = userName;
			
			//urlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			previewRequest.data = dataPass;
			 
			// calling the PHP or loading the PHP
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			if (DefinesLoader.SERVER_PATH.search("game.bontempo.com.br") >= 0)
				autentica();
			else
				urlLoader.load(previewRequest);
			
		}
		
		private function autentica():void
		{
			testeAuth = new AuthUpDown();
			testeAuth.addEventListener(GameBontempo.AuthEvents.ON_SUCESS,loadPreviewRequest);
			testeAuth.addEventListener(GameBontempo.AuthEvents.ON_EROOR,onErrorAutentica);
			addChild(testeAuth);
			
		}
		
		
		private function loadPreviewRequest(evt:Event = null):void
		{
			testeAuth.removeEventListener(GameBontempo.AuthEvents.ON_SUCESS,loadPreviewRequest);
			testeAuth.removeEventListener(GameBontempo.AuthEvents.ON_EROOR, onErrorAutentica);
			removeChild(testeAuth);
			urlLoader.load(previewRequest);
		}
		
		private function onErrorAutentica(evt:GameBontempo.AuthEvents=null):void
		{
			onError(Event(evt));
		}
		
		
		
		private function loadEtapa(file:String, action:String="base"):void 
		{
			urlLoader= new URLLoader();
			downLoadXML(file,action);
			urlLoader.addEventListener(Event.COMPLETE, processXML);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
		}
		
		private function onError(evt:Event=null):void
		{
			var erroTela:erroConexaoClass = new erroConexaoClass();
			erroTela.erro.appendText(evt.toString());
			erroTela.aviso.text="ERRO DE COMUNICAÇÃO Verifique o acesso à internet e reinicie a seção de jogo."
			erroTela.BTContinua.visible = false;
			erroTela.tryConnLabel.visible = false;
			erroTela.tryConnEngines.visible = false;
			erroTela.BTSair.visible = true;
			parent.addChild(erroTela);
			dispatchEvent(evt);
		}
		
		public function loadEtapaBrowse():void
		{
			var mFileReference:FileReference=new FileReference();
			mFileReference.addEventListener(Event.SELECT, onFileSelected);
			var swfTypeFilter:FileFilter = new FileFilter("XML Files","*.xml");
			mFileReference.browse([swfTypeFilter]);
			
			function onFileSelected(event:Event):void
			{
				trace("onFileSelected");
				
				mFileReference.addEventListener(Event.COMPLETE, onFileLoaded);
				mFileReference.addEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
				mFileReference.load();
			}
			
			 function onFileLoaded(event:Event):void
			{
				var fileReference:FileReference=event.target as FileReference;
				var data:ByteArray=fileReference["data"];
				
				mFileReference.removeEventListener(Event.COMPLETE, onFileLoaded);
				mFileReference.removeEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
				
				fileEtapas = mFileReference.name;
				processXML(event);
			}
			
			 function onFileLoadError(event:Event):void
			{
				trace("onFileLoadError");
			}
		}
		
		
		public function loadDialogos(file:String):void
		{
			urlLoader= new URLLoader();
			downLoadXML(file);
			urlLoader.addEventListener(Event.COMPLETE, processXMLDLG);
		}
		
		public function loadProjetos(file:String):void
		{
			urlLoader= new URLLoader();
			downLoadXML(file);
			urlLoader.addEventListener(Event.COMPLETE, processXMLPRJ);
		}
		
		
		public function loadDialogosBrowse():void
		{
			var mFileReference:FileReference=new FileReference();
			mFileReference.addEventListener(Event.SELECT, onFileSelected);
			var swfTypeFilter:FileFilter = new FileFilter("XML Files","*.xml");
			mFileReference.browse([swfTypeFilter]);
			
			function onFileSelected(event:Event):void
			{
				trace("onFileSelected");
				
				mFileReference.addEventListener(Event.COMPLETE, onFileLoaded);
				mFileReference.addEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
				mFileReference.load();
			}
			
			function onFileLoaded(event:Event):void
			{
				var fileReference:FileReference=event.target as FileReference;
				var data:ByteArray=fileReference["data"];
				
				mFileReference.removeEventListener(Event.COMPLETE, onFileLoaded);
				mFileReference.removeEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
				
				fileDialogos = mFileReference.name;
				processXMLDLG(event);
			}
			
			function onFileLoadError(event:Event):void
			{
				trace("onFileLoadError");
			}
		}
		
		
		private function processXML(e:Event):void {
			var content:String = new String();
			
			var game		:XMLList = new XMLList();
			var etapas		:XMLList = new XMLList();
			var telas		:XMLList = new XMLList();
			var perguntas	:XMLList = new XMLList();
			var respostas	:XMLList = new XMLList();
			
			perguntasDLG =  <perguntasDLG/>;
			
			//trace("XML ");  trace(e.target.data);
			
			myXML = new XML(e.target.data);
			etapas = myXML.etapa;
			dados = new Array();
			etapasSeq = new Array();
			
			game = myXML.game;
			ferramentasXML = myXML.ferramentas[0];
			ptFerramentasXML = myXML.ptFerramentas[0];
			pastaCliClicados = myXML.pastaCliClicados[0];
			
			isReplayGame = game[game.length() - 1].@status == "replay"?true:false;
			
			replayTo.perfil = game[game.length() - 1].@cliIdFluxo;
			replayTo.perdeuNegocio = Number(game[game.length() - 1].@PN);
			replayTo.etapa = game[game.length() - 1].@lastEt;
			replayTo.tela = game[game.length() - 1].@lastTe;
			replayTo.pergunta = game[game.length() - 1].@lastPe;
			replayTo.qtPergFeitasParaCLi = game[game.length() - 1].@qtPergToCli;
			replayTo.totalPointGame  = game[game.length() - 1].@totPontos;
			replayTo.totalTimeGame = game[game.length() - 1].@totTime;
			
			replayTo.dataIni = game[game.length() - 1].@dataIni;
			replayTo.horaIni = game[game.length() - 1].@horaIni;
			replayTo.dataFim = game[game.length() - 1].@dataFim;
			replayTo.horaFim = game[game.length() - 1].@horaFim;
			replayTo.player  = game[game.length() - 1].@player ;
			
			
			for (var et:int=0; et < etapas.length(); et++)
			{
				var itEta:StructEtapa = new StructEtapa();
				itEta.id=etapas[et].@id;
				itEta.desc = etapas[et].@desc;
				itEta.aux = etapas[et].@aux;
				itEta.peso = Number(etapas[et].@peso);
				itEta.pontuacao = Number(etapas[et].@pontos);
				itEta.anotacoes = etapas[et].@note;
				itEta.textoConceito = etapas[et].@textoConceito;
				somaPesos += itEta.peso;
				
				etapasSeq.push(itEta.id);
				
				telas = etapas[et].tela;
				for (var te:int=0; te < telas.length(); te++)
				{
					var itTel:StructTela = new StructTela();
					itTel.estilo = Estilo.convertToEstilo(telas[te].@estilo);
					itTel.link = telas[te].@lk;
					itTel.removido = Number(telas[te].@rm);
					itTel.id = telas[te].@id;
					itTel.desc = telas[te].@desc;
					itTel.id_etapa = itEta.id;
					itTel.video = telas[te].@video;
					itTel.vdsufixo = telas[te].@vdsufixo;
					itTel.imgMask = telas[te].@imgMask;
					itTel.som = telas[te].@som;
					itTel.ajuda = telas[te].@ajuda;
					itTel.ajudaSom = telas[te].@ajudaSom;
					itTel.pontuacao = telas[te].@pt;
					itTel.time = telas[te].@time;
					itTel.date = telas[te].@date;
					
					if(itTel.estilo== Estilo.DIALOGO) perguntasDLG = telas[te].perguntasDLG[0];
					
					if (itTel.estilo == Estilo.MINIGAME && itTel.desc == "GaleriaProjetos")
					{
						if (telas[te].projetos.length()>0)
						{
							miniGaleriaXML = telas[te].projetos[0];
							galSelArray = new Array();
							for (var prj:int=0; prj < telas[te].projetos[0].selecao.length(); prj++)
							{
								//trace(telas[te].projetos[0].selecao[prj].@url);
								var tb:ThumbStruct = new ThumbStruct();
								tb.id = telas[te].projetos[0].selecao[prj].@id;
								tb.url = telas[te].projetos[0].selecao[prj].@url;
								tb.nume = telas[te].projetos[0].selecao[prj].@thumb;
								galSelArray.push(tb);
							}
						}
					}
					
					if (itTel.estilo == Estilo.MINIGAME && itTel.desc == "PreparaApresentacao")
					{
						if (telas[te].preparacao.length()>0)
						{
							miniPreparaXML=  telas[te].preparacao[0];
							prepSelArray = new Array();
							for (var pr:int=0; pr < telas[te].preparacao[0].selecao.length(); pr++)
							{
								//trace(telas[te].preparacao[0].selecao[pr].@texto);
								prepSelArray.push(telas[te].preparacao[0].selecao[pr].@texto);
							}
						}
					}
					
					
					perguntas = telas[te].pergunta;
					for (var pe:int=0; pe < perguntas.length(); pe++)
					{
						var itPerg:StructPerguntas = new StructPerguntas();
						itPerg.id = perguntas[pe].@id;
						itPerg.nivel = perguntas[pe].@nivel;
						itPerg.id_tela = itTel.id;
						itPerg.desc = perguntas[pe].@desc;
						itPerg.multi = int(perguntas[pe].@multi);
						itPerg.isBE = perguntas[pe].@BE == "1"?true:false;
						itPerg.isBT = perguntas[pe].@BT == "1"?true:false;
						itPerg.ordenado = perguntas[pe].@ordenado == "1"?true:false;
						itPerg.okCliked = perguntas[pe].@okClk == "1"?true:false;
						itPerg.opcaoOrdem = perguntas[pe].@maxOrd;
						
						respostas = perguntas[pe].opcao;
						for (var op:int=0; op < respostas.length(); op++)
						{
							var itResp: StructRespostas = new StructRespostas();
							itResp.id_perg = itPerg.id;
							itResp.nivel = respostas[op].@nivel;
							itResp.pri = respostas[op].@prioridade;
							itResp.link = respostas[op].@lk;
							itResp.id = op;
							itResp.desc = respostas[op].@texto;
							itResp.valor = Number(respostas[op].@valor);
							itResp.isSisMod = respostas[op].@SisMod == "1"?true:false;
							itResp.isBE = respostas[op].@BE == "1"?true:false;
							itResp.isBT = respostas[op].@BT == "1"?true:false;
							
							itResp.haveSisModMark = respostas[op].@SisMod_mk == "1"?true:false;
							itResp.haveBEMark = respostas[op].@BE_mk == "1"?true:false;
							itResp.haveBTMark = respostas[op].@BT_mk == "1"?true:false;
							
							itResp.ord = respostas[op].@ordem;
							itResp.sel = respostas[op].@ordem == ""?false:true;
							
							itPerg.respostas.push(itResp);
							
						}
						itEta.qtPerguntas++;
						itTel.perguntas.push(itPerg);
					}
					itEta.telas.push(itTel);
				}
				itEta.qtPerguntas = itEta.qtPerguntas == 0?1:itEta.qtPerguntas;
				dados.push(itEta);
			}
			loadDialogos(fileDialogos);
		}
		
		private function processXMLDLG(e:Event):void {
			var content:String = new String();
			
			var etapas		:XMLList = new XMLList();
			var perfis		:XMLList = new XMLList();
			var perguntas	:XMLList = new XMLList();
			
			myXMLDLG = new XML(e.target.data);
			etapas = myXMLDLG.etapa;
			dadosDLG = new Array();
			
			for (var et:int=0; et < etapas.length(); et++)
			{
				var itEta:StructEtapaDLG = new StructEtapaDLG();
				itEta.id=etapas[et].@id;
				itEta.desc = etapas[et].@desc;
				itEta.video = etapas[et].@video;
				itEta.som = etapas[et].@som;
				
				perfis = etapas[et].perfil;
				for (var pf:int=0; pf < perfis.length(); pf++)
				{
					var itPerf:StructPerfilDLG = new StructPerfilDLG();
					itPerf.id = perfis[pf].@id;
					itPerf.id_etapa = etapas[et].@id;
					itPerf.desc = perfis[pf].@desc;
					
					perguntas = perfis[pf].pergunta;
					for (var pe:int=0; pe < perguntas.length(); pe++)
					{
						var itPerg:StructPerguntaDLG = new StructPerguntaDLG();
						itPerg.agente = perguntas[pe].@agente=="PV"? StructBase.AGENTE_PV  : StructBase.AGENTE_C;
						itPerg.id = perguntas[pe].@id;
						itPerg.id_perfil = perfis[pf].@id;
						itPerg.desc = perguntas[pe].@desc;
						itPerg.isBE = perguntas[pe].@BE == "1"?true:false;
						itPerg.isBT = perguntas[pe].@BT == "1"?true:false;
						itPerg.isSisMod = perguntas[pe].@SisMod == "1"?true:false;
						itPerg.video = perguntas[pe].@video;
						itPerg.video2 = perguntas[pe].@video2;
						itPerg.som = perguntas[pe].@som;
						itPerg.valor = Number(perguntas[pe].@valor);
						//itPerg.relacao = Number(perguntas[pe].@rel);
						//itPerg.prioridade = Number(perguntas[pe].@pri);
						itPerg.EtPulo = Number(perguntas[pe].@EtPulo);
						itPerg.TlPulo = Number(perguntas[pe].@TlPulo);
						itPerg.resposta = perguntas[pe].@resp;
						itPerg.respErr = perguntas[pe].@respErr;
					
						itPerf.perguntas.push(itPerg);
					}
					itEta.perfis.push(itPerf);
				}
				dadosDLG.push(itEta);
			}
			
			loadProjetos(fileProjetos);
			
		}
		
		
		private function processXMLPRJ(e:Event):void {
			var perfis	:XMLList = new XMLList();
			var imagens	:XMLList = new XMLList();
			
			myXMLPRJ = new XML(e.target.data);
			perfis = myXMLPRJ.perfil;
			dadosPRJ = new Array();
			
			for (var p:int=0; p < perfis.length(); p++)
			{
				imagens = perfis[p].imagem;
				for (var i:int=0; i < imagens.length(); i++)
				{
					var it:StructProjetoPerfil = new StructProjetoPerfil();
					it.id=imagens[i].@id;
					it.nome = imagens[i].@nome;
					it.url = imagens[i].@url;
					it.idPerfil = perfis[p].@id;
				
					dadosPRJ.push(it);
				}
			}
			
			var processEvt:XMLOptLoaderEvents = new XMLOptLoaderEvents("onXmlProcessed");
			processEvt.customMessage = "Finished Processing of XML file";
			dispatchEvent(processEvt);
		}
		
		
		
		
		
		
		public function getDataStruct():Array
		{
			return dados;
		}
		
		public function getEtapaSeq():Array
		{
			return etapasSeq;
		}
		
		public function getDataStructDLG():Array
		{
			return dadosDLG;
		}
		
		public function getDataProjetoPerfil(perfil:int=-1):Array
		{
			if (perfil >= 0){
				var filtrado:Array = new Array();
				for each (var prj:StructProjetoPerfil in dadosPRJ) 
				{
					if (prj.idPerfil == perfil)
						filtrado.push(prj);
				}
				return filtrado;
			}
			else return dadosPRJ;
		}
		
	}

}