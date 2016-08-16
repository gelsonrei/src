package
{
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author Maico G.
	 */
	
	public class MainGameBT extends MovieClip
	{
		
		public function MainGameBT()
		{
			
		 if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function init(e:Event = null):void 
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(Event.ADDED, onAdded);
			stage.addEventListener(Event.RESIZE, resizeDisplay);
			stage.scaleMode = StageScaleMode.EXACT_FIT; 
			//stage.scaleMode = StageScaleMode.SHOW_ALL; 
			stage.align = StageAlign.TOP_LEFT; 
 	
		}
		
		
		private function resizeDisplay(event:Event):void 
		{ 
			
		} 
		
		private function onAdded(e:Event):void {
			if (e.target is FLVPlayback) e.target.fullScreenTakeOver = false;
		}
		
		
		
		
	
	}
}