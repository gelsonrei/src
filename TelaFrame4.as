package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.events.TweenEvent;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import fl.containers.ScrollPane;
	import fl.video.*;
	import fl.video.FLVPlayback;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import fl.containers.UILoader;
	import flash.display.StageDisplayState;
	import flash.display.NativeWindow; 
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import GameBontempo.*;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	
	public class TelaFrame4 extends MovieClip
	{
		private var DEBUGMOD:Boolean = false;
				
		
		private var SkinTemplate:String = "skins/SkinOverPlaySeekStop.swf";
		
		private var statusFinal:String = "Positiva";
		
		
		private var myLoader:GameBontempo.XMLLoader;
		private var mySaver:XMLSaver; 
		private var DadosFromXML:Array;
		private var DialogosFromXML:Array;
		
		private var Atual:AtualStruct;
		private var isReplayChoice:Boolean = false;
		private var isExitsfile:Boolean = false;
		
		
		private var Galeria:GaleriaProjetosClass;
		private var MiniGamePrep:MiniGamePreparaClass;
		
		private var MascaraPRJ:MascaraApPrjClass = new MascaraApPrjClass();
		private var BriefingTecnicoMC:BriefingTecnicoClass; 
		private var TutorialMC :TutorialClass;
		private var historiaMC :ApresentacaoMarcaClass;
		private var BriefingEstiloMC :BriefingEstilosClass;
		
				
				
		
		private var quizBtsArray:Array;
		private var perguntaBTArray:Array;
		private var respostaBTArray:Array;
		
		private var loadingIconMC:MovieClip; 
		private var BlockMC:MovieClip;
		private var VideoContainer:FLVPlayback;
		private var VideoContainer2:FLVPlayback;
		public var SoundContainer:SoundPlayer;
		public var SoundContainer2:SoundPlayer;
		private var MenuEscolhasMC:MovieClip;
		private var FerramentasMC:MovieClip;
		private var RespPergCliMC:MovieClip;
		private var RespPergPVMC:MovieClip;
		private var BlocoNotasMC:MovieClip;
		private var PerguntasMC:MovieClip;
		private var RespostasMC:MovieClip;
		private var BTPerguntasMC:MovieClip;
		private var BTPulaEtapaMC:MovieClip;
		private var PergPaneSP:ScrollPane;
		private var PerguntasHeadMC:MovieClip;
		private var EtapaTituloTF:TextField;
		private var EtapaPT:TextField;
		private var Video2TituloTF:TextField;
		private var ListaEtapasMC:MovieClip;
		private var PastaCliMC:MovieClip;
		private var AjudaLiderBalaoMC:MovieClip;
		private var sexoPV:String;
		private var userName:String;
		private var playerName:String;
		private var PERFIL:int = 0;
		
		private var PergPaneSP_wasVisible:Boolean;
		private var PerguntasHeadMC_wasVisible:Boolean;
		private var MenuEscolhasMC_wasVisible:Boolean;
		private var FerramentasMC_wasVisible:Boolean;
		private var RespPergCliMC_wasVisible:Boolean;
		private var RespPergPVMC_wasVisible:Boolean;
		private var BlocoNotasMC_wasVisible:Boolean;
		private var PerguntasMC_wasVisible:Boolean;
		private var RespostasMC_wasVisible:Boolean;
		private var BTPerguntasMC_wasVisible:Boolean;
		private var BTPulaEtapaMC_wasVisible:Boolean;
		private var ListaEtapasMC_wasVisible:Boolean;
		private var PastaCliMC_wasVisible:Boolean;
		private var btFecharVideo2:fecharClass = new fecharClass();
		private var TelaFinalMC = new TelaFinalClass();
		private var PerguntasMC2_Replay:PerguntasMC2_ReplayClass;
		
		private var isShowBlocoNotas:Boolean = false;
		
		private var isEnableAll = true;
		private var isDisableAll = false;
		
		private var lastVideoPlay:String = new String();
		private var lastAudioPlay:String = new String();
		private var lastVideoPlayAnswer:String = new String();
		private var lastTextAnswer:String = new String();
		private var nextTelaLink:String = new String();
		
		private var nextVideoQuest:int = 0;
		
		private var maxTimeToPlayVdPv:Number = 0;
		private var maxTimeToPlayVdCli:Number = 0;
		
		private var qtPergFeitasParaCLi:int = 0;
		
		private var timerCliPerg:MyTimer;
		private var timerCliPerg_wasRunning:Boolean = false;
		
		public static var erroTela:erroConexaoClass;
		
		private var sizeMenuEscolha:Number;
		
		public function goFullScreen():void
		{
			//verifica e que estado o Flash está "se estiver no estado normal habilita o modo fullScreen"
			if (stage.displayState == StageDisplayState.NORMAL) {
				//stage.displayState = StageDisplayState.FULL_SCREEN;
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			} else {
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		
		public function TelaFrame4(main:MainGameBT)
		{
			//for (var i:int; i < main.numChildren; i++)
			//	MonsterDebugger.trace(this, main.getChildAt(i)+ " "+main.getChildAt(i).name);
		}
		
		public function InitAll()
		{
			
			MonsterDebugger.initialize(this);	
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		
		
		public function setBlockMC(MC:MovieClip):void
		{
			BlockMC = MC;
			BlockMC.x = 0;
			BlockMC.y = 0;
			BlockMC.visible = false;
			BlockMC.BTNextEtapaMC.addEventListener(MouseEvent.CLICK, replayNextToShow);
			BlockMC.BTNextEtapaMC.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT);
			BlockMC.BTNextEtapaMC.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT);
			BlockMC.BTNextEtapaMC.buttonMode = true;
			
			BlockMC.BTPrevEtapaMC.addEventListener(MouseEvent.CLICK, replayPrevToShow);
			BlockMC.BTPrevEtapaMC.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT);
			BlockMC.BTPrevEtapaMC.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT);
			BlockMC.BTPrevEtapaMC.buttonMode = true;
			
			
			BlockMC.BTPlayMC.addEventListener(MouseEvent.CLICK, restartPlay);
			BlockMC.BTPlayMC.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT);
			BlockMC.BTPlayMC.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT);
			BlockMC.BTPlayMC.buttonMode = true;
			
			function onMouseOverBT(evt:MouseEvent):void
			{
				evt.target.alpha = 1;
			}
			
			function onMouseOutBT(evt:MouseEvent)
			{
				evt.target.alpha = .25;
			}
		}
		
		
		
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.stageFocusRect = false
			
			
			//goFullScreen();
			initXMLData();
		}
		
		public function setReplayMode(B:Boolean, existsF:Boolean):void
		{
			isReplayChoice = B;
			isExitsfile = existsF;
		}
		
		
		public function setVideoContainer(VC:FLVPlayback):void
		{
			VideoContainer = VC;
		}
		
		public function setVideoContainer2(VC:FLVPlayback):void
		{
			VideoContainer2 = VC;
		}
		
		
		public function setloadingIconMC(MC:MovieClip):void
		{
			loadingIconMC = MC;
		}
		
		public function setPergPaneSP(MC:ScrollPane):void
		{
			PergPaneSP = MC;
		}
		
		public function setMenuEscolhasMC(MC:MovieClip):void
		{
			MenuEscolhasMC = MC;
			if (GameBontempo.DefinesLoader.DEBUG_MOD=="false")
				MenuEscolhasMC.TFpontos.visible = false;
		}
		
		public function setFerramentasMC(MC:MovieClip):void
		{
			FerramentasMC = MC;
		}
		
		public function setRespPergCliMC(MC:MovieClip):void
		{
			RespPergCliMC = MC;
			
			TweenLite.to(RespPergCliMC.hintBalao, 0.1, { autoAlpha:0, ease:Circ.easeOut } );
			RespPergCliMC.addEventListener(MouseEvent.MOUSE_MOVE, _checkMouseEventTrail);
		}
		
		public function setRespPergPVMC(MC:MovieClip):void
		{
			RespPergPVMC = MC;
		}
		
		public function setBlocoNotasMC(MC:MovieClip):void
		{
			BlocoNotasMC = MC;
		}
		
		public function setPerguntasMC(MC:MovieClip):void
		{
			PerguntasMC = MC;
		}
		
		public function setRespostasMC(MC:MovieClip):void
		{
			RespostasMC = MC;
		}
		
		public function setBTPerguntasMC(MC:MovieClip):void
		{
			BTPerguntasMC = MC;
		}
		
		public function setBTPulaEtapaMC(MC:MovieClip):void
		{
			BTPulaEtapaMC = MC;
		}
		
		public function setPerguntasHeadMC(MC:MovieClip):void
		{
			PerguntasHeadMC = MC;
		}
		
		public function setEtapaTituloTF(MC:TextField):void
		{
			EtapaTituloTF = MC;
		}
		
		public function setTelaPontosTF(MC:TextField):void
		{
			EtapaPT = MC;
			if (GameBontempo.DefinesLoader.DEBUG_MOD=="false")
				EtapaPT.visible = false;
		}
		
		public function setVideo2TituloTF(MC:TextField):void
		{
			Video2TituloTF = MC;
		}
		
		public function setListaEtapasMC(MC:MovieClip):void
		{
			ListaEtapasMC = MC;
		}
		
		public function setPastaCliMC(MC:MovieClip):void
		{
			PastaCliMC = MC;
		}
		
		public function setSexoPV(sexo:String)
		{
			sexoPV = sexo;
		}
		
		public function setUserName(user:String,player:String)
		{
			userName = user;
			playerName = player;
		}
		
		public function setPerfil(p:int=0)
		{
			PERFIL = p;
			MonsterDebugger.trace(this, "Set Perfil "+ PERFIL);
		}
		
		
		public function initXMLData(filename:String=null):void
		{
			
			BTPerguntasMC_wasVisible = false;
			BTPulaEtapaMC_wasVisible = false;
			BTPerguntasMC.visible= BTPerguntasMC_wasVisible;
			BTPulaEtapaMC.visible= BTPulaEtapaMC_wasVisible;
			
			//BlockMC.visible = true;
			
			MonsterDebugger.trace(this, "XMLLoader"+(isExitsfile?userName + "_"+sexoPV+"_temp.xml":"etapas"+PERFIL+".xml ")+(isExitsfile?"temp":"base",userName));
			
			if (filename == "browser")
				myLoader = new GameBontempo.XMLLoader();
			else if (filename != null)
				myLoader = new GameBontempo.XMLLoader(filename);
			else
				myLoader = new GameBontempo.XMLLoader(isExitsfile?userName + "_"+sexoPV+"_temp.xml":"etapas"+PERFIL+".xml",isExitsfile?"temp":"base",userName);
			
			addChild(myLoader);
				
			myLoader.addEventListener(XMLOptLoaderEvents.ON_XML_PROCESSED, onXmlProcessed);
			function onXmlProcessed(evt:XMLOptLoaderEvents)
			{
				DadosFromXML = myLoader.getDataStruct();
				Atual = new AtualStruct(DadosFromXML);
				Atual.isReplayGame = myLoader.isReplayGame;
				Atual.replayTo = myLoader.replayTo;
				DialogosFromXML = myLoader.getDataStructDLG();
				Atual.perfil = PERFIL;
				Atual.sexoPV = sexoPV;
				Atual.etapaLabel = EtapaTituloTF;
				
				if (Atual.isReplayGame)
				{
					Atual.perfil = Atual.replayTo.perfil;
					Atual.perdeuNegocio = Atual.replayTo.perdeuNegocio;
					Atual.totalPointGame = Atual.replayTo.totalPointGame;
					Atual.totalTimeGame = Atual.replayTo.totalTimeGame;
					Atual.setPtFerramentas(myLoader.ptFerramentasXML);
					Atual.qtPergFeitasParaCLi = Atual.replayTo.qtPergFeitasParaCLi;
				}
				
				
				//Atual.perfil = Util.randRange(0, 4); //sorteia perfil
				//MonsterDebugger.trace(this, "perfil: " + Atual.perfil);
				
				
				timerCliPerg = new MyTimer();
				timerCliPerg.init(1000,15);
				timerCliPerg.addEventListener(MyTimerEvents.ON_IDLE_REACHED, showPerguntasCliente);
				
				
				SoundContainer = new SoundPlayer();
				
				SoundContainer2 = new SoundPlayer();
				//SoundContainer.stop();
				//SoundContainer2.stop();
				
				
				initAbaFerramentas();
				initAbaPulaEtapas();
				initVideoContainer();
				initVideoContainer2();
				initMenuEscolhasMC();
				InitAbaPerguntas();
				initBlocoNotas();
				initPastaCli();
				initBriefingTecnico();
				initShowLider();
				initShowHistoria();
				initShowBriefingEstilo();
				initShowConveniencia();
				initTutotial();
				initClickToNext();
				initErrorScreen();
				
				mySaver = new XMLSaver(userName, playerName,  DadosFromXML, DialogosFromXML,Atual);
				mySaver.setFerramentasXML(myLoader.ferramentasXML);
				mySaver.setPergDLG(myLoader.perguntasDLG);
				mySaver.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
				addChild(mySaver);
				
				TelaFinalMC.name = "TelaFinal";
				if (Atual.isReplayGame)// é continuidade de um perfil (game)
				{
					
					if (!isReplayChoice){ //escolheu não dar replay no menu inicial
						replayNextToShow();
						restartPlay();
					}
					else {
						enableAll("initXMLData");
						BTPerguntasMC.visible = false;
						BTPulaEtapaMC.visible = false;
						disablePula();
						lastVideoPlay = DadosFromXML[Atual.etapa].telas[Atual.tela].video;
						replayNextToShow();
					}
				}
				else
				{
					
					BlockMC.visible = false;
					if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.INTRODUCAO)
					{
						
						MonsterDebugger.trace(this, "Mostra Inntrodução");
						ShowLider();
						btFecharVideo2.addEventListener(MouseEvent.CLICK, pulaEtapa);
					} 
					else 
						nextToShow();
				}
				
				VideoContainer.addChild(MascaraPRJ);
				MascaraPRJ.hide();
				SoundContainer.lowVol();
				
			}
		}
		
		
		public function onSave(evt:MouseEvent=null, textoFinal:XML=null)
		{
			MonsterDebugger.trace(this, "Salvando XMLS");
			mySaver.setFerramentasXML(myLoader.ferramentasXML);
			mySaver.setMiniGaleriaXML(myLoader.miniGaleriaXML);
			mySaver.setMiniPreparaXML(myLoader.miniPreparaXML);
			mySaver.setClicadosPastaCli(PastaCliMC.clicados);
			mySaver.setTextoFinal(textoFinal);
			mySaver.saveXmlEtapas(null);
			//Screen.saveImage(stage.stage, VideoContainer.width,VideoContainer.height);
			//mySaver.saveXmlDialogo();
		}
				
		private function onSaveError(evt:IOErrorEvent):void
		{
			VideoContainer.stop();
			SoundContainer.stop();
			EtapaTituloTF.text = "Erro ao Salvar!";
		}
		
//>>>>>>>>>>>     MENU_ESCOLHAS >>>>>>>>>>>>>>>
		function _checkMouseEventTrail (e:MouseEvent):void
		{
			var pt:Point = new Point (mouseX, mouseY);
			//var objects:Array = MenuEscolhasMC.getObjectsUnderPoint (pt); 
			
			e.currentTarget.setChildIndex(e.currentTarget.hintBalao,e.currentTarget.numChildren - 1);
				
			var flag:Boolean = false;
			var texto:String = new String("Descrição");
			var p:* = e.target;
			while (p)
			{
				//MonsterDebugger.trace(this, p.name,mouseX, mouseY, MonsterDebugger.trace(this, MenuEscolhasMC.globalToLocal(pt)) );
				
				if (p.name == "SMBT")
				{
					texto = "Registrar: Sismodular";
					flag = true;
				}
				else if (p.name == "BEBT")
				{
					texto = "Registrar: Briefing de estilos";
					flag = true;
				}
				else if (p.name == "BTBT")
				{
					texto = "Registrar: Briefing técnico";
					flag = true;
				}
				
				
				e.currentTarget.hintBalao.x = e.currentTarget.globalToLocal(pt).x;
				e.currentTarget.hintBalao.y = e.currentTarget.globalToLocal(pt).y + 5;
				
				p = p.parent;
			}
			
			if (flag)
			{
				
				e.currentTarget.hintBalao.hint.text = texto;
				TweenLite.to(e.currentTarget.hintBalao, 1.5, {autoAlpha:1, ease:Circ.easeIn});
			}
			else
			{
				TweenLite.to(e.currentTarget.hintBalao, 1, {autoAlpha:0, ease:Circ.easeOut});
			}
			
			
		}


		private function initMenuEscolhasMC():void
		{
			MenuEscolhasMC.botaoOk.addEventListener(MouseEvent.CLICK, okClicked);
			
			
			
			function okClicked(evt:MouseEvent)
			{
				MonsterDebugger.trace(this, "OK Clicked: " + DadosFromXML[Atual.etapa].desc);
				MonsterDebugger.trace(this, "--------------------------------------------------------");
				MonsterDebugger.trace(this, "");
				
				if (Atual.opcaoOrdem <= 0)
				{
					MonsterDebugger.trace(this, "Deve marcar no 1 opcao exigido");
					return;
				}
				else if ( Atual.perguntaQtMulti < 0 && Atual.opcaoOrdem != (Math.abs(Atual.perguntaQtMulti)) )
				{
					MonsterDebugger.trace(this, "Deve marcar extamente "+(Math.abs(Atual.perguntaQtMulti)));
					return;	
				}
				else if ( Atual.perguntaQtMulti > 0 && Atual.opcaoOrdem < (Math.abs(Atual.perguntaQtMulti)) )
				{
					MonsterDebugger.trace(this, "Deve marcar no minimo "+(Math.abs(Atual.perguntaQtMulti)));
					return;	
				}
				
				DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].okCliked = true;
				
				var util: Util = new Util();
				
				MonsterDebugger.trace(this, "**** 561 - okClicked");
				
				verificaPontos();
				DadosFromXML[Atual.etapa].telas[Atual.tela].time = util.calculeTime(DadosFromXML[Atual.etapa].telas[Atual.tela].date);
				Atual.totalTimeGame += DadosFromXML[Atual.etapa].telas[Atual.tela].time;
				
				
				limpaPontos();
				
				HideMenuEscolhasMC();
				//SoundContainer.stop();
				
				//if (!myLoader.isReplayGame)
				if (DadosFromXML[Atual.etapa].id == "5") //troca na etapa 5
				{
					if (quizBtsArray[1].getOrdem() == 1 && OptBotaoClass(quizBtsArray[1]).dados.pri == 1)
					{
						var sp:Array = DadosFromXML.splice(6, 1);
						DadosFromXML.splice(8, 0, sp[0]);
						DadosFromXML[6].id = 6;
						DadosFromXML[7].id = 7; 
						DadosFromXML[8].id = 8;
						
						reorderAbaPulaEtapas();
					}
					
				}
				
				Atual.nextPergunta(); //muda de pergunta, tela ou etapa conforme caso
				
				if (nextTelaLink != "")
				{ //se tem pergunta que pula tela é testada aqui
					if (nextTelaLink == "OK" && Atual.perdeuNegocio >= 0)  //perdeu o negocio antes de chegar aqui em um OK, entao nao tem choro, vai pra perda de negócio.
						nextTelaLink = "PN";
					while (DadosFromXML[Atual.etapa].telas[Atual.tela].link != nextTelaLink) {
						DadosFromXML[Atual.etapa].telas[Atual.tela].removido = 1;
						DadosFromXML[Atual.etapa].qtPerguntas -= StructTela(DadosFromXML[Atual.etapa].telas[Atual.tela]).perguntas.length;
						Atual.nextTela();
					}
					nextToShow(true); //não pula pra resposta linkada
				}
				else
					nextToShow();
			}
			
			TweenLite.to(MenuEscolhasMC.hintBalao, 0.1, { autoAlpha:0, ease:Circ.easeOut } );
			
			MenuEscolhasMC.addEventListener(MouseEvent.MOUSE_MOVE, _checkMouseEventTrail);
		
		}
		
		
		
		private function ShowMenuEscolhasMC(evt:Event = null):Boolean
		{
			//removeEventListener(MyTimerEvents.ON_IDLE_REACHED, ShowMenuEscolhasMC);
			
			if (sizeMenuEscolha == 0)
				return false;
			
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo != Estilo.QUIZ && DadosFromXML[Atual.etapa].telas[Atual.tela].estilo != Estilo.QUIZ_C_PERGUNTA)
				return false;
			
			var size:int = VideoContainer.height - sizeMenuEscolha;
			
			TweenLite.to(MenuEscolhasMC, (Atual.isReplayGame ?0.1:2), { y: size, ease: Back.easeOut } );
			
			
			if (Atual.isReplayGame) 
				{	
					if(Atual.isBegin())//se em replay testa primeira etapta de  replay
						BlockMC.BTPrevEtapaMC.visible = false;
					else
						BlockMC.BTPrevEtapaMC.visible = true;
						
					if(Atual.testReachReplayEnd())//se em replay testa ultima etapta de  replay
						BlockMC.BTNextEtapaMC.visible = false;
					else
						BlockMC.BTNextEtapaMC.visible = true;
				}
			
			return true;
		}
		
		private function HideMenuEscolhasMC():void
		{
			
			TweenLite.to(MenuEscolhasMC, (Atual.isReplayGame ?0.1:2), { y: VideoContainer.height, ease: Back.easeOut } );
			
		}
		
		private function removeBotoesMenuEscolhasMC()
		{
			for each (var bt:OptBotaoClass in quizBtsArray)
			{
				MenuEscolhasMC.removeChild(bt);
			}
			Atual.opcaoOrdem = 0;
		}
		
		private function populaBotoesMenuEscolhasMC():int
		{
			var item:String = new String();
			var i:int = 0;
			var size = 0;
			var bt:OptBotaoClass;
			
			var lastSz:Number = 25;
			var lastY:Number = 100;
			
			if (DadosFromXML[Atual.etapa].telas.length == 0)
				return 0;
			
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas.length == 0)
				return 0;
			
			var respAtiva:Array = DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].respostas;
			Atual.perguntaQtMulti = DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].multi;
			
			var complemento:String = new String();
			if (Atual.perguntaQtMulti == 1) complemento = " (Escolha única)";
			else if (Atual.perguntaQtMulti > 1) complemento = " (Escolha mínima: "+Atual.perguntaQtMulti+")";
			else if (Atual.perguntaQtMulti < 0) complemento = " (Escolha exata: "+Math.abs(Atual.perguntaQtMulti)+")";
			else complemento = " (Escolha mínima: 1)";
			
			MenuEscolhasMC.textoPergunta.text = DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].desc + complemento;
			
			removeBotoesMenuEscolhasMC();
			quizBtsArray = new Array();
			
			var maxOrd:Number = 0;
			var isOrdem:Boolean = DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].ordenado;
			for each (var resposta:StructRespostas in respAtiva)
			{
				
				bt = new OptBotaoClass(resposta,isOrdem);
				
				//se carregando etapa em replay 
				if (isOrdem)
				{
					if (bt.getOrdem() > maxOrd)
						maxOrd = bt.getOrdem();
				}
				else
				    if (bt.getOrdem()<0)/// se "X" retorna -1
						maxOrd++;
					
				bt.x = 100;
				bt.y = lastY + lastSz + 5;
				
				bt.texto.addEventListener(MouseEvent.CLICK, optBtclicked);
				//bt.addEventListener(MouseEvent.CLICK, optBtclicked);
				bt.addEventListener(MiniBTEvents.ON_CLICK, miniBtclicked);
				bt.addEventListener(MiniBTEvents.ON_CLICK, miniBtclicked);
				bt.addEventListener(MiniBTEvents.ON_CLICK, miniBtclicked);
				
				quizBtsArray.push(bt);
				MenuEscolhasMC.addChild(bt);
				
				lastY = bt.y;
				lastSz = bt.BTcontainerMC.height;
				
				i++;
			}
			Atual.opcaoOrdem = maxOrd;
			
			size = lastY + lastSz;
			size = size < 60 ? 200 : size + 20;
			
			function miniBtclicked(evt:MiniBTEvents)
			{
				
				if (OptBotaoClass(evt.currentTarget).ordem.text != "")
				{
					
					verificaPontos();
					return;
				}
				
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].ordenado)
					atualizaOrdem(evt.currentTarget);
				else
					marcaClickOpt(evt.currentTarget);
					
				DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].opcaoOrdem = Atual.opcaoOrdem;
				verificaPontos();
			}
			
			
			function optBtclicked(evt:MouseEvent=null)
			{
				
				
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].ordenado)
					atualizaOrdem(evt.currentTarget.parent);
				else
					marcaClickOpt(evt.currentTarget.parent);
					
				DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].opcaoOrdem = Atual.opcaoOrdem;
				verificaPontos();
			}
			
			function atualizaOrdem(target:MovieClip)
			{
				if (OptBotaoClass(target).ordem.text == "")
				{
					
					if (Atual.opcaoOrdem == Math.abs(Atual.perguntaQtMulti) && Math.abs(Atual.perguntaQtMulti) == 1) //se apenas uma resposta desmarca outro e marcar este
					{
						for each (var bt:OptBotaoClass in quizBtsArray)
							if (bt.ordem.text == "1"){
								bt.setOrdem("");
								bt.resetMiniBT();
							}
						OptBotaoClass(target).setOrdem(String(Atual.opcaoOrdem));
					}
					else
					if ( Atual.perguntaQtMulti >= 0 || ( Atual.perguntaQtMulti < 0 && Atual.opcaoOrdem < Math.abs(Atual.perguntaQtMulti) ) )
					//if ((Atual.opcaoOrdem < Math.abs(Atual.perguntaQtMulti) && Math.abs(Atual.perguntaQtMulti) > 0) || (Math.abs(Atual.perguntaQtMulti) == 0))
					{
						Atual.opcaoOrdem++;
						OptBotaoClass(target).setOrdem(String(Atual.opcaoOrdem));
					}
					 
					
				}
				else
				{
					var selecOrdem:int = int(OptBotaoClass(target).ordem.text);
					OptBotaoClass(target).setOrdem("");
					
					if (selecOrdem != Atual.opcaoOrdem)
					{
						for (var i:int = 0; i < quizBtsArray.length; i++)
						{
							if (quizBtsArray[i].ordem.text != "" && int(quizBtsArray[i].ordem.text) > selecOrdem)
							{
								quizBtsArray[i].setOrdem(String(int(quizBtsArray[i].ordem.text) - 1));
							}
						}
					}
					OptBotaoClass(target).resetMiniBT();
					Atual.opcaoOrdem--;
				}
				
			}
			
			function marcaClickOpt(target:MovieClip)
			{
				if (OptBotaoClass(target).ordem.text == "")//se não ta marcado, marca
				{
					if (Atual.opcaoOrdem == Math.abs(Atual.perguntaQtMulti) && Math.abs(Atual.perguntaQtMulti) == 1) //se apenas uma resposta desmarca outro e marcar este
					{
						for each (var bt:OptBotaoClass in quizBtsArray)
						{
							if (bt.ordem.text == "X")
							{
								bt.setOrdem("");
								bt.resetMiniBT();
								Atual.opcaoOrdem--;
								
								if (Atual.perdeuNegocio == Atual.etapa * 10000 + Atual.tela * 10 + Atual.pergunta){ //verifica se desmarcou aquele opçao que fez perder negócio
									Atual.perdeuNegocio = -1;   //desabilita perda neste pont0
									MonsterDebugger.trace(this, "Desmarcou LINK = Perdeu negócio "+Atual.etapa +" "+ Atual.tela+" "+ Atual.pergunta);
								}
							}
						}
						if (DadosFromXML[Atual.etapa].telas[Atual.tela].link == "S") //em caso de link com uma sequencia especifica depois desta, quarda qual
						{
							nextTelaLink = OptBotaoClass(target).getDados().link;
							MonsterDebugger.trace(this, "LINK====", nextTelaLink);
						}
						if (DadosFromXML[Atual.etapa].telas[Atual.tela].link == "PN") //guarda perda do negócio  para sair no futuro
						{
							if (OptBotaoClass(target).getDados().link == "PN")
							{
								Atual.perdeuNegocio = Atual.etapa * 10000 + Atual.tela * 10 + Atual.pergunta; //armazena a etapa, tela e pergunta onde perdeu negócio
								MonsterDebugger.trace(this, "Marcou LINK1 = Perdeu negócio "+Atual.etapa +" "+ Atual.tela+" "+ Atual.pergunta);
							}
						}
						OptBotaoClass(target).setOrdem(String("X"));
						Atual.opcaoOrdem++;
					}
					else
					if ( Atual.perguntaQtMulti >= 0 || ( Atual.perguntaQtMulti < 0 && Atual.opcaoOrdem < Math.abs(Atual.perguntaQtMulti) ) )
					{
						lastTextAnswer = OptBotaoClass(target).getDados().desc;
						lastTextAnswer = lastTextAnswer.toLowerCase();
						if (DadosFromXML[Atual.etapa].telas[Atual.tela].link == "S") //em caso de link com uma sequencia especifica depois desta, quarda qual
						{
							nextTelaLink = OptBotaoClass(target).getDados().link;
							MonsterDebugger.trace(this, "LINK====", nextTelaLink);
						}
						if (DadosFromXML[Atual.etapa].telas[Atual.tela].link == "PN") //guarda perda do negócio  para sair no futuro
						{
							if (OptBotaoClass(target).getDados().link == "PN")
							{
								Atual.perdeuNegocio =  Atual.etapa * 10000 + Atual.tela * 10 + Atual.pergunta; //armazena a etapa, tela e pergunta onde perdeu negócio
								MonsterDebugger.trace(this, "Marcou LINK2 = Perdeu negócio"+Atual.etapa +" "+ Atual.tela+" "+ Atual.pergunta);
							}
						}
						Atual.opcaoOrdem++;
						OptBotaoClass(target).setOrdem(String("X"));
					}
				}
				else
				{
					OptBotaoClass(target).setOrdem(""); //se ta marcado, desmarca
					OptBotaoClass(target).resetMiniBT();
					nextTelaLink = "";
					if (Atual.perdeuNegocio == Atual.etapa * 10000 + Atual.tela * 10 + Atual.pergunta){ //verifica se desmarcou aquele opçao que fez perder negócio
						Atual.perdeuNegocio = -1;   //desabilita perda neste pont0
						MonsterDebugger.trace(this, "Desmarcou LINK = Perdeu negócio"+Atual.etapa +" "+ Atual.tela+" "+ Atual.pergunta);
					}
					//if (Atual.perguntaQtMulti > 0)
						Atual.opcaoOrdem--;
				}
			}
			return size;
		}
		
//<<<<<<<<<<<  MENU_ESCOLHAS <<<<<<<<<<<<<<
		
//>>>>>>>>>>>>>>>>> VIDEO COTAINER >>>>>>>>>>>>>
		
		private var oldVideo:String = "";
		private function videoLoad(VC:FLVPlayback, vd:String):void
		{
			//loadingIconMC.visible=true;
			MonsterDebugger.trace(this, "VideoLoad " + vd);
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].imgMask == "")
					MascaraPRJ.hide();
								
			VC.load(GameBontempo.DefinesLoader.ASSETS_PATH+vd);
			if (VC.playing || VC.stopped || vd == oldVideo)
			{
				VC.seek(0);
				VC.play();
			}
			oldVideo = vd;
			VC.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		private function errorHandler(errorEvent:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, "Video não pode ser carregado: " + errorEvent.text);
		}
		
		private function initVideoContainer2():void
		{
			VideoContainer2.fullScreenTakeOver = false;
			VideoContainer2.skin = null;
			VideoContainer2.x = 0;
			VideoContainer2.y = 0;
			VideoContainer2.scaleMode = VideoScaleMode.EXACT_FIT;
			VideoContainer2.width = 1280;
			VideoContainer2.height = 720;
			VideoContainer2.visible = false;
			
			VideoContainer2.addEventListener(VideoEvent.READY, VC2videoReady);
			VideoContainer2.addEventListener(VideoEvent.PLAYING_STATE_ENTERED, VC2initPlay);
			VideoContainer2.addEventListener(VideoEvent.COMPLETE, VC2completePlay);
			
			VideoContainer2.addChild(btFecharVideo2);
			btFecharVideo2.width = 50;
			btFecharVideo2.height = 50;
			btFecharVideo2.x = VideoContainer2.width - btFecharVideo2.width - 10;
			btFecharVideo2.y = btFecharVideo2.height + 10;
			btFecharVideo2.addEventListener(MouseEvent.CLICK, CloseVideo2);
			
			Video2TituloTF.visible = false;
			
			function VC2videoReady(e:VideoEvent):void
			{
				VideoContainer2.play();
			}
			function VC2initPlay(e:VideoEvent):void
			{
			
			} //initPlay
			function VC2completePlay(e:VideoEvent):void
			{
				if(VideoContainer2.source == "Videos/Conveniencias/ConvenienciaCafe.flv")
				 CloseVideo2();
			}
		}
		
		private function ShowVideo2(vd:String, som:String = ""):void
		{
			disableTimer();
			
			//if (som != "" && som != null)
			//	SoundContainer2.play(som);
			
			//SoundContainer.pause();
			VideoContainer.visible = false;
			Video2TituloTF.visible = true;
			if (VideoContainer.state == "playing")
				VideoContainer.pause();
			
			VideoContainer2.visible = true;
			videoLoad(VideoContainer2, vd);
		}
		
		private function CloseVideo2(evt:MouseEvent = null):void
		{
			VideoContainer2.visible = false;
			Video2TituloTF.visible = false;
			VideoContainer.visible = true;
			if (VideoContainer.paused)
				VideoContainer.play();
			//else if (VideoContainer.stopped)
			//	SoundContainer.pause(); //unpause o som
			
			AjudaLiderBalaoMC.animOut();
			//SoundContainer2.stop();
			
			enableTimer();
			
		}
		
		private function initClickToNext():void
		{
			RespPergCliMC.btFecharMC.addEventListener(MouseEvent.CLICK, nextTela);
			RespPergPVMC.btFecharMC.addEventListener(MouseEvent.CLICK, nextTela);
		
			function nextTela(evt:Event = null):void
			{
				
				RespPergCliMC.btFecharMC.visible = false;
				RespPergPVMC.btFecharMC.visible = false;
					
				HideRespPVMC();
				HideRespCliMC();
				Atual.nextTela();
				nextToShow();
			}
		}
		
		private function initVideoContainer():void
		{
			VideoContainer.fullScreenTakeOver = false;
			//VideoContainer.source = "Videos/Etapa01/apresentacaoLiderVendas.flv";
			//VideoContainer.skin = SkinTemplate;
			VideoContainer.skin = null;
			VideoContainer.x = 0;
			VideoContainer.y = 0;
			VideoContainer.scaleMode = VideoScaleMode.EXACT_FIT;
			VideoContainer.width = 1280;
			VideoContainer.height = 720;
			
			MenuEscolhasMC.y = VideoContainer.height;
			
			VideoContainer.addEventListener(VideoEvent.COMPLETE, completePlay);
			VideoContainer.addEventListener(VideoEvent.PLAYHEAD_UPDATE, loop);
			VideoContainer.addEventListener(VideoEvent.PLAYING_STATE_ENTERED, initPlay);
			VideoContainer.addEventListener(VideoEvent.READY, videoReady);
			
			//nextToShow();
			
			function loop(e:VideoEvent):void
			{
			}
			
			
			
			function completePlay(e:VideoEvent=null):void
			{
				//if (!Atual.isReplayGame) 
					enableAll("completePlay");
				//else
				if (Atual.isReplayGame) 
				{
					
					BTPerguntasMC.visible = false;
					BTPulaEtapaMC.visible = false;
					
				}
				
				var util: Util;// = new Util();
				MonsterDebugger.trace(this, "Complete Play id: " + DadosFromXML[Atual.etapa].id + " Atual.etapa:" + Atual.etapa + " tl:" + Atual.tela + "  pg:" + Atual.pergunta + " DlgMode: " + " Estilo:" + DadosFromXML[Atual.etapa].telas[Atual.tela].estilo + " Video:" + lastVideoPlay);
				switch (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo)
				{
					case Estilo.QUIZ: //0	
						ShowMenuEscolhasMC();
						break;
					case Estilo.VIDEO: //2
						if (Atual.isReplayGame) break;
						
						util = new Util();
						
						MonsterDebugger.trace(this, "**** 1050 - completePlay");
					
						DadosFromXML[Atual.etapa].telas[Atual.tela].time = util.calculeTime(DadosFromXML[Atual.etapa].telas[Atual.tela].date);
						Atual.totalTimeGame += DadosFromXML[Atual.etapa].telas[Atual.tela].time;
						Atual.nextTela();
						nextToShow();
						break;
					case Estilo.VIDEO_PV_AFIRMA: //4
						if (Atual.isReplayGame) break;
						break;
					case Estilo.VIDEO_C_AFIRMA: //5
						if (Atual.isReplayGame) break;
						break;
					case Estilo.MINIGAME: //3 
					{
						MonsterDebugger.trace(this, "Tela Desc " + DadosFromXML[Atual.etapa].telas[Atual.tela].desc);
							
						if (DadosFromXML[Atual.etapa].telas[Atual.tela].desc == "GaleriaProjetos")
						{
							Galeria = new GaleriaProjetosClass(myLoader.galSelArray, myLoader.getDataProjetoPerfil(Atual.perfil)); //passa lista de selecioanados caso de isReplayGame e lista de projetos do perfil corrente
							VideoContainer.addChild(Galeria);
							Galeria.btOk_MC.addEventListener(MouseEvent.CLICK, onProjetoSelected);
							Galeria.addEventListener(MouseEvent.CLICK, verificaPontos);
							Galeria.addEventListener(MiniGameEvents.ON_HITAREA_DROPPED, verificaPontos);
							
						}
						if (DadosFromXML[Atual.etapa].telas[Atual.tela].desc == "PreparaApresentacao")
						{
							MiniGamePrep = new MiniGamePreparaClass(myLoader.prepSelArray); //passa lesta de selecioanados caso de isReplayGame
							if (GameBontempo.DefinesLoader.DEBUG_MOD == "false")
								MiniGamePrep.EtapaPT.visible = false;
							VideoContainer.addChild(MiniGamePrep);
							MiniGamePrep.btOk_MC.addEventListener(MouseEvent.CLICK, onPreparaOk);
							MiniGamePrep.addEventListener(MiniGameEvents.ON_HITAREA_DROPPED, verificaPontos);
							MiniGamePrep.addEventListener(MiniGameEvents.OUT_HITAREA_DROPPED, verificaPontos);
						}
					}
						break;
					case Estilo.DIALOGO: //1
					{
						if (Atual.isReplayGame) break;
						
						if (DlgState.ATUAL == DlgState.PVWAIT)
						{
							DlgState.ATUAL = DlgState.IDLE;
							timerCliPerg.reset();
						}
						else if (DlgState.ATUAL == DlgState.PVASK)
						{
							DlgState.ATUAL = DlgState.PVWAIT;
							HideRespPVMC();
							ShowRespCliMC();
							videoLoad(VideoContainer, lastVideoPlayAnswer);
						}
						else if (DlgState.ATUAL == DlgState.CLIASK)
						{
							DlgState.ATUAL = DlgState.CLIWAIT;
						}
						else if (DlgState.ATUAL == DlgState.CLIWAIT)
						{
							DlgState.ATUAL = DlgState.IDLE;
							hidePerguntasCliente();
							timerCliPerg.reset();
						}
					}
						break;
				}
				
			} //completePlay
			
			
			
			function initPlay(e:VideoEvent=null):void
			{
				if (loadingIconMC.visible == true) {
					loadingIconMC.visible=false;
				}
				
				HideMenuEscolhasMC();
				RespPergCliMC.btFecharMC.visible = false;
				RespPergPVMC.btFecharMC.visible = false;
				
				
				MonsterDebugger.trace(this, "initPlay id: " + DadosFromXML[Atual.etapa].id + " Atual.etapa:" + Atual.etapa + " tl:" + Atual.tela + "  pg:" + Atual.pergunta + " DlgMode: " + " Estilo:" + DadosFromXML[Atual.etapa].telas[Atual.tela].estilo + " Video:" + lastVideoPlay);
				EtapaTituloTF.text = DadosFromXML[Atual.etapa].desc;
				if (!Atual.isReplayGame ) {
					
					MonsterDebugger.trace(this,  lastAudioPlay , SoundContainer.filePlaying());
					if (lastAudioPlay != SoundContainer.filePlaying()){
						SoundContainer.play(lastAudioPlay);
						if (SoundContainer.getVol()>0.2)
							SoundContainer.lowVol();
					}
				}
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.VIDEO_PV_AFIRMA)
				{
					ShowRespPVMC();
					RespPergCliMC.btFecharMC.visible = true;
					RespPergPVMC.btFecharMC.visible = true;
				}
				else if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.VIDEO_C_AFIRMA)
				{
					ShowRespCliMC();
					RespPergCliMC.btFecharMC.visible = true;
					RespPergPVMC.btFecharMC.visible = true;
				}
				else if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.QUIZ_C_PERGUNTA)
				{
					MenuEscolhasMC.visible = true;
					ShowMenuEscolhasMC();
				}
				
				
				
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].imgMask != "")
				{
					MascaraPRJ.load(DadosFromXML[Atual.etapa].telas[Atual.tela].imgMask)
					MascaraPRJ.show();
				}
				
				
				if (Atual.isReplayGame )
				{
					VideoContainer.stop();
					VideoContainer.seek(VideoContainer.totalTime / 2);
					BlockMC.visible = true;
					BlockMC.x = 0;
					BlockMC.y = 0;
					//enableAll();
					
					
					
					if(Atual.isBegin())//se em replay testa primeira etapta de  replay
						BlockMC.BTPrevEtapaMC.visible = false;
					else
						BlockMC.BTPrevEtapaMC.visible = true;
						
					if(Atual.testReachReplayEnd())//se em replay testa ultima etapta de  replay
						BlockMC.BTNextEtapaMC.visible = false;
					else
						BlockMC.BTNextEtapaMC.visible = true;
				
					completePlay();
				}
				
			
			} //initPlay
			
			function videoReady(e:VideoEvent):void
			{
				
				MonsterDebugger.trace(this, "VideoReady id: " + DadosFromXML[Atual.etapa].id + " Atual.etapa:" + Atual.etapa + " tl:" + Atual.tela + "  pg:" + Atual.pergunta + " Estilo:" + DadosFromXML[Atual.etapa].telas[Atual.tela].estilo + " Video:" + lastVideoPlay);
				
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
					disableAll(true);
				
				
				if (Atual.testReachReplayEnd())//se em replay testa ultima etapta de  replay
				{	
				}
				
				if (Atual.isReplayGame)
				{
					initPlay();
				}
				else
				{
					var seekPointPV:Number = VideoContainer.totalTime - maxTimeToPlayVdPv;
					var seekPointCli:Number = VideoContainer.totalTime - maxTimeToPlayVdCli;
					
					if (seekPointPV > 0 && (DlgState.ATUAL == DlgState.CLIWAIT || DlgState.ATUAL == DlgState.PVASK))
					{ //PV selecionou resposta (optBtclicked) e roda video do PV com resposta
						VideoContainer.seek(seekPointPV); //PV perguntou (optBtclicked), mostra video do pv perguntando, no videoOmpleted mostra video do CLi respondendo (lastVideoPlayAnswer)
						MonsterDebugger.trace(this, "VideoReady PV: " + VideoContainer.totalTime + " - " + maxTimeToPlayVdPv + " = " + seekPointPV);
					}
					else if (seekPointCli > 0 && (DlgState.ATUAL == DlgState.PVWAIT || DlgState.ATUAL == DlgState.CLIASK))
					{ //  CLi respondendo deposi da pergunta do PV(lastVideoPlayAnswer)
						VideoContainer.seek(seekPointCli); //disparado pelo timer, cliente faz pergunta, mostra video do cliente perguntando
						MonsterDebugger.trace(this, "VideoReady CLI: " + VideoContainer.totalTime + " - " + maxTimeToPlayVdCli + " = " + seekPointCli);
					}
					else
					{	//não esta em modo de dialogo.
						if (seekPointPV > 0 && maxTimeToPlayVdPv > 0)
						{
							VideoContainer.seek(seekPointPV);
							MonsterDebugger.trace(this, "VideoReady PV: " + VideoContainer.totalTime + " - " + maxTimeToPlayVdPv + " = " + seekPointPV);
						}
						else if (seekPointCli > 0 && maxTimeToPlayVdCli > 0)
						{
							VideoContainer.seek(seekPointCli);
							MonsterDebugger.trace(this, "VideoReady CLI: " + VideoContainer.totalTime + " - " + maxTimeToPlayVdCli + " = " + seekPointCli);
						}
					}
					VideoContainer.play();
				}
				
				
			}
			
			function onProjetoSelected(evt:MouseEvent = null)
			{
				var PrjSel:Array;
				PrjSel = Galeria.getSelected();
				Galeria.printSelected();
				verificaPontos();
				var util: Util = new Util();
				
				MonsterDebugger.trace(this, "**** 1266 - onProjetoSelected");
				
				DadosFromXML[Atual.etapa].telas[Atual.tela].time = util.calculeTime(DadosFromXML[Atual.etapa].telas[Atual.tela].date);
				Atual.totalTimeGame += DadosFromXML[Atual.etapa].telas[Atual.tela].time;
				mySaver.addMiniGameGaleria(PrjSel);
				removeMiniGame();
				Atual.nextTela();
				nextToShow();
				
			}
			
			function onPreparaOk(evt:MouseEvent = null)
			{
				var util: Util = new Util();
				
				MonsterDebugger.trace(this, "**** 1285 - onPreparaOk");
			
				DadosFromXML[Atual.etapa].telas[Atual.tela].time = util.calculeTime(DadosFromXML[Atual.etapa].telas[Atual.tela].date);
				Atual.totalTimeGame += DadosFromXML[Atual.etapa].telas[Atual.tela].time;
				mySaver.addMiniGamePrepara(MiniGamePrep.getSelected());
				removeMiniGame();
				Atual.nextTela();
				nextToShow();
			}
		}
		
		private function removeMiniGame():Boolean
		{
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.MINIGAME)
			{
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].desc == "GaleriaProjetos")
				{
					if (Galeria == null) return false;
					VideoContainer.removeChild(Galeria);
					return true;
				}
				
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].desc == "PreparaApresentacao")
				{
					if (MiniGamePrep == null) return false;
					VideoContainer.removeChild(MiniGamePrep);
					MiniGamePrep.removeEventListener(MiniGameEvents.ON_HITAREA_DROPPED, verificaPontos);
					return true;
				}
				return false;
			}
			
			return false;
		}
		
		
		private function replayNextToShow(evt:Event = null):void
		{
			BlockMC.BTNextEtapaMC.visible = false;
			BlockMC.BTPrevEtapaMC.visible = false;
			
			
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
			{
				if (PerguntasMC2_Replay != null)
					removeChild(PerguntasMC2_Replay);
			}
			
			//disableAll(false,"replayNextToShow");
			HideMenuEscolhasMC();
			HideRespCliMC();
			HideRespPVMC();
			removeMiniGame();
			
			
			
			if (lastVideoPlay!="")
				Atual.nextPergunta();
			else
			{//pega video anterior caso nao exista
				Atual.prevTela();
				lastVideoPlay = getLastVideoPlay(DadosFromXML[Atual.etapa].telas[Atual.tela].video);
				Atual.nextTela();
				Atual.nextPergunta();
			}
			
			while (DadosFromXML[Atual.etapa].telas[Atual.tela].removido == 1) 
			{
				Atual.nextPergunta();
			}
			nextToShow();
		}
		
		private function replayPrevToShow(evt:Event = null):void
		{
			
			BlockMC.BTNextEtapaMC.visible = false;
			BlockMC.BTPrevEtapaMC.visible = false;
			
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
			{
				if (PerguntasMC2_Replay != null)
					removeChild(PerguntasMC2_Replay);
			}
			
			HideMenuEscolhasMC();
			HideRespCliMC();
			HideRespPVMC();
			removeMiniGame();
			
					
			
			if (lastVideoPlay!="")
				Atual.prevTela();
			else
			{//pega video anterior caso nao exista
				Atual.nextTela();
				lastVideoPlay = getLastVideoPlay(DadosFromXML[Atual.etapa].telas[Atual.tela].video);
				Atual.prevTela();
				Atual.prevTela();
			}
			while (DadosFromXML[Atual.etapa].telas[Atual.tela].removido == 1)
			{
				Atual.prevTela();
			}	
			
			
			nextToShow();
		}
		
		private function nextToShow(testJump:Boolean = false):void
		{
			
			MonsterDebugger.trace(this, "nextToShow");
			
			if (Atual.isEnd)
			{
				var aguarde:AguardeCalculandoClass = new AguardeCalculandoClass();
				aguarde.name = "aguardeTela";
				addChild(aguarde);
				
				var notaNormal:Number = Atual.totalPointGame / Atual.pesoTotal;
				var frame:int = 1;
							
				var conceitoFinal:String = "Desempenho ";
				TelaFinalMC.BTSair.visible = false;
				if (GameBontempo.DefinesLoader.DEBUG_MOD=="false")
					TelaFinalMC.Pontos.visible = false;				
				TelaFinalMC.Pontos.text =  String("Nota final: " + Atual.totalPointGame.toFixed(2));
				//TelaFinalMC.retiMC.visible = false;
				
				if (notaNormal >= 0.58 && Atual.qtPergFeitasParaCLi == 0) //se nao fez o briefing nao pode levar bom pra cima
					notaNormal = 0.57;
				
				if (notaNormal < 0.323) {
					frame = 1;
					TelaFinalMC.MC_Conceito.gotoAndStop(1);
					conceitoFinal += "INSUFICIENTE.";
					TelaFinalMC.TextoConceito.text = "Atenção! Seu desempenho no GAME mostra a necessidade de revisar seu processo de trabalho em praticamente todas as etapas simuladas no  mesmo. É necessário o desenvolvimento de conhecimentos específicos sobre os produtos da Bontempo, seu processo fabril, seus objetivos e formas de conduzir o processo. Alinhar seu perfil profissional ao da Empresa é um primeiro passo importante, uma vez que seu trabalho é o elo de ligação real entre a Bontempo e o cliente. Procure as informações disponibilizadas nas comunidades de prática da Bontempo as quais você faz parte, leia atentamente, tire suas dúvidas com colegas de trabalho ou com a própria empresa (com a responsável pelo Programa Caminhos do Saber) e refaça o jogo calma e atenciosamente.";
					TelaFinalMC.TextoConceito.text += " Para atingir o nível máximo de desempenho sugerimos que retome o(s) aspecto(s):"
				}
				else if (notaNormal < 0.58) {
					frame = 2;
					TelaFinalMC.MC_Conceito.gotoAndStop(2);
					conceitoFinal += "REGULAR. ";
					TelaFinalMC.TextoConceito.text = "Seu desempenho no GAME não foi satisfatório, mas sabemos e acreditamos na sua capacidade de superar as dificuldades existentes. Para isto você precisa aprimorar e desenvolver conhecimentos específicos e formas de condução do processo de vendas que estejam alinhados com o perfil da Bontempo. Sugerimos que refaça todo o percurso do GAME, ficando atento as particularidades de cada etapa. O estudo dos produtos Bontempo, seus diferenciais, processos de trabalho e parceiros (disponíveis nas comunidades de prática) podem ser úteis ao aprofundamento dos conhecimentos técnicos e facilitar sua tomada de decisões quanto aos comportamentos adequados a cada situação específica que se desenvolve em um processo de vendas. Lembre que o GAME foi modulado de acordo com as características de cada personagem, pois a individualidade e o perfil de cada cliente exige uma abordagem diferenciada.";
					TelaFinalMC.TextoConceito.text += " Para atingir o nível máximo de desempenho sugerimos que retome o(s) aspecto(s):"
				}
				else if (notaNormal < 0.83) {
					frame = 3;
					TelaFinalMC.MC_Conceito.gotoAndStop(3);
					conceitoFinal += "BOM.";
					TelaFinalMC.TextoConceito.text = "Seu desempenho no GAME foi bom, embora exista espaço para aprimoramentos. Seu nível de conhecimentos e forma de conduzir o trabalho em vendas está alinhado, de forma geral, com o perfil Bontempo. Em alguns aspectos pode haver avanços, conforme destaques abaixo que foram retirados a partir do seu desempenho em cada uma das etapas do GAME. Seus conhecimentos e comportamentos demonstram apropriação das habilidades técnicas e comportamentais fundamentais, as quais podem atingir um nível de excelência com alguns ajustes. ";
					TelaFinalMC.TextoConceito.text += " Para atingir o nível máximo de desempenho sugerimos que retome o(s) aspecto(s):"
				}
				else {
					frame = 4;
					TelaFinalMC.MC_Conceito.gotoAndStop(4);
					conceitoFinal += "EXCELENTE.";
					TelaFinalMC.TextoConceito.text = "Parabéns! Seu nível de conhecimento e forma de conduzir o trabalho no setor de vendas está fortemente alinhado com o perfil Bontempo. Seus conhecimentos e comportamentos demonstram apropriação das competências técnicas e comportamentais necessárias para o desenvolvimento adequado de todo o processo de trabalho. Esperamos que você continue em constante aprimoramento, participando das demais atividades do Programa de Capacitação Caminhos do Saber Bontempo, inclusive das demais situações apresentadas na forma de GAME.";
				}
				
				var conceitoXML:XML = <conceito/>
				
				var cabecalho = <cabecalho  texto={conceitoFinal}/> 
				conceitoXML.appendChild(cabecalho);
				cabecalho = <cabecalho texto={TelaFinalMC.TextoConceito.text} />
				conceitoXML.appendChild(cabecalho);
				
				if (notaNormal < 0.83) {
					var complemento:String = "";// "\n\nPara atingir o nível máximo de desempenho sugerimos que retome o(s) aspecto(s):\n\n"
					var etapaConceito:XML;// =   <etapa id={"0"} nome={"cabecalho_complemento"} texto={"Para atingir o nível máximo de desempenho sugerimos que retome o(s) aspecto(s):"} />;
					//conceitoXML.appendChild(etapaConceito);
					
					for each (var itEt:StructEtapa in DadosFromXML) 
					{
						var med:Number = itEt.totPoints / itEt.peso;
						if (med < 0.7) { //se media na etapa for menor que 7 mostra comentario sobre auqela etapa
							complemento += (itEt.desc + ":  " + itEt.textoConceito + "\n\n");
							etapaConceito =   <etapa id={itEt.id} nome={itEt.desc} texto={itEt.textoConceito} />;
							conceitoXML.appendChild(etapaConceito);
						}
					}
					//TelaFinalMC.retiMC.visible = true;
					TelaFinalMC.TextoConceito.text += complemento;
				}
				
				mySaver.addEventListener(Event.COMPLETE, onSaved);
				
				onSave(null, conceitoXML);
				
				function onSaved(e:Event)
				{
					mySaver.removeEventListener(Event.COMPLETE, onSaved);
					removeChild(aguarde);
					addChild(TelaFinalMC);
								
					if (sexoPV == "Masculino")
						TelaFinalMC.SilhuetaSexoMC.gotoAndStop(2);
					else 
						TelaFinalMC.SilhuetaSexoMC.gotoAndStop(1);
					TelaFinalMC.MC_Conceito.gotoAndStop(frame);
					
					TelaFinalMC.BTSair.visible = true;
					MonsterDebugger.trace(this, "Salvou XMLS");
					trace("Salvou XMLS");
				}
				
				return;
			}
			
			
			if (Atual.isReplayGame)
			{
				
			}
			else if (Atual.etapa > 1) onSave();
			
			
			
			
			if (!testJump && nextTelaLink != "" && !Atual.isReplayGame)
			{ //pula telas que não lincaram com pergunta anterior qdo existir
				if (nextTelaLink == "OK" && Atual.perdeuNegocio >= 0)  //perdeu o negocio antes de chegar aqui em um OK, entao nao tem choro, vai pra perda de negócio.
						nextTelaLink = "PN";
				while (DadosFromXML[Atual.etapa].telas[Atual.tela].link != "" && DadosFromXML[Atual.etapa].telas[Atual.tela].link != "S" && DadosFromXML[Atual.etapa].telas[Atual.tela].link != "=")// se = indiferente a opção, vai rodar a tela a seguir
				{
					DadosFromXML[Atual.etapa].telas[Atual.tela].removido = 1;
					DadosFromXML[Atual.etapa].qtPerguntas -= StructTela(DadosFromXML[Atual.etapa].telas[Atual.tela]).perguntas.length;
					Atual.nextTela();
				}
				nextTelaLink = "";
			}
			
			while (Atual.isPulaTelaAtual()){ //feito para pular do briefing x apresenta projeto = ainda nao usado
				Atual.nextTela();
			}
			
			var link:String = DadosFromXML[Atual.etapa].telas[Atual.tela].link;
			if (link.search("PE")==0)   //pular se achar tag na tela
			{
				Atual.gotoEtapa(Number(link.substr(3)));
			}
			
			
			
			var util:Util = new Util();	
			MonsterDebugger.trace(this, "**** 1534 - nextToShow");
			
			DadosFromXML[Atual.etapa].telas[Atual.tela].date = util.getDateString(true);//data e hora locais
			
			
			MonsterDebugger.trace(this, "");
			MonsterDebugger.trace(this, "");
			MonsterDebugger.trace(this, "------------------------------------");
			MonsterDebugger.trace(this, "NextToShow id: " + DadosFromXML[Atual.etapa].id + " Atual.etapa:" + Atual.etapa + " tl:" + Atual.tela + "  pg:" + Atual.pergunta + " DlgMode: " + " Estilo:" + DadosFromXML[Atual.etapa].telas[Atual.tela].estilo);
			
			
			lastAudioPlay = DadosFromXML[Atual.etapa].telas[Atual.tela].som;
			lastVideoPlay = getLastVideoPlay(DadosFromXML[Atual.etapa].telas[Atual.tela].video);
			
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
			{
				
				DlgState.ATUAL = DlgState.PVWAIT;
				
				if (Atual.isReplayGame)
				{
					PerguntasMC2_Replay = new PerguntasMC2_ReplayClass();
					PerguntasMC2_Replay.setPerguntas(myLoader.perguntasDLG);
					addChild(PerguntasMC2_Replay);
					PerguntasMC2_Replay.y = 10;
				}
				else
				{
					populaPerguntasPV();
					populaRespostasParaCli(-1);
					enablePerguntas();
					MonsterDebugger.trace(this, "enablePerguntas nextToShow");
					enablePula();
					Atual.pergunta = 0;
				}
				
				RespPergCliMC.btFecharMC.visible = false;
				RespPergPVMC.btFecharMC.visible = false;
				HideRespPVMC();
				HideRespCliMC();
				hidePerguntasCliente();
			}
			else
			{
				disablePerguntas();
				MonsterDebugger.trace(this, "disablePerguntas nextToShow");
				//disablePula();
				
				timerCliPerg.reset();
				timerCliPerg.stop();
				
				maxTimeToPlayVdCli = 0;
				maxTimeToPlayVdPv = 0;
				
				
				
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.QUIZ || DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.QUIZ_C_PERGUNTA)
				{
					sizeMenuEscolha = populaBotoesMenuEscolhasMC();
					if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.QUIZ_C_PERGUNTA)
						maxTimeToPlayVdCli = calcVideoPlayTime(DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].desc.length);
				}
				else if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.VIDEO_PV_AFIRMA)
				{
					var temp:String = String(DadosFromXML[Atual.etapa].telas[Atual.tela].desc).replace("##", lastTextAnswer);
					RespPergPVMC.setTexto(temp);
					maxTimeToPlayVdPv = calcVideoPlayTime(temp.length);
				}
				else if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.VIDEO_C_AFIRMA)
				{
					RespPergCliMC.setTexto(DadosFromXML[Atual.etapa].telas[Atual.tela].desc);
					maxTimeToPlayVdCli = calcVideoPlayTime(DadosFromXML[Atual.etapa].telas[Atual.tela].desc.length);
				}
				
			}
			
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.QUIZ && lastVideoPlay == "")
			{
				ShowMenuEscolhasMC();
			}
			else
			{
				MonsterDebugger.trace(this, "Video: " + lastVideoPlay);
				videoLoad(VideoContainer, lastVideoPlay);
			}
			/*
			if (Atual.isReplayGame) 
			{	
				if(Atual.isBegin())//se em replay testa primeira etapta de  replay
					BlockMC.BTPrevEtapaMC.visible = false;
				else
					BlockMC.BTPrevEtapaMC.visible = true;
					
				if(Atual.testReachReplayEnd())//se em replay testa ultima etapta de  replay
					BlockMC.BTNextEtapaMC.visible = false;
				else
					BlockMC.BTNextEtapaMC.visible = true;
			}
			*/
		
		}
		
		
		private function getLastVideoPlay(atual:String):String
		{
			var ret:String = atual;
			
			if (ret != "Videos/videoProducao.flv" && ret != "")
			{
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].vdsufixo == "PV")
					ret += sexoPV + ".flv";
				else if (DadosFromXML[Atual.etapa].telas[Atual.tela].vdsufixo == "CLI")
					ret += Atual.perfilNome[Atual.perfil] + ".flv";
				else if (DadosFromXML[Atual.etapa].telas[Atual.tela].vdsufixo == "CLI_PV")
					ret += Atual.perfilNome[Atual.perfil] + "_" + sexoPV + ".flv";
				else if (DadosFromXML[Atual.etapa].telas[Atual.tela].vdsufixo == "FIM"){
					if (DadosFromXML[Atual.etapa].desc != "Finalizando o atendimento"	) statusFinal = "Negativa";
					ret += statusFinal + "_" + Atual.perfilNome[Atual.perfil] + "_" + sexoPV + ".flv";
				}
			}
			return ret;
		}
		
//<<<<<<<<<<<< VIDEO COTAINER <<<<<<<<<<<<<<<<

		private function verificaPontos(evt:Event=null):String
		{
			//MonsterDebugger.trace(this, evt.customMessage);
			var soma:Number = 0;
			var ckBTBESM:int = 0;
			var countVal:int = 0;
			var countSel:int = 0;
			var countEssenc = 0;
			var count:int = 0;
			
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.QUIZ || DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.QUIZ_C_PERGUNTA)
			{
				var isOrdem:Boolean = DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].ordenado;
				//var nResp:int = DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].respostas.length;
				var nResp:int = DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].multi;
				
				var dif:Number = 0;
				var deb:Number = 0;
				
				ckBTBESM = 0;
		
				for each (var itResp:StructRespostas in DadosFromXML[Atual.etapa].telas[Atual.tela].perguntas[Atual.pergunta].respostas)
				{
					var ord:String = itResp.ord;
					
					if (isOrdem)
					{
						var pri:int = itResp.pri;
						var ordN:Number = Number (ord == ""? "0":ord);
						ordN = ordN == 0?pri:ordN;
						if 	(itResp.valor > 0) 
							dif += Math.abs(ordN - pri);
						else if (itResp.sel)
							deb += itResp.valor * pri;//valor de debito para resp muito errada (-1 no valor)
						soma = 10 * (1 - (dif / (nResp / 2 * nResp)));
						soma += deb;
					}
					else 
					{
						if (itResp.sel)
							count++;
						soma += ord == "X"?Number(itResp.valor):0;
						
					}
					
					if (itResp.isBT && itResp.haveBTMark)
						ckBTBESM++;
					if (itResp.isBE && itResp.haveBEMark)
						ckBTBESM++;
					if (itResp.isSisMod && itResp.haveSisModMark)
						ckBTBESM++;
						
				}
				soma += ckBTBESM * 0.5;
				
				if (GameBontempo.DefinesLoader.DEBUG_MOD=="true")
					MenuEscolhasMC.TFpontos.text = String(soma.toFixed(3));
				DadosFromXML[Atual.etapa].telas[Atual.tela].pontuacao = soma.toFixed(3);
				
			}
			else if(DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.MINIGAME)
			{
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].desc == "GaleriaProjetos")
				{
					soma = Galeria.calculaPontos();
					DadosFromXML[Atual.etapa].telas[Atual.tela].pontuacao = soma;
				}
				if (DadosFromXML[Atual.etapa].telas[Atual.tela].desc == "PreparaApresentacao")
				{
					MonsterDebugger.trace(this, MiniGamePrep.calculaPontos());
					soma = MiniGamePrep.calculaPontos();
					if (GameBontempo.DefinesLoader.DEBUG_MOD == "true")
						MiniGamePrep.EtapaPT.text = soma.toFixed(2);
				
					DadosFromXML[Atual.etapa].telas[Atual.tela].pontuacao = soma;
				}
				
			}
			else if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
			{
				
				
				for each(var bt:OptBotaoPergClass in perguntaBTArray)
				{
					if (bt.dados.valor == 10) {
						countEssenc++;
					} 
					
					if (bt.dados.sel){
						//soma += bt.dados.valor;
						countSel++;
						if (bt.dados.valor == 10)
							countVal++;
					}
					
					
					
				}
				if ((countSel >= (perguntaBTArray.length * 0.6) ) && (countVal >= (countEssenc * 0.6)) ) //60% de todas e destas 60% essenciais
					soma = 10;
				
				if (GameBontempo.DefinesLoader.DEBUG_MOD=="true")
					PerguntasMC.PerguntasHeadMC.TFpontos.text = "Tot: " + String(countEssenc) + " Sel: " + String(countSel) + " Essenc: " + String(countVal);
				
			}
			if (soma < 0) soma = 0;
			
			var peso:Number = DadosFromXML[Atual.etapa].peso;
			soma = (soma / 10);// * peso;
			
			DadosFromXML[Atual.etapa].telas[Atual.tela].pontuacao = count>0 ? Number(soma/count):soma;
			
			//DadosFromXML[Atual.etapa].telas[Atual.tela].pontuacao = soma;
			return atualizaPontos();
			
		}
		
		var totGame:Number = 0;
		var totEtAtual:Number = 0;
		var totTelAtual:Number = 0;
			
		public function atualizaPontos(): String
		{
			
			totGame = 0;
			for each (var itEt:StructEtapa in DadosFromXML) 
			{
				var totTel:Number = 0;
				for each (var itTe:StructTela in itEt.telas) 
				{
					totTel += itTe.pontuacao;
				}
				itEt.totPoints = totTel / itEt.qtPerguntas * itEt.peso ;
				totGame += itEt.totPoints;
			}
			
			totGame+=Atual.somaPontosFerramentas();
			
			totTelAtual = StructTela(DadosFromXML[Atual.etapa].telas[Atual.tela]).pontuacao;  
			totEtAtual = StructEtapa(DadosFromXML[Atual.etapa]).totPoints;
			
			Atual.totalPointGame = totGame;
			var result:String = "Geral: " + totGame.toFixed(2) + "/" + myLoader.somaPesos + " Et: " + totEtAtual.toFixed(2) + " Tela: " + totTelAtual.toFixed(2) + " P: " + DadosFromXML[Atual.etapa].peso.toFixed(2);
			if (GameBontempo.DefinesLoader.DEBUG_MOD=="true")
				EtapaPT.text = result;
			
			return result;
		}
		
		
		
		
		public function limpaPontos():void
		{
			if (GameBontempo.DefinesLoader.DEBUG_MOD=="true") 
				EtapaPT.text = "Geral: " + totGame.toFixed(2) + "/" + myLoader.somaPesos + " Et: " + 0 + " Tela: " + 0 + " P: " + DadosFromXML[Atual.etapa].peso.toFixed(2);
		}
		
//>>>>>>>>>>>>> ABA PERGUNTAS >>>>>>>>>>>>>>>>
		private function InitAbaPerguntas():void
		{
			
			//PergPaneSP.source = PerguntasMC;
			//PergPaneSP.width = PerguntasMC.width + 20;
			//PergPaneSP.verticalScrollPosition = 0;
			//PergPaneSP.refreshPane();
			//PergPaneSP.update();
			if (GameBontempo.DefinesLoader.DEBUG_MOD=="false")
				PerguntasMC.PerguntasHeadMC.TFpontos.visible = false;	
			PerguntasMC.PerguntasHeadMC.BTfecharPerguntas.addEventListener(MouseEvent.CLICK, HidePerguntasMC);
			//FerramentasMC.addEventListener(MouseEvent.CLICK, HideRespCliMC);
			
			
			disablePerguntas();
			MonsterDebugger.trace(this, "disablePerguntas InitAbaPerguntas");
		
		}
		
		private function disablePerguntas():void
		{
			BTPerguntasMC.removeEventListener(MouseEvent.CLICK, ShowPerguntasMC);
			BTPerguntasMC.visible = false;
		}
		
		private function enablePerguntas():void
		{
			BTPerguntasMC.addEventListener(MouseEvent.CLICK, ShowPerguntasMC);
			BTPerguntasMC.visible = true;
		}
		
		private function HidePerguntasMC(evt:MouseEvent = null):void
		{
			FerramentasMC.enable();
			//TweenLite.to(PergPaneSP, 2, {x: -PergPaneSP.width-10, ease: Back.easeOut});
			TweenLite.to(PerguntasMC, 2, {x: -PergPaneSP.width-10, ease: Back.easeOut});
			//TweenLite.to(PerguntasHeadMC, 2, {x: -PerguntasHeadMC.width-10, ease: Back.easeOut});
			
			enableTimer();
			//timerCliPerg.start();
		}
		
		private function ShowPerguntasMC(evt:MouseEvent):void
		{
			FerramentasMC.disable();
			HideRespCliMC();
			HideRespPVMC();
			//TweenLite.to(PergPaneSP, 2, {x: 0, ease: Back.easeOut});
			//TweenLite.to(PerguntasHeadMC, 2, {x: 0, ease: Back.easeOut});
			TweenLite.to(PerguntasMC, 2, {x: 0, ease: Back.easeOut});
			
			disableTimer();
			//timerCliPerg.stop();
		}
		
		private function ShowRespCliMC()
		{
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
					disableAll(true);
			HideRespPVMC();
			if (!RespPergCliMC.isVisible)
			{
				TweenLite.to(RespPergCliMC, (Atual.isReplayGame ?0.1:1), {x: 0, ease: Back.easeOut});
				RespPergCliMC.isVisible = true;
			}
		}
		
		private function HideRespCliMC(evt:MouseEvent = null):void
		{
			if (RespPergCliMC.isVisible)
			{
				TweenLite.to(RespPergCliMC, (Atual.isReplayGame ?0.1:1), {x: VideoContainer.width, ease: Back.easeOut});
				RespPergCliMC.isVisible = false;
			}
		}
		
		private function ShowRespPVMC()
		{
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
					disableAll(true);
			HideRespCliMC();
			if (!RespPergPVMC.isVisible)
			{
				TweenLite.to(RespPergPVMC, (Atual.isReplayGame ?0.1:1), {x: 0, ease: Back.easeOut});
				RespPergPVMC.isVisible = true;
			}
		}
		
		private function HideRespPVMC(evt:MouseEvent = null):void
		{
			if (RespPergPVMC.isVisible)
			{
				TweenLite.to(RespPergPVMC, (Atual.isReplayGame ?0.1:1), {x: -RespPergPVMC.width-20, ease: Back.easeOut});
				RespPergPVMC.isVisible = false;
			}
		}
		
		var proxPergCli:int = 0;
		private function showPerguntasCliente(evt:MyTimerEvents = null):Boolean
		{
			
			if (respostaBTArray == null)
				return false;
			
			timerCliPerg.stop();
			if (proxPergCli >= respostaBTArray.length) {
				timerCliPerg.removeEventListener(MyTimerEvents.ON_IDLE_REACHED, showPerguntasCliente);
				return false;
			}
			
			DlgState.ATUAL = DlgState.CLIASK;
			HideRespCliMC();
			HidePerguntasMC();
			PerguntasMC.PerguntasMC.visible = false;
			PerguntasMC.RespostasMC.visible = true;
			//PerguntasMC.visible = false;
			//RespostasMC.visible = true;
			//PergPaneSP.source = RespostasMC;
			//PergPaneSP.verticalScrollPosition = 0;
			//PergPaneSP.refreshPane();
			//PergPaneSP.update();
			
			if (respostaBTArray == null)
				return false;
			
			//var idx:int = Util.randRange(0, respostaBTArray.length - 1);
			
			RespPergCliMC.setDados(respostaBTArray[proxPergCli].getDados());
			populaRespostasParaCli(proxPergCli);
			setVideosOnDialog(RespPergCliMC.getDados());
			
			ShowRespCliMC();
			
			proxPergCli++;
			
			return true;
		}
		
		private function hidePerguntasCliente():Boolean
		{
			if (respostaBTArray == null)
				return false;
			
			HidePerguntasMC();
			PerguntasMC.RespostasMC.visible = false;
			PerguntasMC.PerguntasMC.visible = true;
			
			//RespostasMC.visible = false;
			//PerguntasMC.visible = true;
			//PergPaneSP.source = PerguntasMC;
			//PergPaneSP.verticalScrollPosition = 0;
			//PergPaneSP.refreshPane();
			//PergPaneSP.update();
			HideRespCliMC();
			
			return true;
		}
		
		var respostaBTArrayTemp:Array = new Array();
		private function populaRespostasParaCli(idx:int=-1):Boolean
		{
			
				
			if (idx < 0) //-1 carrega todos pro array
			{
				respostaBTArray = new Array();
				for each (var etapaDLG:StructEtapaDLG in DialogosFromXML)
				{
					if (DadosFromXML[Atual.etapa].desc == etapaDLG.desc)
					{
						for each (var perguntaDLG:StructPerguntaDLG in etapaDLG.perfis[Atual.perfil].perguntas) // perfil.perguntas)
						{
							if (perguntaDLG.agente == StructBase.AGENTE_C)
							{
								respostaBTArray.push(new OptBotaoRespClass(perguntaDLG,true));
							}
						}
					}
				}
			}
			else
			{
				var lastSz:Number = 25;
				var lastY:Number = 10;
				var btR:OptBotaoRespClass;
				var rand:int = Util.randRange(0, 1);
				removeBotoesRespostasMC();
				for (var i:int = 0; i < 2; i++)
				{
				
					btR = new OptBotaoRespClass(respostaBTArray[idx].dados,(rand==0));   // e respostas;bt de resperrada ou certa conforme i=0 certa =1 errada
					
					btR.x = 10;
					btR.y = lastY + lastSz + 5;
					
					btR.addEventListener(MouseEvent.CLICK, optBtclicked);
					PerguntasMC.RespostasMC.addChild(btR);
					respostaBTArrayTemp.push(btR);
					lastY = btR.y;
					lastSz = btR.height;
					rand = rand == 0?1:0;
					
				}
			}
			return true;
		
		}
		
		private function removeBotoesRespostasMC()
		{
			
			for each (var bt:OptBotaoRespClass in respostaBTArrayTemp)
			{
				PerguntasMC.RespostasMC.removeChild(bt);
			}
			respostaBTArrayTemp = new Array();
			
		}
		
		private function populaPerguntasPV():int
		{
			var item:String = new String();
			var i:int = 0;
			
			var lastSz:Number = 25;
			var lastY:Number = 10;
			
			var bt:OptBotaoPergClass;
			var btR:OptBotaoRespClass;
			
			removeBotoesPerguntasMC();
			maxTimeToPlayVdCli = 0;
			maxTimeToPlayVdPv = 0;
			
			for each (var etapaDLG:StructEtapaDLG in DialogosFromXML)
			{
				if (DadosFromXML[Atual.etapa].desc == etapaDLG.desc)
				{
					videoLoad(VideoContainer, lastVideoPlay);
					
					for each (var perguntaDLG:StructPerguntaDLG in etapaDLG.perfis[Atual.perfil].perguntas) // perfil.perguntas)
					{
						if (perguntaDLG.agente == StructBase.AGENTE_PV)
						{
							bt = new OptBotaoPergClass(perguntaDLG);
							bt.x = 10;
							
							bt.y = lastY + lastSz + 5;
							
							if (GameBontempo.DefinesLoader.DEBUG_MOD=="true")
								if (perguntaDLG.valor != 10)
									bt.alpha = 0.7;
							
							bt.addEventListener(MouseEvent.CLICK, optBtclicked);
							
							perguntaBTArray.push(bt);
							PerguntasMC.PerguntasMC.addChild(bt);
							
							lastY = bt.y;
							lastSz = bt.height;
							i++;
						}
					}
				}
			}
			return 0;
		}
		
		private function removeBotoesPerguntasMC()
		{
			for each (var bt:OptBotaoPergClass in perguntaBTArray)
			{
				PerguntasMC.removeChild(bt);
			}
			perguntaBTArray = new Array();
		}
		
		private function calcVideoPlayTime(txtLen:int = 0):Number
		{
			MonsterDebugger.trace(this, "calcVideoPlayTime " + txtLen + "  " + ((txtLen < 40 ? 4 : txtLen * 0.055)));
			
			if (txtLen == 0)
				return 0;
			
			return (txtLen < 40 ? 4 : txtLen * 0.085);
		}
		
		private function setVideosOnDialog(dados:StructPerguntaDLG):void
		{
			var cliVideo:String;
			var pvVideo:String;
			var pergTime:Number = 0;
			var respTime:Number = 0;
			
			//pergTime = dados.desc.length;
			//respTime = dados.resposta.length;
			
			lastAudioPlay = dados.som;
			
			//if (DadosFromXML[Atual.etapa].id == 8)
			//{
			cliVideo = dados.video2; // + Atual.perfilNome[Atual.perfil] + "01_" + sexoPV + ".flv";
			pvVideo = dados.video + sexoPV + ".flv";
			//}
			
			maxTimeToPlayVdCli = 0;
			maxTimeToPlayVdPv = 0;
			pergTime = calcVideoPlayTime(dados.desc.length);
			respTime = calcVideoPlayTime(dados.resposta.length);
			
			if (DlgState.ATUAL == DlgState.CLIWAIT) //PV selecionou resposta (optBtclicked) e roda video do PV com resposta
			{
				videoLoad(VideoContainer, pvVideo);
				maxTimeToPlayVdCli = pergTime;
				maxTimeToPlayVdPv = respTime;
			}
			else if (DlgState.ATUAL == DlgState.PVASK) //PV perguntou (optBtclicked), mostra video do pv perguntando, no videoOmpleted mostra video do CLi respondendo (lastVideoPlayAnswer)
			{
				lastVideoPlayAnswer = cliVideo;
				maxTimeToPlayVdCli = respTime;
				maxTimeToPlayVdPv = pergTime;
				videoLoad(VideoContainer, pvVideo);
			}
			else if (DlgState.ATUAL == DlgState.CLIASK) //disparado pelo timer, cliente faz pergunta, mostra video do cliente perguntando
			{
				maxTimeToPlayVdCli = pergTime;
				videoLoad(VideoContainer, cliVideo);
			}
		
		}
		
		private function optBtclicked(evt:MouseEvent)
		{
			
			HidePerguntasMC();
			DlgState.printState("optBtclicked1", DlgState.ATUAL);
			MonsterDebugger.trace(this, "Pontos " + evt.currentTarget.getDados().valor);
			
			//DlgState.ATUAL = DlgState.CLIASK
			if (DlgState.ATUAL == DlgState.CLIWAIT)
			{
				var btResp:OptBotaoRespClass = OptBotaoRespClass(evt.currentTarget);
				RespPergPVMC.setDados(evt.currentTarget.getDados(),btResp.correta);
				setVideosOnDialog(evt.currentTarget.getDados());
				//XML addPergDLG no opbBtClicled do AbaPerguntas
				mySaver.addPergDLG(RespPergCliMC.getDados(), btResp);
				//mySaver.saveXmlDialogo();
			}
			else if (DlgState.ATUAL == DlgState.IDLE)
			{
				timerCliPerg.stop();
				DlgState.ATUAL = DlgState.PVASK;
				
				RespPergPVMC.setDados(evt.currentTarget.getDados());
				RespPergCliMC.setDados(evt.currentTarget.getDados());
				//XML addPergDLG no opbBtClicled do AbaPerguntas
				mySaver.addPergDLG(RespPergCliMC.getDados());
				Atual.qtPergFeitasParaCLi++;
				
				var etPulo:int = StructPerguntaDLG(RespPergCliMC.getDados()).EtPulo;//pular telas na apresentaçao
				var TlPulo:int = StructPerguntaDLG(RespPergCliMC.getDados()).TlPulo;
				if (etPulo >= 0 && TlPulo >= 0)
					Atual.addPulaTela(etPulo, TlPulo);
				
				setVideosOnDialog(RespPergCliMC.getDados());
				
				//PerguntasMC.removeChild(OptBotaoPergClass(evt.currentTarget));
				OptBotaoPergClass(evt.currentTarget).visible = false;
				
			}
			
			
			ShowRespPVMC();
			evt.currentTarget.getDados().sel = true;
			
			DlgState.printState("optBtclicked2", DlgState.ATUAL);
			verificaPontos();
			
		}
		
//<<<<<<<<<<<<<<<<<< ABA PERGUNTAS <<<<<<<<<<<<<<<<<<<
		
//>>>>>>>>>>>>>>>>>> ABA FERRAMENTAS >>>>>>>>>>>>>>>>>>>>
		private function initAbaFerramentas():void
		{
			
			FerramentasMC.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverFerramentas);
			FerramentasMC.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutFerramentas);
			
			function onMouseOverFerramentas(evt:MouseEvent = null):void
			{
				BTPulaEtapaMC_wasVisible = BTPulaEtapaMC.visible;
				BTPulaEtapaMC.visible = false;
				BTPerguntasMC_wasVisible = BTPerguntasMC.visible;
				BTPerguntasMC.visible = false;
			}
			
			function onMouseOutFerramentas(evt:MouseEvent = null):void
			{
				if (BTPulaEtapaMC_wasVisible)
					BTPulaEtapaMC.visible = true;
				
				if (BTPerguntasMC_wasVisible)
					BTPerguntasMC.visible = true;
			}
		
		}
		
//<<<<<<<<<<<<<<<<<< ABA FERRAMENTAS <<<<<<<<<<<<<<<<<<<
		

	private function restartPlay(evt:Event = null):void
	{
		
		if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
		{
			if (PerguntasMC2_Replay != null)
				removeChild(PerguntasMC2_Replay);
		}
		
		HideRespPVMC();
		HideRespCliMC();
		removeMiniGame();
		Atual.setGameSavedPoint();
		Atual.isReplayGame = false;
		/*
		if (DadosFromXML[Atual.etapa].telas[Atual.tela].video == ""){//{ //pega o video da anterior caso esta nao tenha no inicio do replay
			Atual.prevTela();
			getLastVideoPlay(DadosFromXML[Atual.etapa].telas[Atual.tela].video);
			Atual.nextTela();
		}
		*/
		
		BlockMC.visible = false;
		nextToShow();
	}


//>>>>>>>>>>>>>>>>>> PULA ETAPA >>>>>>>>>>>>>>>>>>>>

		var confirmaMC:blockConfirmaClass;

		private function disablePula():void
		{
			BTPulaEtapaMC.removeEventListener(MouseEvent.CLICK, showConfirmaPula);
			BTPulaEtapaMC.visible = false;
		}
		
		private function enablePula():void
		{
			if (!DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO)
			  return;
			  
			if (Atual.isReplayGame)
				return;
			
			BTPulaEtapaMC.addEventListener(MouseEvent.CLICK, showConfirmaPula);
			BTPulaEtapaMC.visible = true;
		}
		
		public function pulaEtapa(evt:MouseEvent)
		{
			
			MonsterDebugger.trace(this, "PulaEtapa Estilo: "+DadosFromXML[Atual.etapa].telas[Atual.tela].estilo)
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.INTRODUCAO)
				btFecharVideo2.removeEventListener(MouseEvent.CLICK, pulaEtapa);
			else
				hideConfirmaPula(evt);
			
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO) {
				var util: Util = new Util();
				
				MonsterDebugger.trace(this, "**** 2292 - pulaEtapa");
				DadosFromXML[Atual.etapa].telas[Atual.tela].time = util.calculeTime(DadosFromXML[Atual.etapa].telas[Atual.tela].date);
				Atual.totalTimeGame += DadosFromXML[Atual.etapa].telas[Atual.tela].time;
				disablePula();
			}
			
				
			MonsterDebugger.trace(this, "Vai para nextTla nextShow");
			Atual.nextTela(); // nextEtapa();
			DlgState.ATUAL = DlgState.IDLE;
			HideRespPVMC();
			HideRespCliMC();
			HideAbaPulaEtapas();
			nextToShow();
		}
		
		
		public function showConfirmaPula(evt:MouseEvent):void
		{
			disableAll(false, "showConfirmaPula");
			confirmaMC = new blockConfirmaClass();
			confirmaMC.btConfirma.addEventListener(MouseEvent.CLICK, pulaEtapa);
			confirmaMC.btCancela.addEventListener(MouseEvent.CLICK, hideConfirmaPula);
			confirmaMC.label.text = "Você tem certeza que deseja sair do Briefing e ir para próxima etapa?"
			addChild(confirmaMC);
			
		}
		
		public function hideConfirmaPula(evt:MouseEvent):void
		{
			if (confirmaMC == null)
				return;
			enableAll("showConfirmaPula");
			confirmaMC.btConfirma.removeEventListener(MouseEvent.CLICK, pulaEtapa);
			confirmaMC.btCancela.removeEventListener(MouseEvent.CLICK, hideConfirmaPula);
			removeChild(confirmaMC);
			
		}
		
//<<<<<<<<<<<<<<<<<< PULA ETAPA <<<<<<<<<<<<<<<<<<<
		
//>>>>>>>>>>>>>>>>>> ABA PULA ETAPAS >>>>>>>>>>>>>>>>>>>>
		private function initAbaPulaEtapas():void
		{
			addBTListaEtapas();
			ListaEtapasMC.BTfecharEtapas.addEventListener(MouseEvent.CLICK, HideAbaPulaEtapas);
		}
		
		private function ListaEtapasMCBTClicked(evt:MouseEvent):void
		{
			
			removeMiniGame();
			
			Atual.setEtapa(evt.currentTarget.parent.dados.id);
			DlgState.ATUAL = DlgState.IDLE;
			HideRespPVMC();
			HideRespCliMC();
			HideAbaPulaEtapas();
			nextToShow();
		}
		
		private function addBTListaEtapas():void
		{
			var bt:OptBotaoEtapasClass;
			var lastSz:Number = 25;
			var lastY:Number = 10;
			var ord:int = 0;
			
			for each (var etapa:StructEtapa in DadosFromXML)
			{
				bt = new OptBotaoEtapasClass(etapa, ord);
				bt.x = 10;
				bt.y = lastY + lastSz + 5;
				
				bt.texto.addEventListener(MouseEvent.CLICK, ListaEtapasMCBTClicked);
				
				ListaEtapasMC.addChild(bt);
				
				lastY = bt.y;
				lastSz = bt.height;
				ord++;
			}
		}
		
		private function reorderAbaPulaEtapas():void 
		{
			for (var i:int = 0; i < ListaEtapasMC.numChildren; i++){
				if (ListaEtapasMC.getChildAt(i) is OptBotaoEtapasClass)
					ListaEtapasMC.removeChildAt(i);
			}
				
			addBTListaEtapas();
		}
		
		public function ShowAbaPulaEtapas(evt:MouseEvent):void
		{
			FerramentasMC.disable();
			MenuEscolhasMC.visible = false;
			TweenLite.to(ListaEtapasMC, 2, {x: (VideoContainer.width - ListaEtapasMC.width - 10), ease: Back.easeOut});
			//VideoContainer.skin = null;
		}
		
		private function HideAbaPulaEtapas(evt:MouseEvent = null):void
		{
			FerramentasMC.enable();
			MenuEscolhasMC.visible = true;
			TweenLite.to(ListaEtapasMC, 2, {x: VideoContainer.width + ListaEtapasMC.width, ease: Back.easeOut});
			//VideoContainer.skin = SkinTemplate;
		}
		
//<<<<<<<<<<<<<<<<<< ABA PULA ETAPAS <<<<<<<<<<<<<<<<<<<
		
//>>>>>>>>>>>>>>>>>> BLOCO DE NOTAS >>>>>>>>>>>>>>>>>>>>
		private function initBlocoNotas():void
		{
			
			FerramentasMC.btFerrContainner.MCNotas.addEventListener(MouseEvent.CLICK, ShowBlocoNotas);
			BlocoNotasMC.BTfecharBloco.addEventListener(MouseEvent.CLICK, HideBlocoNotas);
			BlocoNotasMC.loadBts(DadosFromXML);
		}
		
		private function HideBlocoNotas(evt:MouseEvent):void
		{
			enableAll("HideBlocoNotas");
			TweenLite.to(BlocoNotasMC, 2, {x: VideoContainer.width + BlocoNotasMC.width, ease: Back.easeOut});
			isShowBlocoNotas = false;
			//VideoContainer.skin = SkinTemplate;
		
		}
		
		private function ShowBlocoNotas(evt:MouseEvent):void
		{
			BlocoNotasMC.setAtiva(DadosFromXML[Atual.etapa].id);
			mySaver.addCallTool("BlocoNotas");
			disableAll(false, "ShowBlocoNotas");
			isShowBlocoNotas = true;
			TweenLite.to(BlocoNotasMC, 2, {x: (VideoContainer.width / 2), ease: Back.easeOut});
			VideoContainer.skin = null;
		}
		
//<<<<<<<<<<<<<<<<<< BLOCO DE NOTAS <<<<<<<<<<<<<<<<<<<
 		
//>>>>>>>>>>>>>>>>>> PASTA DO CLIENTE >>>>>>>>>>>>>>>>>>>>
		private function initPastaCli():void
		{
			
			PastaCliMC.setPerfil(Atual.perfil);
			
			if (Atual.isReplayGame)
			{
				PastaCliMC.setClicadosOnLoad(myLoader.pastaCliClicados);
			}
			
			FerramentasMC.btFerrContainner.MCPasta.addEventListener(MouseEvent.CLICK, ShowPastaCliente);
			PastaCliMC.BTfecharPastaCliente.addEventListener(MouseEvent.CLICK, HidePastaCliente);
		}
		
		private function HidePastaCliente(evt:MouseEvent):void
		{
			TweenLite.to(PastaCliMC, 2, {y: -PastaCliMC.height / 2, ease: Back.easeOut});
			//VideoContainer.skin = SkinTemplate;
			enableAll("HidePastaCliente");
			
			if (PastaClienteClass(PastaCliMC).verficaEssencias1())
			{
				if (DadosFromXML[Atual.etapa].desc=="Abordando o cliente")
					Atual.PontosFerramPastaCli[0] = 0.50;
				MonsterDebugger.trace(this, "Pasta cliente essenciais 1 ok"); 
				
				if (PastaClienteClass(PastaCliMC).verficaEssencias2() && Atual.etapa <=9) //desenvolve o projeto 
				{
					Atual.PontosFerramPastaCli[1] = 0.50;
					MonsterDebugger.trace(this, "Pasta cliente essenciais 2 ok"); 
				}
			}
		}
		
		private function ShowPastaCliente(evt:MouseEvent):void
		{
			disableAll(false, "ShowPastaCliente");
			mySaver.addCallTool("PastaCliente");
			TweenLite.to(PastaCliMC, 2, {y: VideoContainer.height / 2, ease: Back.easeOut});
			VideoContainer.skin = null;
		}
		
//<<<<<<<<<<<<<<<<<< PASTA DO CLIENTE <<<<<<<<<<<<<<<<<<<




//>>>>>>>>>>>>>>>>>> BRIEFING TECNICO >>>>>>>>>>>>>>>>>>>>
		private function initBriefingTecnico():void
		{
			
			BriefingTecnicoMC = new BriefingTecnicoClass(Atual.perfil);
			addChild(BriefingTecnicoMC);
			BriefingTecnicoMC.y = -BriefingTecnicoMC.height;
			FerramentasMC.btFerrContainner.MCBT.addEventListener(MouseEvent.CLICK, ShowBriefingTecnico);
			BriefingTecnicoMC.BTfechar.addEventListener(MouseEvent.CLICK, HideBriefingTecnico);
		}
		
		private function HideBriefingTecnico(evt:MouseEvent):void
		{
			TweenLite.to(BriefingTecnicoMC, 2, { y: -BriefingTecnicoMC.height, ease: Back.easeOut } );
			enableAll("HideBriefingTecnico");
		}
		
		private function ShowBriefingTecnico(evt:MouseEvent):void
		{
			//mySaver.addCallTool("BriefingTecnico");
			disableAll(false);
			TweenLite.to(BriefingTecnicoMC, 2, { y: 0, ease: Back.easeOut } );
			
			
			if ( (DadosFromXML[Atual.etapa].desc == "Realizando o briefing"))
			{
				Atual.PontosFerramBT[0] = 0.5;
			}
			
			if (DadosFromXML[Atual.etapa].desc == "Desenvolvendo o projeto")
			{
				Atual.PontosFerramBT[1] = 0.5;
			}
			
			
		}
		
//<<<<<<<<<<<<<<<<<< BRIEFING TECNICO <<<<<<<<<<<<<<<<<<<
		
//>>>>>>>>>>>>>>>>>> CHAMA AJUDA LIDER >>>>>>>>>>>>>>>>>>>>
		private function initShowLider():void
		{
			MonsterDebugger.trace(this, "initShowLider "+"Atual.tela="+Atual.tela+" Atual.etapa="+Atual.etapa+ " Texto ajuda="+DadosFromXML[Atual.etapa].telas[Atual.tela].ajuda);
			AjudaLiderBalaoMC = new AjudaLiderContainerClass(DadosFromXML[Atual.etapa].telas[Atual.tela].ajuda);
			addChild(AjudaLiderBalaoMC);
			MonsterDebugger.trace(this, "AjudaLiderBalaoMC adicionado" + AjudaLiderBalaoMC.toString());
			FerramentasMC.btFerrContainner.MCFala.addEventListener(MouseEvent.CLICK, ShowLider);
		}
		
		private function ShowLider(evt:MouseEvent=null):void
		{
			var ajudaTxt:String = DadosFromXML[Atual.etapa].telas[Atual.tela].ajuda;
			MonsterDebugger.trace(this, "ShowLider "+"Etapa "+DadosFromXML[Atual.etapa].desc+" Atual.tela="+Atual.tela+" Atual.etapa="+Atual.etapa+ " Texto ajuda="+ajudaTxt);
			Video2TituloTF.text = "Auxílio do Gerente de Vendas";
			mySaver.addCallTool("ChamaGerente");
			ShowVideo2("Videos/AjudaLiderVendas/LiderDeVendasAjuda.flv", DadosFromXML[Atual.etapa].telas[Atual.tela].ajudaSom);
			if (ajudaTxt != "")
				AjudaLiderBalaoMC.setTexto(playerName.split(" ")[0]+", \n\n"+ajudaTxt);
			else 
			{
				if (DadosFromXML[Atual.etapa].desc == "Apresentando o projeto")
				{
					AjudaLiderBalaoMC.setTexto( playerName.split(" ")[0]+", \n\n"+"Primeira ferramenta que deve estar em sua mão para iniciar a analise do processo e do cliente é o BRIEFING; \nRelembre as vantagens competitivas que temos sobre os concorrentes em disputa; \nEsteja disponível para realizar pequenas alterações  do  projeto no momento da apresentação.");
				}
				else if (DadosFromXML[Atual.etapa].desc == "Apresentando o orçamento")
				{
					AjudaLiderBalaoMC.setTexto(playerName.split(" ")[0]+", \n\n"+"Lembre-se de todos os pontos destacados pelo cliente na primeira visita e na apresentação da loja e quais foram os positivos e negativos. \nCertifique-se que possui informações do valor aproximado do quanto o cliente deseja investir e como pretende pagar. Lembre-se que o arquiteto pode nos dar estas informações, se ele estiver do nosso lado. \nNunca ofereça descontos sem pedir o fechamento em troca. \nDescontos devem ser concedidos aos poucos e nunca tudo de uma única vez. \nNão chame o gerente somente para dar desconto, chame-o para encontrar uma solução para o cliente. \nLembre-se de coisas, objetos ou partes de projetos que foram incluídas, pois estes detalhes poderão ser definitivos no momento do fechamento e negociação. \nNo momento de decisão final de fechamento, se houver indecisão, é importante simular ligação com franqueado, diretor ou alguém da fabrica, para valorizá-lo, indicar o nosso interesse em fechar com ele e que ele seja nosso cliente.");
				}
				else if (DadosFromXML[Atual.etapa].desc == "Apresentando o Ambiente")
				{
					AjudaLiderBalaoMC.setTexto("Olá " + playerName.split(" ")[0] + "! \n\n Seja bem vindo ao Jogo Simulador de Vendas da Bontempo. \n\n Para melhor compreender o funcionamento do game, e aproveitar todos os seus recursos, está disponível a funcionalidade de ajuda, acessível a partir da '?' no canto superior direito da tela, junto com as Ferramentas.\n  A duração de cada jogada depende do ritmo de cada um. O jogo é salvo automaticamente ao final de cada etapa, podendo ser retomado posteriormente, do ponto onde se parou (e com a possibilidade de visualizar o percurso feito até então).\n\n  Ao final do jogo é apresentada uma avaliação do seu desempenho. Ela é organizada de forma a ajudá-lo a identificar os pontos que podem ser melhorados.\n   O acesso ao game é ilimitado, você pode jogar quantas vezes achar necessário para sua evolução, explorando novas situações. \n\nBom proveito! ");
					MonsterDebugger.trace(this, AjudaLiderBalaoMC.getTexto());
					SoundContainer.lowVol();
					SoundContainer.play(DadosFromXML[0].telas[0].som);
					SoundContainer.lowVol();
				}
			}
				
			AjudaLiderBalaoMC.animIn();
			
			if (DadosFromXML[Atual.etapa].desc == "Desenvolvendo o projeto")
			{
				Atual.PontosFerramChamaGerente[0] = 0.25;
			}
			
			if ( (DadosFromXML[Atual.etapa].desc == "Preparando-se para apresentação"))
			{
				Atual.PontosFerramChamaGerente[1] = 0.5;
			}
			
			if (DadosFromXML[Atual.etapa].desc == "Apresentando o orçamento")
			{
				Atual.PontosFerramChamaGerente[2] = 0.25;
			}
			
			
			
		}
		
//<<<<<<<<<<<<<<<<<< CHAMA AJUDA LIDER <<<<<<<<<<<<<<<<<<<

//>>>>>>>>>>>>>>>>>> CHAMA BRIEFING ESTILO >>>>>>>>>>>>>>>>>>>>
		
		private function initShowBriefingEstilo():void
		{
			BriefingEstiloMC = new BriefingEstilosClass(Atual.perfil);
			addChild(BriefingEstiloMC);
			BriefingEstiloMC.y = -(BriefingEstiloMC.height+100);
			BriefingEstiloMC.BTfechar.addEventListener(MouseEvent.CLICK, HideBriefingEstilo);
			 
			FerramentasMC.btFerrContainner.MCBE.addEventListener(MouseEvent.CLICK, ShowBriefingEstilo);
		}
		
		
		
		private function ShowBriefingEstilo(evt:MouseEvent):void
		{
			//mySaver.addCallTool("ShowBriefingEstilo");
			
			TweenLite.to(BriefingEstiloMC, 2, { y: 0, ease: Back.easeOut } );
			disableAll(false);
			
		}
		
		
		private function HideBriefingEstilo(evt:MouseEvent):void
		{
			TweenLite.to(BriefingEstiloMC, 2, { y: -BriefingEstiloMC.height, ease: Back.easeOut } );
			enableAll("HideBriefingEstilo");
		}
		

		
		
//<<<<<<<<<<<<<<<<<< CHAMA BRIEFING ESTILO <<<<<<<<<<<<<<<<<<<
		
//>>>>>>>>>>>>>>>>>> CHAMA HISTORIA >>>>>>>>>>>>>>>>>>>>
		
		private function initShowHistoria():void
		{
			historiaMC = new ApresentacaoMarcaClass();
			addChild(historiaMC);
			historiaMC.y = -(historiaMC.height+100);
			historiaMC.BTfechar.addEventListener(MouseEvent.CLICK, HideHistoria);
			 
			FerramentasMC.btFerrContainner.MChistoria.addEventListener(MouseEvent.CLICK, ShowHistoria);
		}
		
		
		
		private function ShowHistoria(evt:MouseEvent):void
		{
			mySaver.addCallTool("ShowHistoria");
			//Video2TituloTF.text = "História da Marca Bontempo";
			//ShowVideo2("Videos/videoProducao.flv");
			
			TweenLite.to(historiaMC, 2, { y: 0, ease: Back.easeOut } );
			disableAll(false);
			
			if (DadosFromXML[Atual.etapa].desc == "Atendendo o cliente")
			{
				Atual.PontosFerramMarca[0] = 0.50;
			}
			
			if ( (DadosFromXML[Atual.etapa].desc == "Realizando o briefing"))
			{
				Atual.PontosFerramMarca[1] = 0.5;
			}
			
		}
		
		
		private function HideHistoria(evt:MouseEvent):void
		{
			TweenLite.to(historiaMC, 2, { y: -historiaMC.height, ease: Back.easeOut } );
			enableAll("HideHistoria");
		}
		

		
		
//<<<<<<<<<<<<<<<<<< CHAMA HISTORIA <<<<<<<<<<<<<<<<<<<
		
//>>>>>>>>>>>>>>>>>> CHAMA CONVENIENCIA >>>>>>>>>>>>>>>>>>>>
		private function initShowConveniencia():void
		{
			FerramentasMC.btFerrContainner.MCCafe.addEventListener(MouseEvent.CLICK, ShowConveniencia);
		}
		
		private function ShowConveniencia(evt:MouseEvent):void
		{
			mySaver.addCallTool("Conveniencia");
			Video2TituloTF.text = "Servindo Conveniências";
			ShowVideo2("Videos/Conveniencias/ConvenienciaCafe.flv");
			
			if (DadosFromXML[Atual.etapa].desc == "Abordando o cliente")
			{
				Atual.PontosFerramConv[0] = 0.50;
			}
			
			if ( (DadosFromXML[Atual.etapa].desc == "Apresentando o orçamento"))
			{
				Atual.PontosFerramConv[1] = 0.5;
			}
			
			
		}
		
//<<<<<<<<<<<<<<<<<< CHAMA CONVENIENCIA <<<<<<<<<<<<<<<<<<<

//>>>>>>>>>>>>>>>>>> TUTORIAL >>>>>>>>>>>>>>>>>>>>
		private function initTutotial():void
		{
			TutorialMC = new TutorialClass();
			addChild(TutorialMC);
			TutorialMC.y = -TutorialMC.height;
			FerramentasMC.btFerrContainner.MCHelp.addEventListener(MouseEvent.CLICK, ShowTutorial);
			TutorialMC.BTfechar.addEventListener(MouseEvent.CLICK, HideTutorial);
		}
		
		private function HideTutorial(evt:MouseEvent):void
		{
			TweenLite.to(TutorialMC, 2, { y: -TutorialMC.height, ease: Back.easeOut } );
			enableAll("HideTutorial");
		}
		
		private function ShowTutorial(evt:MouseEvent):void
		{
			if (DadosFromXML[Atual.etapa].desc == "Apresentando o projeto" || DadosFromXML[Atual.etapa].desc == "Apresentando o orçamento")
				TutorialMC.gotoTo("Apresentacao");
			else if (DadosFromXML[Atual.etapa].desc == "Preparando-se para apresentação" )
				TutorialMC.gotoTo("Prepara");
			else if (DadosFromXML[Atual.etapa].desc == "Desenvolvendo o projeto" )
				TutorialMC.gotoTo("Desenvolve");
			else if (DadosFromXML[Atual.etapa].desc == "Realizando o briefing" )
				TutorialMC.gotoTo("Briefing");
			else 
				TutorialMC.gotoTo("Quiz");
				
			disableAll(false);
			TweenLite.to(TutorialMC, 0.5, { y: 0, ease:Expo.easeOut } );
		}
		
//<<<<<<<<<<<<<<<<<< TUTORIAL <<<<<<<<<<<<<<<<<<<
		
		private function enableAll(from:String = null):void
		{
			if (isEnableAll)
				return;
			isEnableAll = true;
			isDisableAll = false;
			
			enableTimer();
			if (from != null)
				MonsterDebugger.trace(this, "EnableAll " + from)
			
			MenuEscolhasMC.visible = MenuEscolhasMC_wasVisible;
			FerramentasMC.visible = FerramentasMC_wasVisible;
			if (DadosFromXML[Atual.etapa].telas[Atual.tela].estilo == Estilo.DIALOGO && !Atual.isReplayGame)
			{
				BTPerguntasMC_wasVisible = true;
				BTPulaEtapaMC_wasVisible = true;
			}
			else{
				BTPerguntasMC_wasVisible = false;
				BTPulaEtapaMC_wasVisible = false;
			}
			
			BTPerguntasMC.visible = BTPerguntasMC_wasVisible;
			BTPulaEtapaMC.visible = BTPulaEtapaMC_wasVisible;
			
			RespPergCliMC.visible = RespPergCliMC_wasVisible;
			RespPergPVMC.visible = RespPergCliMC_wasVisible;
			
			//BlocoNotasMC.visible =    BlocoNotasMC_wasVisible;   
			//PerguntasHeadMC.visible = PerguntasHeadMC_wasVisible;
			//PergPaneSP.visible = PergPaneSP_wasVisible;
			ListaEtapasMC.visible = ListaEtapasMC_wasVisible;
			//PastaCliMC.visible =      PastaCliMC_wasVisible;
			
			
			if (Galeria != null)
				Galeria.btOk_MC.visible = true;
			if (MiniGamePrep != null)
				MiniGamePrep.btOk_MC.visible = true;
			
			//PerguntasMC.visible = PerguntasMC_wasVisible;
			//RespostasMC.visible = RespostasMC_wasVisible;
			
			
			if (DEBUGMOD)
				BTPulaEtapaMC.visible = true;
			else
				BTPulaEtapaMC.visible = BTPulaEtapaMC_wasVisible;
		
		}
		
		private function disableAll(inInitVd:Boolean, from:String = null):void
		{
			if (isDisableAll)
				return;
			isDisableAll = true;
			isEnableAll = false;
			
			disableTimer();
			if (from != null)
				MonsterDebugger.trace(this, "disableAll " + from)
			
			MenuEscolhasMC_wasVisible = MenuEscolhasMC.visible;
			FerramentasMC_wasVisible = FerramentasMC.visible;
			RespPergPVMC_wasVisible = RespPergPVMC.visible;
			RespPergCliMC_wasVisible = RespPergCliMC.visible;
			//BlocoNotasMC_wasVisible=    BlocoNotasMC.visible;
			//PerguntasHeadMC_wasVisible = PerguntasHeadMC.visible;
			//PergPaneSP_wasVisible = PergPaneSP.visible;
			ListaEtapasMC_wasVisible = ListaEtapasMC.visible;
			//PastaCliMC_wasVisible=      PastaCliMC.visible;
			
			
			BTPerguntasMC_wasVisible = BTPerguntasMC.visible;
			BTPulaEtapaMC_wasVisible = BTPulaEtapaMC.visible;
			
			PerguntasMC_wasVisible = PerguntasMC.visible;
			//RespostasMC_wasVisible = RespostasMC.visible;
			
			MenuEscolhasMC.visible = false;
			FerramentasMC.visible = false;
			if (!inInitVd) //não oculta se em play video
			{
				RespPergCliMC.visible = false;
				RespPergPVMC.visible = false;
			}
			//BlocoNotasMC.visible = false;
			//PerguntasHeadMC.visible = false;
			//PergPaneSP.visible = false;
			ListaEtapasMC.visible = false;
			//PastaCliMC.visible = false;
			BTPerguntasMC.visible = false;
			BTPulaEtapaMC.visible = false;
			if (Galeria != null)
				Galeria.btOk_MC.visible = false;
			if (MiniGamePrep != null)
				MiniGamePrep.btOk_MC.visible = false;
		
			//PerguntasMC.visible = false;
			//RespostasMC.visible = false;
		}
		
		private function enableTimer():void
		{
			if (timerCliPerg_wasRunning) {
				timerCliPerg.reset();
				timerCliPerg.start();
			}
		}
		
		private function disableTimer():void
		{
			if (timerCliPerg == null)
				return;
			timerCliPerg_wasRunning = timerCliPerg.running();
			if (timerCliPerg.running())
				timerCliPerg.stop();
		}
		
		
		private function initErrorScreen():void
		{
			erroTela = new erroConexaoClass();
			addChild(erroTela);
			erroTela.name = "erroTela";
			erroTela.visible = false;
			erroTela.BTContinua.addEventListener(MouseEvent.CLICK, reiniciaEtapa);
		}
		
		private function reiniciaEtapa(evt:MouseEvent):void
		{
			removeMiniGame();
			Atual.prevTela();
			//Atual.setEtapa(DadosFromXML[Atual.etapa].id);
			DlgState.ATUAL = DlgState.IDLE;
			HideRespPVMC();
			HideRespCliMC();
			HideAbaPulaEtapas();
			nextToShow();
			
			//http://stackoverflow.com/questions/13559529/actionscript-3-checking-for-an-internet-connection
			
		}
		
		
	
	}
	
	
	
}