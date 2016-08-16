package  {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	
	public class MenuDebugClass extends MovieClip {
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addEventListener(MouseEvent.ROLL_OVER, overMenu );
			this.addEventListener(MouseEvent.ROLL_OUT, outMenu );
			this.buttonMode = false;
		}
		
		
		
		private function overMenu(evt:MouseEvent=null)
		{
			TweenMax.to(this, .5, {y:0});
		}

		private function outMenu(evt:MouseEvent=null)
		{
			TweenMax.to(this, .5, {y:-height+18});
		}
	

		private function onMouseOverBT (evt:MouseEvent):void
		{
			evt.target.alpha = 1;
		}

		private function onMouseOutBT (evt:MouseEvent)
		{
			evt.target.alpha = .25;
		}

		public function MenuDebugClass() {
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		public function enable():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER, overMenu);
			this.addEventListener(MouseEvent.ROLL_OUT, outMenu);
		}
		
		public function disable():void
		{
			outMenu();
			this.removeEventListener(MouseEvent.ROLL_OVER, overMenu);
			this.removeEventListener(MouseEvent.ROLL_OUT, outMenu);
		}
		
		

	}
	
}
