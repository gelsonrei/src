package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class StructEtapaDLG extends StructBase
	{
		public var perfis:Array;
		public var video:String;
		public var som:String;
		
		public function StructEtapaDLG() 
		{
			super();
			structTipo = ETAPA_DLG;
			perfis = new Array();
			video = new String();
			som = new String();
		}
		
	}

}