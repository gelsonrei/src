package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class StructPerfilDLG extends StructBase
	{
		
		public var perguntas:Array;
		public var id_etapa:int = 0;
		
		public function StructPerfilDLG() 
		{
			super();
			structTipo = PERFIL_DLG;
			perguntas = new Array();
		}
		
	}

}