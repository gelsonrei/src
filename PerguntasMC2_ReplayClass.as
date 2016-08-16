package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author gelson
	 */
	public class PerguntasMC2_ReplayClass extends MovieClip
	{
		
		public function PerguntasMC2_ReplayClass()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			PerguntasHeadMC.BTfecharPerguntas.visible = false;
			PerguntasHeadMC.TFpontos.visible = false;
		}
		
		public function setPerguntas(lista:XML):void
		{
			if (lista == null)
				return;
			var btPV: fundoBotaoPergReplayClass;// = new fundoBotaoPergReplayClass();
			var btC : fundoBotaoRespReplayClass;// = new fundoBotaoRespReplayClass();
			
			
			var lastSz:Number = 25;
			var lastY:Number = 35;
				
			var perguntas:XMLList = lista.pergunta;
			for each (var p:XML in perguntas)
			{
				
				
				if (p.@agente == "C"){
					btC = new fundoBotaoRespReplayClass(p.@desc);
					PerguntasMC.addChild(btC);
					btC.x = 30;
					btC.y = lastY + lastSz + 5;
					lastY = btC.y;
					lastSz = btC.height;
					
					btPV = new fundoBotaoPergReplayClass(p.@resp);
					PerguntasMC.addChild(btPV);
					btPV.x = 10;
					btPV.y = lastY + lastSz + 5;
					lastY = btPV.y;
					lastSz = btPV.height;
				}
				else
				{
					btPV = new fundoBotaoPergReplayClass(p.@desc);
					PerguntasMC.addChild(btPV);
					btPV.x = 10;
					btPV.y = lastY + lastSz + 5;
					lastY = btPV.y;
					lastSz = btPV.height;
					
					btC = new fundoBotaoRespReplayClass( p.@resp);
					PerguntasMC.addChild(btC);
					btC.x = 30;
					btC.y = lastY + lastSz + 5;
					lastY = btC.y;
					lastSz = btC.height;
				}
			}
		
		}
	
	}

}