package GameBontempo 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gelson
	 */
	public class MyTimerEvents extends Event 
	{
		public static const ON_IDLE_REACHED:String = "onIdleReached";
		public var customMessage:String = "";
		
		public function MyTimerEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MyTimerEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MyTimerEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}