package GameBontempo 
{
	/**
	 * ...
	 * @author Gelson
	 */
	public class DlgState 
	{
		
		public static const IDLE:int 	= 0;
		public static const PVASK:int   = 1;
		public static const PVWAIT:int  = 2;
		public static const CLIANSW:int	= 3;
		public static const CLIASK:int  = 4;
		public static const CLIWAIT:int = 5;
		public static const PVANSW:int 	= 6;
		
		public static var ATUAL:int = PVWAIT;
		
		public static function printState(coment:String,state:int):void
		{
			trace(coment);
			switch (state)
			{
				case IDLE:trace("STATE IDLE"); break;
				case PVASK:trace("STATE PVASK"); break;
				case PVWAIT:trace("STATE PVWAIT"); break;
				case CLIANSW:trace("STATE CLIANSW"); break;
				case CLIASK:trace("STATE CLIASK"); break;
				case CLIWAIT:trace("STATE CLIWAIT"); break;
				case PVANSW:trace("STATE PVANSW"); break;
			}
			
		}
		
		public function DlgState() 
		{
			
		}
		
	}

}