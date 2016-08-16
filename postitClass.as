package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.filters.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.events.TweenEvent;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	
	import caurina.transitions.properties.ColorShortcuts;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	
	
	
	public class postitClass extends MovieClip 
	{
		
		public var texto:String;
		private var iniH:Number;
		private var iniW:Number;
		public var iniX:Number;
		public var iniY:Number;
		public var sel:Boolean;
		public var valor:Number = 0;
		public var isReplayGame:Boolean = false;
		
		private var corOrig:ColorTransform;
		
			
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		   
			this.buttonMode = true;
			label.buttonMode = true;
							
			label.autoSize = TextFieldAutoSize.LEFT; 
			label.wordWrap = true;
			
			label.text = texto;
			iniH = this.height;
			iniW = this.width;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, drag);
		    this.addEventListener(MouseEvent.MOUSE_UP, drop);
			
			sel = false;
			corOrig = this.transform.colorTransform;
				
		}
		
		public function backDrag()
		{
			sel = false;
			setAtiva(false);
			
			TweenLite.to(this, 1, { y: iniY, x: iniX,ease: Back.easeOut } );
		}
		
		
		private function drag(e:MouseEvent)
		{
			if (isReplayGame)
			 return;
			var filter = new DropShadowFilter(25,136,0,0.2,10,10);
			this.startDrag();
			this.width = iniH + 5;
			this.height = iniH + 5;
			this.filters = [filter];
		}


		private function drop(e:MouseEvent)
		{
			if (isReplayGame)
			 return;
			var filter = new DropShadowFilter(5,136,0,0.2,10,10);
			this.stopDrag();
			this.width = iniW;
			this.height = iniH;
			this.filters = [filter];
		}
		
		public function setAtiva(b:Boolean=false):void
		{
			var c:Color = new Color();
			var color:uint = 0x00ff00;
			if (sel || b)
			{
				c.setTint(color, 0.2);
				this.transform.colorTransform = c;
			}
			else
				this.transform.colorTransform=corOrig;
		}
		
		
		public function postitClass(t:String, val:Number) {
			texto = t;
			valor = val;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	}

}