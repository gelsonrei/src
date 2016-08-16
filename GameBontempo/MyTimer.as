package GameBontempo 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import GameBontempo.MyTimerEvents;
	import flash.display.Sprite;
	
	
	public class MyTimer extends Sprite  
	{
		
		private var timer:Timer;
		private var idleTime:int;
		private var myTimerEvt:MyTimerEvents;
		public var isAtive:Boolean = false;
		public var maxIdleTimer:int = 25;
		
		public function init(interval:Number=1000,maxIdle:Number=25):void
		{
			timer = new Timer(interval);
			idleTime = 0;
			maxIdleTimer = maxIdle;
			isAtive = false;
			timer.addEventListener(TimerEvent.TIMER, tick);
		}

		
		public function running():Boolean
		{
			return timer.running;
		}
		
		public function start():void
		{
			timer.start();
			isAtive = timer.running;
		}
		
		public function stop():void
		{
			timer.stop();
			isAtive = timer.running;
		}
		
		public function reset(val:int=0)
		{
			idleTime = val;
			start();
		}
	
		
		private function tick(evt:TimerEvent=null):void
		{
			if (!isAtive)
			   return;
			
			idleTime += 1; 	
			trace("Idle Timer: " + idleTime)
			if (idleTime > maxIdleTimer)//  && DlgState.ATUAL == DlgState.IDLE)
			{
				
				myTimerEvt = new MyTimerEvents("onIdleReached");
				myTimerEvt.customMessage = "Max Idle Timer Reached";
				dispatchEvent(myTimerEvt);
				
				timer.stop();
			}
		}
		
		
		public function MyTimer() 
		{
			
		}
		
	}

}