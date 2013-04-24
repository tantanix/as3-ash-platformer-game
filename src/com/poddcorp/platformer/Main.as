package com.poddcorp.platformer
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Christian Noel C. Mascariñas
	 */
	[SWF(width='600',height='450',frameRate='60',backgroundColor='#000000')]
	
	public class Main extends Sprite
	{
		private var _starlingApp:Starling;
		
		public function Main():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (stage.stageWidth && stage.stageHeight)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				stage.addEventListener(Event.DEACTIVATE, deactivate);
				
				Starling.multitouchEnabled = true;  // useful on mobile devices
				Starling.handleLostContext = false; // not necessary on iOS. Saves a lot of memory!
				
				// touch or gesture?
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				
				// entry point
				trace("Starting Mobile App");
				
				var viewPort:Rectangle =  new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
				if (viewPort.width == 768) // iPad 1+2
					viewPort.setTo(64, 32, 640, 960);
				else if (viewPort.width == 1536) // iPad 3
					viewPort.setTo(128, 64, 1280, 1920);
				
				
				_starlingApp = new Starling(PlatformGame, stage, viewPort);
				_starlingApp.simulateMultitouch = false;
				_starlingApp.enableErrorChecking = false;
				_starlingApp.antiAliasing = 0;
				_starlingApp.showStats = true;
				_starlingApp.start();
			}
		}
		
		private function deactivate(e:Event):void
		{
			
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
	
	}

}