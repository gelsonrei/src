package  
{
	/**
	 * ...
	 * @author Gelson
	 */
	
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	
	
	
	public class BtOrdBlNtClass extends MovieClip 
	{
		
		private var corOrig:ColorTransform;
		public var intNum = 0;
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.alpha = 0.7;
			corOrig = this.transform.colorTransform;
		}
		
		public function setNum(n:int):void
		{
			Num.text = String(n);
			intNum = n;
		}
		
		public function select():void
		{
			this.alpha = 1.0;
		}
		public function unselect():void
		{
			this.alpha = 0.7;
		}
		
		public function setAtiva(b:Boolean):void
		{
			var c:Color = new Color();
			var color:uint = 0xFF0000;
			if (b)
			{
				c.setTint(color, 0.5);
				this.transform.colorTransform = c;
			}
			else
				this.transform.colorTransform=corOrig;
		}
		
		
		
		public function BtOrdBlNtClass() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	}

}