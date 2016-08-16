package  {
	
	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameBontempo.StructRespostas;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	
	
	
	public class AjudaLiderContainerClass extends MovieClip {
		private var xInit:Number;
		private var yInit:Number;
		private var xPos:Number;
		private var yPos:Number;
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			texto.addEventListener(MouseEvent.CLICK, clicked);
			
			this.buttonMode = false;
			
			xInit = this.scaleX;
			yInit = this.scaleY;
			
			xPos = 1285;
			yPos = 156;
			
			this.x = xPos;
			this.y = yPos;
			
			texto.autoSize = TextFieldAutoSize.LEFT; 
			texto.wordWrap = true;
			AjudaLiderContainerMC.height = texto.height + 2*texto.y;
		}
		
		public function animIn()
		{
			
			TweenLite.to(this, 2, {x: (xPos - this.width -100), ease: Back.easeOut});
		}
		
		public function animOut()
		{
			TweenLite.to(this, 2, {x: xPos , ease: Back.easeOut});
		}
		
		private function clicked(evt:MouseEvent)
		{
			trace("AjudaLiderContainerClass CLICK " +texto.text);
		}
		
		
		public function setTexto(t:String)
		{
			texto.text = t;
			AjudaLiderContainerMC.height = texto.height+ 2*texto.y;
		}
		
		public function getTexto():String
		{
			return texto.text;
		}
		
		
	
		public function AjudaLiderContainerClass(t:String) {
			
			setTexto(t);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}

	}
	
}
