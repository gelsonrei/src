package GameBontempo 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gelson C. R.
	 */
	public class NTPEvents extends Event 
	{
		
		public static const ON_SUCESS:String = "onSucess";
		public static const ON_EROOR:String = "onError";
		public static const ON_ETPROCESS:String = "onEtapaProcessada";
		
		public var customMessage:String = "";
		
		public function NTPEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new NTPEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("NTPEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}