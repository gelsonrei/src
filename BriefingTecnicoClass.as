package  
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.*;
	import GameBontempo.DefinesLoader;
	
	
	/**
	 * ...
	 * @author Gelson
	 */
	

	public class BriefingTecnicoClass extends MovieClip 
	{
		
		private var myLoader:Loader;
		private var perfilId:int=0;
		
		public function BriefingTecnicoClass(idPerfil:int) 
		{
			perfilId = idPerfil;
			if (stage) 	init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
				
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			myLoader = new Loader();
			myLoader.load(new URLRequest(DefinesLoader.ASSETS_PATH+"BriefingTecnico"+perfilId+".swf"));
			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			
			
		}
		
		private function onComplete(evt:Event):void
		{
			trace("Complete load " +myLoader.name);
			
			var BTMC:MovieClip= MovieClip(myLoader.contentLoaderInfo.content);
			addChild(BTMC);
			setChildIndex( BTMC, this.numChildren - 1);
			setChildIndex( BTfechar, numChildren - 1);
			
			//addChild(myLoader);
		}
		
		
		
	}

}