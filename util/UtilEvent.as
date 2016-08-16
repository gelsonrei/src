/**
 * 
 */
package util
{
	import flash.events.Event;

	
	/**
	 * dispatchEvent(new UtilEvent(tWUIEvent.event, true, false, value, or array of values you want to broadcast));
	 * custom Event class
	 */
	public class UtilEvent extends Event
	{
		/**
		 * Event constants
		 */
		public static const FILE_EXISTS:String = "FILE_EXISTS";
		public static const FILE_NOT_FOUND:String = "FILE_NOT_FOUND";
		
		private var _url:String;
		
		/**
		 * 
		 * @param	type		String		ref to the type of event
		 * @param	bubbles		Boolean		see AS3 docs - Indicates whether an event is a bubbling event.
		 * @param	cancelable	Boolean		see AS3 docs - Indicates whether the behavior associated with the event can be prevented.
		 * @param	...rest		Array		Array of arguments
		 */
		public function UtilEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, url:String = null) 
		{
			super(type, bubbles, cancelable);
			_url = url;
		}
		
		
		/**
		 * Duplicates an instance of an Event subclass.
		 * 
		 * @usage	see AS3 Docs
		 * @return	Event
		 * 
		 */
		public override function clone():Event
		{
			return new UtilEvent(type, bubbles, cancelable, _url);
		}
		
		/**
		 * See AS3 Docs
		 * @return	String		
		 */
		public override function toString():String
		{
			return formatToString("UtilEvent", "type", "bubbles", "cancelable", "eventPhase", _url);
		}
		
		/**
		 * url of file that was being loaded
		 */
		public function get url():String { return _url; }
		
	}	
}