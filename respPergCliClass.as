package  {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import GameBontempo.StructBase;
	import GameBontempo.StructPerguntaDLG;
	
	
	
	public class respPergCliClass extends MovieClip {
		
		public var dados:StructPerguntaDLG;
		public var isVisible:Boolean = false;
	
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		   	
			SMBT.addEventListener(MouseEvent.CLICK, SMBTclicked);
			BEBT.addEventListener(MouseEvent.CLICK, BEBTclicked);
			BTBT.addEventListener(MouseEvent.CLICK, BTBTclicked);
			
			texto.autoSize = TextFieldAutoSize.LEFT; 
			texto.wordWrap = true;
			containerMC.height = texto.height+20;
			
		}
		
		
		
		private function SMBTclicked(evt:MouseEvent)
		{
			dados.haveSisModMark = !dados.haveSisModMark;
			trace("SMBTclicked CLICK " + evt.currentTarget + " " + dados.haveSisModMark);
		}
		private function BEBTclicked(evt:MouseEvent)
		{
			dados.haveBEMark = !dados.haveBEMark;
			trace("BEBTclicked CLICK " + evt.currentTarget + " " + dados.haveBEMark);
		}
		private function BTBTclicked(evt:MouseEvent)
		{
			dados.haveBTMark = !dados.haveBTMark;
			trace("BTBTclicked CLICK " + evt.currentTarget + " " + dados.haveBTMark);
		}
		
		public function setTexto(t:String)
		{
			texto.text = t;
			containerMC.height = texto.height+20;
			SMBT.gotoAndStop(1);
			BEBT.gotoAndStop(1);
			BTBT.gotoAndStop(1);
			if (dados != null)
			{
				dados.sel = true;
				trace("Selecionou " + dados.sel +" " + dados.desc + " | " + dados.resposta);
			}
		}
		
		public function getDados():StructPerguntaDLG
		{
			return dados;
		}
		
		public function setDados(dt: StructPerguntaDLG)
		{
			dados = dt;
			if (dados.agente == StructBase.AGENTE_PV)
				setTexto(dados.resposta);
				
			if (dados.agente == StructBase.AGENTE_C)
				setTexto(dados.desc);
				
		}
		
		
	
		public function respPergCliClass() {
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		

	}
	
}
