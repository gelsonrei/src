package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class StructEtapa extends StructBase
	{
		public var telas:Array;
		public var aux:String;
		public var peso:Number;
		public var maxPoints:Number;
		public var qtPerguntas:Number;
		public var totPoints:Number;
		public var textoConceito:String;
		
		public var anotacoes:String;
		
		public function StructEtapa() 
		{
			super();
			structTipo = ETAPA;
			telas = new Array();
			anotacoes = new String();
			aux = new String();
			peso = new Number(0);
			maxPoints = new Number(0);
			qtPerguntas = new Number(0);
			totPoints = new Number(0);
			textoConceito = new String();
		}
		
	}

}