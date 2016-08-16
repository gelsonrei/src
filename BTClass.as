package  {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	
	public class BTClass extends MovieClip {
		private var xInit:Number;
		private var yInit:Number;
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		   	enable();
			
			xInit = this.scaleX;
			yInit = this.scaleY;
		}
		
		public function disable():void
		{
			this.removeEventListener(MouseEvent.ROLL_OVER, over);
			this.removeEventListener(MouseEvent.ROLL_OUT, out);
			this.removeEventListener(MouseEvent.CLICK, clicked);
			this.buttonMode = false;
		}
		
		public function enable():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			this.addEventListener(MouseEvent.CLICK, clicked);
			this.buttonMode = true;
		}
		
		private function over(evt:MouseEvent)
		{
			
			TweenMax.to(evt.currentTarget, 1, {scaleX: 1.2, scaleY: 1.2, ease: Elastic.easeOut,  yoyo: true});
		}
		
		private function out(evt:MouseEvent)
		{
			TweenMax.to(evt.currentTarget, 1, {scaleX: xInit, scaleY: yInit, ease: Elastic.easeOut});
		}
		
		private function clicked(evt:MouseEvent)
		{
			trace("BT CLICK ");
		}
		
		
	
		public function BTClass() {
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

	}
	
}
