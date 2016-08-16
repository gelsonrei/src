package GameBontempo 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author gelson
	 */
	public class MiniGameEvents extends Event 
	{
		public static const ON_HITAREA_DROPPED:String = "onHitAreaDropped";
		public static const OUT_HITAREA_DROPPED:String = "outHitAreaDropped";
		public var customMessage:String = "";
		
		public function MiniGameEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MiniGameEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MiniGameEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}