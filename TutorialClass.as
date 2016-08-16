package  
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.*;
	import flash.events.MouseEvent;
	
	TweenPlugin.activate([TintPlugin]);
	
	
		
	
	/**
	 * ...
	 * @author Gelson
	 */
	public class TutorialClass extends MovieClip 
	{
		
		//private var myLoader:Loader;
		//private var tutoMC:MovieClip;
		
		private var mc:MovieClip = QuizTuto;
		private	var HideMCs:Array; 
		
		public function TutorialClass() 
		{
			if (stage) 	init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
				
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			/*
			myLoader = new Loader();
			myLoader.load(new URLRequest("tutorial.swf"));
			trace("init " +myLoader.name);
			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			*/
			
			
			
			TweenLite.to(ferramentasCont.MChistoria, 0.15, {alpha:0.5});
			ferramentasCont.MChistoria.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT );
			ferramentasCont.MChistoria.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT );
			ferramentasCont.MChistoria.addEventListener(MouseEvent.CLICK, onMouseCLICK );
			ferramentasCont.MChistoria.buttonMode = true;
			
			TweenLite.to(ferramentasCont.MCNotas, 0.15, {alpha:0.5});
			ferramentasCont.MCNotas.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT );
			ferramentasCont.MCNotas.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT );
			ferramentasCont.MCNotas.addEventListener(MouseEvent.CLICK, onMouseCLICK );
			ferramentasCont.MCNotas.buttonMode = true;
			
			TweenLite.to(ferramentasCont.MCPasta, 0.15, {alpha:0.5});
			ferramentasCont.MCPasta.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT );
			ferramentasCont.MCPasta.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT );
			ferramentasCont.MCPasta.addEventListener(MouseEvent.CLICK, onMouseCLICK );
			ferramentasCont.MCPasta.buttonMode = true;
			
			TweenLite.to(ferramentasCont.MCBT, 0.15, {alpha:0.5});
			ferramentasCont.MCBT.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT );
			ferramentasCont.MCBT.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT );
			ferramentasCont.MCBT.addEventListener(MouseEvent.CLICK, onMouseCLICK );
			ferramentasCont.MCBT.buttonMode = true;
			
			TweenLite.to(ferramentasCont.MCBE, 0.15, {alpha:0.5});
			ferramentasCont.MCBE.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT );
			ferramentasCont.MCBE.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT );
			ferramentasCont.MCBE.addEventListener(MouseEvent.CLICK, onMouseCLICK );
			ferramentasCont.MCBE.buttonMode = true;
			
			TweenLite.to(ferramentasCont.MCCafe, 0.15, {alpha:0.5});
			ferramentasCont.MCCafe.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT );
			ferramentasCont.MCCafe.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT );
			ferramentasCont.MCCafe.addEventListener(MouseEvent.CLICK, onMouseCLICK );
			ferramentasCont.MCCafe.buttonMode = true;
			
			TweenLite.to(ferramentasCont.MCFala, 0.15, {alpha:0.5});
			ferramentasCont.MCFala.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT );
			ferramentasCont.MCFala.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT );
			ferramentasCont.MCFala.addEventListener(MouseEvent.CLICK, onMouseCLICK );
			ferramentasCont.MCFala.buttonMode = true;
			
			
			ferramentasCont.MCnesta.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverBT );
			ferramentasCont.MCnesta.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutBT );
			ferramentasCont.MCnesta.addEventListener(MouseEvent.CLICK, onMouseCLICK );
			ferramentasCont.MCnesta.buttonMode = true;

			
			HideMCs = new Array(QuizTuto, BriefingTuto, DesenvolveTuto, PreparaTuto, ApresentacaoTuto);
			gotoTo("Apresentacao");
			
			
			
		}
		
		/*
		private function onComplete(evt:Event):void
		{
			trace("Complete load " +myLoader.name);
			tutoMC = MovieClip(myLoader.contentLoaderInfo.content);
			addChild(tutoMC);
			setChildIndex( BTfechar, this.numChildren - 1);
		}
		*/
		
		
		public function gotoTo(frame:String):void
		{
			hideAll();
			switch (frame)
			{
				case "Quiz" 		: mc = QuizTuto; 		break;
				case "Briefing" 	: mc = BriefingTuto; 	break;
				case "Desenvolve" 	: mc = DesenvolveTuto; 	break;
				case "Prepara" 		: mc = PreparaTuto; 	break;
				case "Apresentacao" : mc = ApresentacaoTuto; break;
			}
			
			mc.x = 563;
			mc.y = 442;
			mc.visible = true;
			mc.gotoAndStop(1);
		}
		
		public function hideAll():void
		{
			ferramentasCont.gotoAndStop(1);
			
			
			TweenLite.to(ferramentasCont.MChistoria, 0.15, {tint:null});
			TweenLite.to(ferramentasCont.MCnesta, 0.15, {tint:null});
			TweenLite.to(ferramentasCont.MCNotas, 0.15, {tint:null});
			TweenLite.to(ferramentasCont.MCPasta, 0.15, {tint:null});
			TweenLite.to(ferramentasCont.MCBT, 0.15, {tint:null});
			TweenLite.to(ferramentasCont.MCBE, 0.15, {tint:null});
			TweenLite.to(ferramentasCont.MCCafe, 0.15, {tint:null});
			TweenLite.to(ferramentasCont.MCFala, 0.15, {tint:null});
			
			for (var i:int = 0; i < HideMCs.length; i++)
			{
				HideMCs[i].visible = false;
			}
		}
		
		
		
		
		
		private function onMouseOverBT(evt:MouseEvent):void
		{

			TweenLite.to(evt.target, 0.15, {alpha:1});

		}

		private function onMouseOutBT(evt:MouseEvent):void
		{

			TweenLite.to(evt.target, 0.15, {alpha:0.5});
		}

		private function onMouseCLICK(evt:MouseEvent)
		{
			
			hideAll();
			
			TweenLite.to(evt.target, 0.15, {alpha:1});
			TweenLite.to(evt.target, 0.15, {tint:0xFFFFFF});
			
			if (evt.currentTarget == ferramentasCont.MCnesta){
				ferramentasCont.gotoAndStop(1);
				mc.visible = true;
			}
			else if (evt.currentTarget == ferramentasCont.MChistoria)
				ferramentasCont.gotoAndStop(2);
			else if (evt.currentTarget == ferramentasCont.MCNotas)
				ferramentasCont.gotoAndStop(3);
			else if (evt.currentTarget == ferramentasCont.MCPasta)
				ferramentasCont.gotoAndStop(4);
			else if (evt.currentTarget == ferramentasCont.MCBT)
				ferramentasCont.gotoAndStop(5);
			else if (evt.currentTarget == ferramentasCont.MCBE)
				ferramentasCont.gotoAndStop(6);
			else if (evt.currentTarget == ferramentasCont.MCCafe)
				ferramentasCont.gotoAndStop(7);
			else if (evt.currentTarget == ferramentasCont.MCFala)
				ferramentasCont.gotoAndStop(8);
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

}