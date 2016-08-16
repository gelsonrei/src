package GameBontempo
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gelson
	 */
	public class XMLOptLoaderEvents extends Event 
	{
		public static const ON_XML_PROCESSED:String = "onXmlProcessed";
		public static const ON_XML_ERROR:String = "onXmlError";
		public var customMessage:String = "";

		public function XMLOptLoaderEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new XMLOptLoaderEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("XMLOptLoaderEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}