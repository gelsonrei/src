package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class StructPerguntaDLG extends StructBase
	{
		public var EtPulo:int = -1;
		public var TlPulo:int = -1;
		public var video:String;
		public var video2:String;
		public var som:String;
		public var resposta:String;
		public var respErr:String;
		public var id_perfil:int = 0;
		public var sel:Boolean = false;
		public var agente:int = -1;
		
		public function StructPerguntaDLG() 
		{
			super();
			structTipo = PERGUNTA_DLG;
			agente = AGENTE_PV;
			resposta = new String();
			respErr = new String();
			video = new String();
			video2 = new String();
			som = new String();
			
		}
		
	}

}