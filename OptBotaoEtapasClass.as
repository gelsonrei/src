package
{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import GameBontempo.StructEtapa;
	
	public class OptBotaoEtapasClass extends MovieClip
	{
		private var xInit:Number;
		private var yInit:Number;
		public var dados:StructEtapa;
		private var sel:Boolean;
		public var ord:int;
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			this.addEventListener(MouseEvent.CLICK, clicked);
			this.texto.addEventListener(MouseEvent.CLICK, clicked);
			this.buttonMode = true;
			
			xInit = this.scaleX;
			yInit = this.scaleY;
			
			texto.autoSize = TextFieldAutoSize.LEFT;
			texto.wordWrap = true;
			BTcontainerMC.height = texto.height;
			
			sel = false;
		}
		
		private function over(evt:MouseEvent)
		{
			
			TweenMax.to(evt.currentTarget, 1, {scaleX: 1.05, scaleY: 1.05, ease: Elastic.easeOut, yoyo: true});
		}
		
		private function out(evt:MouseEvent)
		{
			TweenMax.to(evt.currentTarget, 1, {scaleX: xInit, scaleY: yInit, ease: Elastic.easeOut});
		}
		
		private function clicked(evt:MouseEvent)
		{
			trace("OptBotaoEtapas CLICK " + dados.desc);
		}
		
		public function setTexto(t:String)
		{
			texto.text = t;
			BTcontainerMC.height = texto.height;
		}
		
		public function setOrdem(t:String)
		{
			ordem.text = t;
		}
		
		public function getDados():StructEtapa
		{
			return dados;
		}
		
		public function setDados(dt:StructEtapa)
		{
			dados = dt;
			texto.text = dados.desc;
			ordem.text = new String(dados.id);
			BTcontainerMC.height = texto.height;
		}
		
		public function OptBotaoEtapasClass(dt:StructEtapa, o:int)
		{
			setDados(dt);
			ord = o;
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
	
	}

}
