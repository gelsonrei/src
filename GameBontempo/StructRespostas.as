package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class StructRespostas extends StructBase
	{
		public var id_perg:int = 0;
		public var pri:int = 0;
		public var link:String;
		public var nivel:int = 0;
		public var sel:Boolean = false;
		public var ord:String;
		
		public function StructRespostas() 
		{
			super();
			structTipo = RESPOSTA;
			link = new String();
			ord = new String();
		}
		
	}

}