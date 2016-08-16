package GameBontempo 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gelson
	 */
	public class XMLSaveEvents extends Event 
	{
		public static const ON_XML_SAVED:String = "onXmlSaved";
		public var customMessage:String = "";
		
		public function XMLSaveEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new XMLSaveEvents(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("XMLSaveEvents", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}