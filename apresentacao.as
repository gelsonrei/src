package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class apresentacao extends MovieClip
	{
		public var timer:Timer = new Timer(30000,1); //seg*1000
				
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			TweenLite.to(maska, 1, {alpha: 0});
			
			esq.buttonMode = true;
			dir.buttonMode = true;
			
			esq.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			dir.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			esq.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			dir.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			esq.addEventListener(MouseEvent.CLICK, onClick);
			dir.addEventListener(MouseEvent.CLICK, onClick);
			esq.addEventListener(Event.ENTER_FRAME, testaEnable);
			dir.addEventListener(Event.ENTER_FRAME, testaEnable);
			timer.addEventListener(TimerEvent.TIMER, timesUP);
			
			esq.alpha = 0.2;
			dir.alpha = 0.2;
			
			ativaTimer();
			
			
		}
		
		private function ativaTimer()
		{
			timer.start();
		}
		
		public function timesUP(event:TimerEvent)
			{
				
				nextFrame();
				tweenMask();
				ativaTimer();
			}
		
		public function testaEnable(e:Event)
		{
			if (currentFrame == 1)
			{
				esq.buttonMode = false;
				esq.visible = false;
				
			}
			else if (currentFrame == totalFrames)
			{
				dir.buttonMode = false;
				dir.visible = false;
			}
			else
			{
				esq.buttonMode = true;
				dir.buttonMode = true;
				esq.visible = true;
				dir.visible = true;
			}
		}
		
		public function tweenMask()
		{
			maska.alpha = 1;
			TweenLite.to(maska, 1, {alpha: 0});
		}
		
		public function onOver(e:MouseEvent)
		{
			TweenLite.to(e.target, 0.5, {alpha: 1.0});
		}
		
		public function onOut(e:MouseEvent)
		{
			TweenLite.to(e.target, 0.5, {alpha: 0.2});
		}
		
		public function onClick(e:MouseEvent)
		{
			ativaTimer();
			if (e.target == esq && currentFrame - 1 != 0)
			{
				prevFrame();
				tweenMask();
			}
			else if (e.target == dir && currentFrame != totalFrames)
			{
				nextFrame();
				tweenMask();
			}
		}
		
		//CONSTRUCTOR FUNCTION. Todo código aqui dentro rodará assim que a classe for iniciada.
		public function apresentacao()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
}