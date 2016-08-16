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
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameBontempo.*;
	
	
	public class BlocoNotasClass extends MovieClip 
	{
		private var btOrd:Array;
		private var stEta:Array;
		private var etAtiva:int = -1;
		private var oldSel:int = -1;
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.BTfecharBloco.addEventListener(MouseEvent.CLICK, onFechar);
		}
		
		public function loadBts(dados: Array):void
		{
			
			var bt: BtOrdBlNtClass;
			var i:int = 0;
			var lastY:Number;
			
			stEta = dados;
			btOrd = new Array();
			
			lastY = -245.85;// -32;//posição do primeiro botão medido no canvas
			
			for each (var dt:StructEtapa in stEta)
			{
				
				if (dt.aux != "2") //2 etapas que nao demandam anotações
				{
					bt = new BtOrdBlNtClass();
					bt.setNum(dt.id);
					btOrd.push(bt);
					addChild(bt);
				
					bt.x = 220;
					bt.y = lastY;
					lastY = bt.y+bt.height+0.5;
					
					bt.Num.addEventListener(MouseEvent.CLICK, changeAba);
					
					if (oldSel < 0)
					{
						oldSel = dt.id;
						etAtiva = dt.id;
					}
				}
			}
		}
		
		public function setAtiva(id:int):void
		{
			etAtiva = id;
			
			for each (var bt:BtOrdBlNtClass in btOrd)
			{
				bt.setAtiva(false);
				if (bt.intNum == id){
					bt.setAtiva(true);
					select(bt, id);
				}
				bt.visible = true;
				if (bt.intNum > etAtiva)
					bt.visible = false;
			}
		}
		
		private function changeAba(evt:MouseEvent = null):void
		{
			var id:int = int(evt.currentTarget.text);
			
			if (id==oldSel)
				return;
			setNote(oldSel);
			select(evt.currentTarget.parent, id);
		}
		
		public function select(bt:BtOrdBlNtClass,id:int):void
		{
			oldSel = id;
			
			for each (var btu:BtOrdBlNtClass in btOrd)
			{
				btu.unselect();
			}
			bt.select();
			Titulo.text = stEta[id].desc;
			texto.text = stEta[id].anotacoes;
		}
		
		public function setNote(etId:int):void
		{
			stEta[etId].anotacoes = texto.text;
		}
		
		
		private function onFechar(evt:MouseEvent):void
		{
			setNote(oldSel);
		}
		
		public function BlocoNotasClass() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	}

}