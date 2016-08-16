package GameBontempo
{
	import flash.utils.*;
	import com.transcendingdigital.time.ntpTimeUtility;
	import flash.events.Event;
	import flash.display.Sprite;
	
	public class Util extends Sprite
	{
		
		private var ntpTime:ntpTimeUtility;
		private var dateObj:Date = new Date();
		
		public static function randRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public static function extractDate(d:String):String
		{
			var ret:String;
			var AAAA:String;
			var MM:String;
			var DD:String;
			ret = d.substr(0, 8);
			AAAA = ret.substr(0, 4);
			MM = ret.substr(4, 2);
			DD = ret.substr(6, 2);
			
			return( new String(DD + "/" + MM + "/" + AAAA));
			
		}
		
		public static function extractHour(d:String):String
		{
			var ret:String;
			var HH:String;
			var MM:String;
			var SS:String;
			ret = d.substr(9, 6);
			HH = ret.substr(0, 2);
			MM = ret.substr(2, 2);
			SS = ret.substr(4, 2);
			
			return( new String(HH + ":" + MM + ":" + SS));
			
		}
		
		private function getYYMMDD():String
		{
			
			var year:String = String(dateObj.getFullYear());
			var month:String = String(dateObj.getMonth() + 1);
			if (month.length == 1)
			{
				month = "0" + month;
			}
			var date:String = String(dateObj.getDate());
			if (date.length == 1)
			{
				date = "0" + date;
			}
			return year + month + date;
		}
		
		private  function getHHMMSS():String
		{
			
			var hour:String = String(dateObj.getHours());
			var min:String = String(dateObj.getMinutes());
			var seg:String = String(dateObj.getSeconds());
			
			if (hour.length == 1)
			{
				hour = "0" + hour;
			}
			if (min.length == 1)
			{
				min = "0" + min;
			}
			if (seg.length == 1)
			{
				seg = "0" + seg;
			}
			return hour + min + seg;
		}
		
		public function getDateString(local:Boolean=true):String
		{
			if (local) requestLocalTime();
			var str = getYYMMDD() + "_" + getHHMMSS();
			trace(str);
			return str;
		}
		
		public function calculeTime(initDate:String ):Number //20130605_180555
		{
			var endDate:String = getDateString();
			var iniH:Number = Number(initDate.substr(9, 2));
			var iniM:Number = Number(initDate.substr(11, 2));
			var iniS:Number = Number(initDate.substr(13, 2));
			
			var endH:Number = Number(endDate.substr(9, 2));
			var endM:Number = Number(endDate.substr(11, 2));
			var endS:Number = Number(endDate.substr(13, 2));
			
			
			trace(initDate.substr(9, 2));
			trace(initDate.substr(11, 2))
			trace(initDate.substr(13, 2))
			
			trace(endDate.substr(9, 2));
			trace(endDate.substr(11, 2));
			trace(endDate.substr(13, 2));
			
			trace("Ini Hora " + iniH + " Min " + iniM + " S " + iniS);
			trace("End Hora " + endH + " Min " + endM + " S " + endS);
			
			var totSeg = ((endH - iniH) * 3600 + (endM - iniM) * 60 + (endS - iniS));
			var str:String = String(totSeg);
			trace(" Tempo" + str);
			
			return totSeg;
		}
		
		
		public function requestLocalTime():void { //padrao pega hora local
			dateObj = new Date();
			trace("Getting Local date/Time ", dateObj);
		}
		
		
		public function requestNTPTime():void { //padrao pega hora local
			trace("Doing NTP Request: ");
			createNtpTimeUtility();
			ntpTime.initiateUDPTimeRequest();
		}
		
		private function createNtpTimeUtility():void {
			if(ntpTime == null) {
				ntpTime = new ntpTimeUtility();
				ntpTime.addEventListener(ntpTimeUtility.NTP_TIME_RECIEVED, handleNTPTime, false, 0, true);
				ntpTime.addEventListener(ntpTimeUtility.NTP_TIMEOUT, handleNtpTimeError, false, 0, true);
			} else {
				destroyNtpTimeUtility(true);
			}
		}
		private function destroyNtpTimeUtility(_OptionalCallback:Boolean = false):void {
			if(ntpTime != null) {
				ntpTime.removeEventListener(ntpTimeUtility.NTP_TIME_RECIEVED, handleNTPTime);
				ntpTime.removeEventListener(ntpTimeUtility.NTP_TIMEOUT, handleNtpTimeError);
				ntpTime.destroyInternals();
				ntpTime = null;
				if(_OptionalCallback == true) {
					createNtpTimeUtility();
				}
			}
		}
				
		private function handleNTPTime(e:Event):void {
			// The time returned from the time server which should be localized
			// to the computers clock is in the ntpTIme.latestNTPTime variable
			trace("Getting Global ntp time utility return: " + ntpTime.latestNTPTime);
			dateObj = ntpTime.latestNTPTime;
			destroyNtpTimeUtility();
			dispatchEvent(new NTPEvents(NTPEvents.ON_SUCESS));
		}
		private function handleNtpTimeError(e:Event):void {
			// Do what you would do here if the time cant be retrieved.
			dispatchEvent(new NTPEvents(NTPEvents.ON_EROOR));
			trace("Getting Global ntp time error: ", e.toString());
			dateObj = new Date();
			destroyNtpTimeUtility(true);
		}
	}

}