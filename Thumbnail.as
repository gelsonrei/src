package  {
	import caurina.transitions.*;
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.Tweener;
	import fl.containers.UILoader;
	import fl.motion.Color;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import GameBontempo.DefinesLoader;
	
	
	
	
	public class Thumbnail extends Sprite {
		public var nume:String;
		public var url:String;
		public var id:int;
		public var valor:int = 0;
		private var loader:UILoader;
		public  var isSelected:Boolean = false;
		public  var isReplayGame:Boolean = false;
		
		private var corOrig:ColorTransform;
 
		function Thumbnail(source:String,itemNr:int,numeThumb:String):void {
			ColorShortcuts.init();
			url = DefinesLoader.ASSETS_PATH+source;
			id = itemNr;
			this.nume = numeThumb;
			corOrig = this.transform.colorTransform;
			
			drawLoader();
			addEventListener(MouseEvent.CLICK, Click);
			addEventListener(MouseEvent.MOUSE_OVER,onOver);
			addEventListener(MouseEvent.MOUSE_OUT,onOut);
			scaleThumb();
		}
		private function drawLoader():void {
			loader = new UILoader();
			loader.source = url;
			loader.mouseEnabled = false;
			loader.x = -50;
			loader.y = -50;
			
			//addChild(loader);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(Event.COMPLETE, done)
 
		}
		
		private function done(e:Event):void {
		   addChild(loader);
		}
		
		private function errorHandler(e:IOErrorEvent):void {
		    trace ("e.toString = " + e.toString);            
			trace ("e.text = " + e.text);
			
			var t:TextField = new TextField();
			t.width = 200;
			t.text = (e.toString + e.text);
			//addChild(t);
			
		}
		
		public function setHi():void
		{
			var c:Color = new Color();
			var color:uint = 0x0000ff;
			
			c.setTint(color, 0.5);
			this.transform.colorTransform = c;
		}
		
		public function setAtiva(b:Boolean):void
		{
			if (isReplayGame)
				return;
				
			var c:Color = new Color();
			var color:uint = 0x00ff00;
			if (b)
			{
				c.setTint(color, 0.5);
				this.transform.colorTransform = c;
			}
			else
				this.transform.colorTransform=corOrig;
		}
		
		public function Click(event:MouseEvent=null):void {
			if (isReplayGame)
				return;
			
			isSelected = !isSelected;
			setAtiva(isSelected);
			if(isSelected)
			{
				Tweener.addTween(this, {scaleX:1,scaleY:1, time:1, transition:"easeoutelastic"});
				Tweener.addTween(this, { alpha:1, time:1, transition:"easeoutelastic" } );
				//Tweener.addTween(this, {_color: 0x000500, time: 2});
			}
			else
			{
				Tweener.addTween(this, {scaleX:.9,scaleY:.9, time:1, transition:"easeoutelastic"});
				Tweener.addTween(this, { alpha:.5, time:1, transition:"easeoutelastic" } );
				//Tweener.addTween(this, {_color:null, time: 2});
			}
		}
		
				
		private function onOver(event:MouseEvent):void {
			if (isReplayGame)
				return;
			Tweener.addTween(this, {scaleX:1,scaleY:1, time:1, transition:"easeoutelastic"});
			Tweener.addTween(this, {alpha:1, time:1, transition:"easeoutelastic"});
		}
		
		private function onOut(event:MouseEvent):void {
			if (isReplayGame)
				return;
				
			if (isSelected) 
				return;
			Tweener.addTween(this, {scaleX:.9,scaleY:.9, time:1, transition:"easeoutelastic"});
			Tweener.addTween(this, {alpha:.5, time:1, transition:"easeoutelastic"});
		}
		
		private function scaleThumb():void {
			this.scaleX = .9;
			this.scaleY = .9;
			this.alpha = .5;
		}
	}
}