package GameBontempo 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author gelson
	 */
	public class MiniBTEvents extends MouseEvent 
	{
		public static const ON_CLICK:String = "onClick";
		public var customMessage:String = "";
		
		public function MiniBTEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MiniBTEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MiniBTEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}