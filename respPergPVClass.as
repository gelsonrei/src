package  {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import GameBontempo.StructBase;
	import GameBontempo.StructPerguntaDLG;
	
	
	
	public class respPergPVClass extends MovieClip {
		private var xInit:Number;
		private var yInit:Number;
		public var dados:StructPerguntaDLG;
		public var isVisible:Boolean = false;
	
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		   			
			texto.autoSize = TextFieldAutoSize.LEFT; 
			texto.wordWrap = true;
			containerMC.height = texto.height+20;
			
		}
		
		public function setTexto(t:String)
		{
			texto.text = t;
			containerMC.height = texto.height + 20;
		}
		
		public function getDados():StructPerguntaDLG
		{
			return dados;
		}
		
		public function setDados(dt: StructPerguntaDLG, correta:Boolean=false)
		{
			dados = dt;
			if (dados.agente == StructBase.AGENTE_PV)
				setTexto(dados.desc);
				
			if (dados.agente == StructBase.AGENTE_C)
				setTexto(correta?dados.resposta:dados.respErr);
				
		}
		
	
		public function respPergPVClass() {
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		

	}
	
}
