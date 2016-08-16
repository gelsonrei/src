package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class Estilo 
	{
		public static const QUIZ:int 	= 0;
		public static const DIALOGO:int = 1;
		public static const VIDEO:int 	= 2;
		public static const MINIGAME:int 	= 3;
		public static const VIDEO_PV_AFIRMA:int 	= 4;
		public static const VIDEO_C_AFIRMA:int 	= 5;
		public static const QUIZ_C_PERGUNTA:int 	= 6;
		public static const INTRODUCAO:int 	= 7;
			
		public static const Lista:Array= ["QUIZ","DIALOGO","VIDEO","MINIGAME","VIDEO_PV_AFIRMA","VIDEO_C_AFIRMA","QUIZ_C_PERGUNTA","INTRODUCAO"];
		
		public static function convertToEstilo(str:String):int
		{
			return Lista.indexOf(str);
		}
		
	}

}