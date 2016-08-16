package
{
	import caurina.transitions.properties.CurveModifiers;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import GameBontempo.DefinesLoader;
	import flash.events.Event;
	
	/**
	 * Classe para o controle áudio no ActionScript 3.0.
	 *
	 * @author Mozart Petter
	 */
	public class SoundPlayer
	{
		
		/**
		 * @private
		 * Objeto Sound.
		 */
		private var _sound:Sound = null;
		
		/**
		 * @private
		 * Objeto Sound Channel.
		 */
		private var _schannel:SoundChannel = null;
		
		/**
		 * @private
		 * Indica se o audio esta parado ou nao.
		 */
		private var _paused:Boolean = false;
		
		/**
		 * @private
		 * Indica em qual posicao o audio foi parado.
		 */
		private var _position:Number = 0;
		
		/**
		 * @private
		 * Nome do arquivo a ser carregado
		 */
		private var _path:String;
		
		private var _fileName:String;
		private var _lastVol:Number = 0;
		
		var transform:SoundTransform;
		
		/**
		 * Construtor.
		 */
		public function SoundPlayer(path:String = null):void
		{
			_path = DefinesLoader.ASSETS_PATH+path;
			transform = new SoundTransform();
		}
		
		
		
		/**
		 * Pausa o áudio se estiver tocando, ou retoma a
		 * reprodução do ponto atual.
		 *
		 * @return void
		 */
		public function pause():void
		{
			// Se nao estiver pausado e _schannel estiver definida.  
			if (!this._paused && this._schannel)
			{
				trace("pause " + _path);
				// Armazena a posicao atual do audio.  
				this._position = this._schannel.position;
				
				// Para o audio.  
				this.stop();
				
				// Define _paused como true.  
				this._paused = true;
			}
			else
			{
				this.play(_path, this._position);
				trace("unpause " + _path);
				
				this._schannel.soundTransform = transform;
				
				this._paused = false;
			}
		}
		
		/**
		 * Inicia a reprodução da trilha.
		 *
		 * @param String path Caminho para o arquivo MP3.
		 * @return void
		 */
		public function play(path:String = null, startTime:Number = 0):void
		{
			
			// Se um audio ja estiver tocando.  
			//if (this._schannel) return;  
			
			try
			{
				if (this._schannel)
					stop();
					
				if (!path)
					return;
				
				if (path)
				{
					_path = DefinesLoader.ASSETS_PATH + path;
					_fileName = path;
				}
				
				trace("play " + _path);
				
				//trace("Playing sound: "+_path);
				
				// Objeto Sound.  
				this._sound = new Sound();
				
				// Carregando o audio de path.  
				this.load(_path);
				
				// Se o audio estiver pausado, define startTime  
				// com o valor de position.  
				if (this._paused)
					startTime = this._position;
				
				// Definindo o Sound Channel atual.  
				this._schannel = this._sound.play(startTime, 999);
				
				
				
				this._schannel.soundTransform = transform;
				
				// Sinalizando que o audio nao esta parado.  
				this._paused = false;
			}
			catch (e:Error)
			{
				trace("SoundPlayer Play Error:", e.toString());
			}
		}
		
		public function filePlaying(): String
		{
			return _fileName;
		}
	
		
		
		/**
		 * Para a reproducao do audio.
		 *
		 * @return void
		 */
		public function stop():void
		{
			// Se a musica estiver pausada e nao existir um Sound Channel  
			// o valor de position passa a ser 0.  
			if (this._paused && !this._schannel)
				this._position = 0;
			
			// Se existir um Sound Channel.  
			if (this._schannel)
			{
				// Para a execucao do som.  
				this._schannel.stop();
				
				// Apaga o canal existente.  
				this._schannel = null;
			}
		
			//trace("Stop sound: "+_path);
		}
		
		/**
		 * @private
		 * Carrega o arquivo especificado em path.
		 *
		 * @param String path Caminho para o arquivo MP3.
		 * @return void
		 */
		private function load(path:String):void
		{
			// URL do arquivo de audio.  
			var r:URLRequest = new URLRequest(path);
			
			// Carrega o arquivo de audio.  
			this._sound.load(r);
			
			this._sound.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		public function setVol(vol:Number):void
		{
			if (!_schannel) return;
			transform.volume = vol;
			this._schannel.soundTransform = transform;
		}
		
		
		public function getVol():Number
		{
			if (!_schannel) return 0;
			return transform.volume;
			
		}
		
		public function lowVol():void
		{
			if (!_schannel) return;
			_lastVol = this._schannel.soundTransform.volume;
			transform.volume = 0.2;
			this._schannel.soundTransform = transform;
		}
		
		public function normVol():void
		{
			if (!_schannel) return;
			transform.volume = 1.0;
			this._schannel.soundTransform = transform;
		}
		
		
		private function errorHandler(errorEvent:IOErrorEvent):void
		{
			trace("The sound could not be loaded: " + errorEvent.text);
		}
	
	}

}