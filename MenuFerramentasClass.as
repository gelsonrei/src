package  {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	
	public class MenuFerramentasClass extends MovieClip {
		
		public var userName:String =  new String();
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addEventListener(MouseEvent.ROLL_OVER, overMenu );
			this.addEventListener(MouseEvent.ROLL_OUT, outMenu );
			this.buttonMode = false;
			
			outMenu();
			btFerrContainner.buttonMode = true;
		}
		
		public function setUserName(user:String):void
		{
			userName= user;
			trace("classe",user);
			btFerrContainner.setUserName(user);
		}
	
		private function overMenu(evt:MouseEvent=null)
		{
			TweenMax.to(this, .5, {y:0});
		}

		private function outMenu(evt:MouseEvent=null)
		{
			TweenMax.to(this, .5, {y:-this.height+35});
		}
	

		public function MenuFerramentasClass() {
			
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
