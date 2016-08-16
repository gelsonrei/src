package  {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import GameBontempo.StructRespostas;
	import GameBontempo.MiniBTEvents;
	
	
	
	public class OptBotaoClass extends MovieClip {
		private var xInit:Number;
		private var yInit:Number;
		private var isOrdem:Boolean = false;
		public var dados:StructRespostas;
		
		var onMiniBtClicked:MiniBTEvents= new MiniBTEvents("onClick");
	
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		   	this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			texto.addEventListener(MouseEvent.CLICK, clicked);
			
			SMBT.addEventListener(MouseEvent.CLICK, SMBTclicked);
			BEBT.addEventListener(MouseEvent.CLICK, BEBTclicked);
			BTBT.addEventListener(MouseEvent.CLICK, BTBTclicked);
			
			this.buttonMode = true;
			
			xInit = this.scaleX;
			yInit = this.scaleY;
			
			texto.autoSize = TextFieldAutoSize.LEFT; 
			texto.wordWrap = true;
			BTcontainerMC.height = texto.height;
			
			
			
		}
		
		private function over(evt:MouseEvent)
		{
			
			TweenMax.to(evt.currentTarget, 1, {scaleX: 1.05, scaleY: 1.05, ease: Elastic.easeOut,  yoyo: true});
		}
		
		private function out(evt:MouseEvent)
		{
			TweenMax.to(evt.currentTarget, 1, {scaleX: xInit, scaleY: yInit, ease: Elastic.easeOut});
		}
		
		private function clicked(evt:MouseEvent)
		{
			/*
			
			dados.sel = !dados.sel;
			trace("OptBotao CLICK " + dados.desc + " " + dados.sel);
		
			if (dados.sel)
				this.alpha = 0.5;
			else	
				this.alpha = 1.0;
			*/
		}
		
		private function SMBTclicked(evt:MouseEvent)
		{
			dados.haveSisModMark = !dados.haveSisModMark;
			trace("SMBTclicked CLICK " + evt.currentTarget + " " + dados.haveSisModMark);
			
			onMiniBtClicked.customMessage = "SMBTclicked";
			dispatchEvent(onMiniBtClicked);
		}
		private function BEBTclicked(evt:MouseEvent)
		{
			dados.haveBEMark = !dados.haveBEMark;
			trace("BEBTclicked CLICK " + evt.currentTarget + " " + dados.haveBEMark);
			onMiniBtClicked.customMessage = "BEBTclicked";
			dispatchEvent(onMiniBtClicked);
		}
		private function BTBTclicked(evt:MouseEvent)
		{
			dados.haveBTMark = !dados.haveBTMark;
			trace("BTBTclicked CLICK " + evt.currentTarget + " " + dados.haveBTMark);
			onMiniBtClicked.customMessage = "BTBTclicked";
			dispatchEvent(onMiniBtClicked);
		}
		
		
		public function resetMiniBT()
		{
			dados.haveSisModMark = false;
			dados.haveBEMark = false;
			dados.haveBTMark = false;
			SMBT.gotoAndStop(1);
			BEBT.gotoAndStop(1);
			BTBT.gotoAndStop(1);
		
		}
		
		public function setTexto(t:String)
		{
			texto.text = t;
			BTcontainerMC.height = texto.height;
		}
		
		public function getDados():StructRespostas
		{
			return dados;
		}
		
		public function setDados(dt: StructRespostas)
		{
			dados = dt;
			texto.text = dados.desc;
			ordem.text = dados.ord;
			//vai para clicado qdo load
			this.alpha = dados.sel || dados.ord != ""?0.5: 1.0;
			if (dados.haveSisModMark)
				SMBT.gotoAndStop(2);
			if (dados.haveBEMark)
				BEBT.gotoAndStop(2);
			if (dados.haveBTMark)
				BTBT.gotoAndStop(2);
			BTcontainerMC.height = texto.height;
		}
		
		public function setOrdem(t:String)
		{
			ordem.text = t;
			dados.ord = t;
			dados.sel = t == "" ? false : true;
			this.alpha = dados.sel ?0.5: 1.0;
		}
		
		public function getOrdem():Number
		{
			if (ordem.text == "" || ordem.text == " ")
				return 0;
			if 	(ordem.text == "X")
				return -1;
				
			return Number(ordem.text);
		}
	
		public function OptBotaoClass(dt:StructRespostas=null,isOrd:Boolean=false) {
			
			if (dt!=null)
				setDados(dt);
			isOrdem = isOrd;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

	}
	
}
