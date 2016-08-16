package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class StructTela extends StructBase 
	{
		public var estilo:int;
		public var video:String;
		public var link:String;
		public var vdsufixo:String;
		public var imgMask:String;
		public var ajuda:String;
		public var ajudaSom:String;
		public var som:String;
		public var perguntas:Array;
		public var id_etapa:int;
		public var removido:Number = 0;
		
		public function StructTela() 
		{
			super();
			structTipo = TELA;
			estilo = Estilo.VIDEO;
			link = new String();
			video =  new String();
			vdsufixo =  new String();
			imgMask =  new String();
			som = new String();
			ajuda =  new String();
			ajudaSom =  new String();
			perguntas = new Array();
		}
		
	}

}