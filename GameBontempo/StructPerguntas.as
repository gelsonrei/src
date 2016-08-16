package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class StructPerguntas extends StructBase
	{
		public var respostas:Array;
		public var id_tela:int = 0;
		public var nivel:int = 0;
		public var multi:int = 1;
		public var ordenado:Boolean = false;
		public var okCliked:Boolean = false;
		public var opcaoOrdem:int = 0;
		
		
		public function StructPerguntas() 
		{
			super();
			structTipo = PERGUNTA;
			respostas = new Array();
		}
		
	}

}