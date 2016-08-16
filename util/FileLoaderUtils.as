/**
* ...
* @author Default
* @version 0.1
*/
package  util
{
	import util.UtilEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.net.URLStream;
	import flash.utils.Dictionary;
	
	
	/**
	 * Dispatched if the url is valid
	 * 
	 * @eventType UtilEvent.FILE_EXISTS
	 */
	[Event("FILE_EXISTS", type="util.UtilEvent")]
	
	
	/**
	 * Dispatched if the url is invalid
	 * 
	 * @eventType UtilEvent.FILE_NOT_FOUND
	 */
	[Event("FILE_NOT_FOUND", type="util.FILE_NOT_FOUND")]
	
		
	/**
	 * File Loader Util class
	 * Contains utiltiy functions for external file loading
	 *  
	 */
	public class FileLoaderUtils extends EventDispatcher
	{
		/**
		 * stores URLStream instance with ref to URL
		 */
		private var _loaderStore:Dictionary = new Dictionary(true);
		
		
		/**
		 * create instance of class
		 */
		public function FileLoaderUtils()
		{
		
		}
		
		/**
		 * Does a file exist? 
		 * Attempt to load file ising URLStream method
		 * 
		 * Dispatches following events
		 * @eventType UtilEvent.FILE_EXISTS
		 * @eventType UtilEvent.FILE_NOT_FOUND
		 * 
		 * @param	url : String - a valid URL to the file
		 */
		public function doesFileExist(url:String):void
		{
			var req:URLRequest = new URLRequest(url);
			var stream:URLStream = new URLStream();	
			//
			//store ref to url
			_loaderStore[stream] = url;
			//
			_addListeners(stream);
			//
			try 
			{
				stream.load(req);
			} 
			catch (error:Error) 
			{
				trace("Unable to load requested URL.", url);
			}
		}
		
		
		/**
		 * progress event - file exists
		 * @param	e
		 */
		private function _progressHandler(e:Event):void 
		{
			//close stream
			var stream:URLStream = URLStream(e.target);
			stream.close();
			//
			_dispatchEvent(stream, true);
        }

		/**
		 * ioerror - file does not exist
		 * @param	e
		 */
		private function _ioErrorHandler(e:IOErrorEvent):void 
		{
			_dispatchEvent(URLStream(e.target), false);
        }
		
		
		/**
		 * dispatch the respective event 
		 * @param	stream
		 * @param	exists
		 */
		private function _dispatchEvent(stream:URLStream, exists:Boolean):void
		{
			//get url and delet ref to loader
			var url:String = _loaderStore[stream];
			_loaderStore[url] = null;
			delete _loaderStore[url];
			//
			//dispatch event
			if(exists) this.dispatchEvent(new UtilEvent(UtilEvent.FILE_EXISTS, true, false, url));
			else this.dispatchEvent(new UtilEvent(UtilEvent.FILE_NOT_FOUND, true, false, url));
			//
			_removeListeners(stream);
		}
		
		 /**
		  * add listeners to dispather object
		  * @param	dispatcher
		  */
		private function _addListeners(dispatcher:IEventDispatcher):void 
		{
			dispatcher.addEventListener(ProgressEvent.PROGRESS, _progressHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
		}
		
		
		 /**
		  * remove listeners from dispatcher object
		  * @param	dispatcher
		  */
		private function _removeListeners(dispatcher:IEventDispatcher):void 
		{
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, _progressHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
		}
		
		/**
		 * clean up
		 */
		public function destroy():void
		{
			for each (var s:String in _loaderStore)
			{
				_loaderStore[s] = null;
				delete _loaderStore[s];
				s = null;
			}
			_loaderStore = null;
			//
			delete this;
		}
	}
}