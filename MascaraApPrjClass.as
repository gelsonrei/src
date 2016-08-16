package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import GameBontempo.DefinesLoader;
	
	
	import fl.containers.UILoader;
	 
	public class MascaraApPrjClass extends MovieClip 
	{
		
		public var url:String;
		private var loader:UILoader;
		
		public function MascaraApPrjClass(source:String=null) 
		{
			url = source;
			if (stage) 	init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			loader = new UILoader();
			loader.width = ContainerApProjMC.width;
			loader.height = ContainerApProjMC.height;
			loader.y =  ContainerApProjMC.y;
			loader.x =  ContainerApProjMC.x;
			addChild(loader);
			this.visible = false;
		}
		
		private function loaded(evt:Event):void
		{
			addChild(loader);
			trace("ContainerApProjMC " + loader.source);
			trace(this.x + " " + this.y + " " + ContainerApProjMC.x   +" " + ContainerApProjMC.y   +" " + ContainerApProjMC.width);
		}
		
		public function load(source:String):void
		{
			url = source;
			loader.source = DefinesLoader.ASSETS_PATH+url;
			//loader.addEventListener(Event.COMPLETE, loaded);
		}
		
		public function show():void
		{
			this.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
	}

}