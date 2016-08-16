package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class StructBase 
	{
		public static const BASE:String 	= "BASE";
		public static const ETAPA:String 	= "ETAPA";
		public static const TELA:String 	= "TELA";
		public static const PERGUNTA:String = "PERGUNTA";
		public static const RESPOSTA:String = "RESPOSTA";
		public static const ETAPA_DLG:String = "ETAPA_DLG";
		public static const RESPOSTA_DLG:String = "RESPOSTA_DLG";
		public static const PERGUNTA_DLG:String = "PERGUNTA_DLG";
		public static const PERFIL_DLG:String = "PERFIL_DLG";
		
		public static const AGENTE_PV:int = 0;
		public static const AGENTE_C:int = 1;
		
		
		public var id:int = 0;
		public var desc:String = new String();
		public var structTipo:String = BASE;
		public var valor:Number = 0;
		public var isBT:Boolean = false;
		public var isBE:Boolean = false;
		public var isSisMod:Boolean = false;
		public var haveBTMark:Boolean = false;
		public var haveBEMark:Boolean = false;
		public var haveSisModMark:Boolean = false;
		public var date:String = new String();
		public var time:Number = 0;
		public var pontuacao:Number = 0;
		
		public function StructBase() 
		{
			
		}
		
	}

}