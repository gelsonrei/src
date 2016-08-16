package GameBontempo 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author gelson
	 */
	public class AuthEvents extends Event 
	{
		public static const ON_SUCESS:String = "onAuthSucess";
		public static const ON_EROOR:String = "onAuthError";
		public static const ON_GETUID:String = "onGetUID";
		
		public var customMessage:String = "";
		
		public function AuthEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new AuthEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AuthEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}