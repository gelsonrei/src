package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author gelson
	 */
	public class fundoBotaoPergReplayClass extends MovieClip 
	{
		
		public function fundoBotaoPergReplayClass(t:String) 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			texto.text = "PV: " + t;
			texto.autoSize = TextFieldAutoSize.LEFT; 
			texto.wordWrap = true;
			BTcontainerMC.height = texto.height;
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		   	
			
		}
		
		
	}

}