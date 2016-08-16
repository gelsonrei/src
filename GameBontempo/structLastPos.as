package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class structLastPos 
	{
		public var etapa:int = 0;
		public var tela:int = 0;
		public var pergunta:int = 0;
		public var totalPointGame:Number;
		public var totalTimeGame:Number;
		public var dataIni:String;
		public var horaIni:String;
		public var dataFim:String;
		public var horaFim:String;
		public var player:String;
		public var perfil:int = 0;
		public var perdeuNegocio:Number = -1;
		public var qtPergFeitasParaCLi:Number = 0;
		
		public function structLastPos(et:int = 0, te:int = 0, pe:int = 0, pg:Number = 0, tg:Number=0 ) 
		{
			etapa = et;
			tela = te;
			pergunta = pe;
			totalPointGame = pg;
			totalTimeGame = tg;
			
			dataIni = new String();
			horaIni = new String();
		    dataFim = new String();
		    horaFim = new String();
			player  = new String();
		}
		
	}

}