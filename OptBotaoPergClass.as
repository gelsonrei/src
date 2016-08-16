package  {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import GameBontempo.StructPerguntaDLG;
	
	
	
	public class OptBotaoPergClass extends MovieClip {
		private var xInit:Number;
		private var yInit:Number;
		public var dados:StructPerguntaDLG;
	
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		   	this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			this.addEventListener(MouseEvent.CLICK, clicked);
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
			trace("OptBotaoPerg CLICK " +dados.desc);
		}
		
		public function setTexto(t:String)
		{
			texto.text = t;
			BTcontainerMC.height = texto.height;
		}
		
		public function setOrdem(t:String)
		{
			ordem.text=t;
		}
		
		
		public function getDados():StructPerguntaDLG
		{
			return dados;
		}
		
		public function setDados(dt: StructPerguntaDLG)
		{
			dados = dt;
			texto.text = dados.desc;
			BTcontainerMC.height = texto.height;
		}
	
		public function OptBotaoPergClass(dt:StructPerguntaDLG) {
			setDados(dt);
			setOrdem("");
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

	}
	
}
