package  
{
	/**
	 * ...
	 * @author gelson
	 */
	
	 
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	 
	 
	public class PastaClienteClass extends MovieClip
	{
		
		private var BTArray:Array;
		
		private var TFArray:Array;
		
		//TFAcom21, TFComo25, TFTRes26
		
		private var TXArray:Array;
		
		private var campos1:Array;
		private var campos2:Array;
		public var clicados:Array = new Array();
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			BTArray = new Array(BTCli1, BTEnd2, BTRef3, BTCep4, BTMail5, BTFoneCom6, BTCPF7, 
			BTRG8, BTAni9, BTCad10, BTPV11, BTCod12, BTProj13, BTBai14, BTCid15, BTEst16, BTFoneRes17, BTFoneCel18, BTCNPJ19, BTConf20, 
			BTAcom21, BTAcNome22, BTAcFone23, BTAcMail24, 
			BTComo25, BTTRes26, BTEdif27, BTConst28, BTPrev29, BTPrazo30, BTOrca31, BTInvest32);
			
			TFArray = new Array(TFCli1, TFEnd2, TFRef3, TFCep4, TFMail5, TFFoneCom6, TFCPF7, 
			TFRG8, TFAni9, TFCad10, TFPV11, TFCod12, TFProj13, TFBai14, TFCid15, TFEst16, TFFoneRes17, TFFoneCel18, TFCNPJ19, TFConf20, 
			TFAcom21, TFAcNome22, TFAcFone23, TFAcMail24, 
			TFComo25, TFTRes26, TFEdif27, TFConst28, TFPrev29, TFPrazo30, TFOrca31, TFInvest32);
			
			TXArray= new Array("Ronaldo e Roberta  Nascimento", "Rua da Aurora, 678", "Jardim  Paulista", "011378-900", "Ronaldonas@uol.com", "011-36922211", "123.567.990.67",
			"10020030010", "15/06", "16/06/13", "Fernanda", "069", "054", "Lindóia", "São Paulo", "SP", " ", "011-988776655", " ", " ",
			"Arquiteto","Jacinto Pereira","011-34698787","jacintoarq@projetos.com.br",
			"Vitrine", "Apartamento", "Mirage", "", " ", " ", "SIM, com F", "+ou-  R$ 200.000,00");
			
			/* 0 - Nome 
			 * 4 - Email
			 * 5 - Fone Com.
			 * 8 - Dt aniver
			 * 17 - Cel
			 * 
			 */
			
			campos1  = [0, 4, 5, 8, 17];
			
			
			/* 6 - CPF 
			 * 20 - Especificador
			 * 24 - como chegou a loja
			 * 
			 */
			
			campos2  = [6, 20, 24];
			
		
			for (var i:int = 0; i < BTArray.length; i++)
			{
				BTArray[i].addEventListener(MouseEvent.CLICK, onClick);
				BTArray[i].buttonMode = true;

			}
			
		}
		
		
		public function setPerfil(id:int)
		{
			if (id == 0)
			{
				TXArray= new Array("Ronaldo e Roberta  Nascimento", "Rua da Aurora, 678", "Jardim  Paulista", "011378-900", "Ronaldonas@uol.com", "011-36922211", "123.567.990.67",
				"10020030010", "15/06", "16/06/13", "Fernanda", "069", "054", "Lindóia", "São Paulo", "SP", " ", "011-988776655", " ", " ",
				"Arquiteto","Jacinto Pereira","011-34698787","jacintoarq@projetos.com.br",
				"Vitrine", "Apartamento", "Mirage", "", "31/03/2014", " ", "SIM, com F", "+ou-  R$ 200.000,00");
			}
			else if (id == 1)
			{
				TXArray= new Array("Julio e Jairo", "Rua da Palavra 234", "Jardim  Paulista", "011378-900", "jj@hotmail.com", "011- 456732", "123.567.990.67",
				"10020030010", "18/02", "16/06/13", "Daniela", "0123", "2402", "Amarilis", "São Paulo", "SP", " ", "011-988776655", " ", " ",
				"Arquiteto","Ricardo  Fagundes","011-34698787","ricafq@projetos.com.br",
				"Arquiteto", "Apartamento", "Milor", "", " ", " ", "SIM, com F", "+ou-  R$ 120.000,00");
			}
			else if (id == 2)
			{
				TXArray= new Array("Paula Marinho", "Av. Atlântica", "Copacabana", "011378-900", "paulam@hotmail.com", "021- 3645-6732", "153.567.980.67",
				"10020030010", "18/02", "18/01", "Ana", "2402", "0122", "Copacabana", "Rio de Janeiro", "RJ", " ", "021-988776655", " ", " ",
				"","","","",
				"Mostras Decoração", "Apartamento", "Sogno Della Vita", "", "31/03/2014", " ", "SIM, com F", "+ou-  R$ 100.000,00");
			}
		}
		
		public function setClicadosOnLoad(xmlClic:XML):void
		{
			var itens:XMLList = new XMLList();
			var i:int = 0;
			
			clicados = new Array();
			
			itens = xmlClic.item; 
			for each (var v:XML in itens)
			{
				fieldShowContent(Number(v.@idx));
			}
		}
		
		private function fieldShowContent(idx:Number = -1):int 
		{
			
			if (idx < 0) 
				return idx;
			
			if(TFArray[idx].text==""){
				TFArray[idx].text = TXArray[idx];
				clicados.push(idx);
			}
			
			var target:MovieClip = BTArray[idx];
			
			if (target == BTAcom21)
			{
				if (TFAcom21.text != ""){
					ck_sim.gotoAndStop(2);
				}
				else
					ck_nao.gotoAndStop(2);
				
				if (TFAcom21.text == "Arquiteto"){
					ck_1.gotoAndStop(2);
				}
				
			}
				
			if (target == BTComo25)
			{
				if (TFComo25.text == "Arquiteto")
					ck1.gotoAndStop(2);
				if (TFComo25.text == "Vitrine")
					ck11.gotoAndStop(2);
				if (TFComo25.text == "Mostras Decoração")
					ck8.gotoAndStop(2);
			}
			
			if (target == BTTRes26)
			{
				if (TFTRes26.text == "Apartamento")
					ck17.gotoAndStop(2);
			}
			
			return idx;
			
		}
		
		private function onClick(evt:MouseEvent)
		{
			for (var i:int = 0; i < BTArray.length; i++)
			{
				if (evt.currentTarget == BTArray[i]) {
					if(TFArray[i].text==""){
						fieldShowContent(i);
						
					}
				}
			}
			
			
		}
		
		public function verficaEssencias1():Boolean
		{
			var count:int = 0;
			for (var i:int = 0; i < campos1.length; i++) 
			{
				if (TFArray[campos1[i]].text != ""){
					trace(TFArray[campos1[i]].text + " "+campos1[i]);
					count++;
				}
			}
			return count == campos1.length?true:false;
		}
		
		public function verficaEssencias2():Boolean
		{
			var count:int = 0;
			for (var i:int = 0; i < campos2.length; i++) 
			{
				if (TFArray[campos2[i]].text != ""){
					trace(TFArray[campos1[i]].text + " "+campos1[i]);
					count++;
				}
			}
			return count == campos2.length?true:false;
		}
		
		public function PastaClienteClass() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	}

}