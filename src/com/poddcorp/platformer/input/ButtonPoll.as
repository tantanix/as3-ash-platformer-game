package com.poddcorp.platformer.input 
{
	import flash.utils.getQualifiedClassName;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * ...
	 * @author Christian Noel C. Mascariñas
	 */
	public class ButtonPoll 
	{
		private var _displayObj:DisplayObject;
		
		public var leftPressed:Boolean = false;
		public var rightPressed:Boolean = false;
		public var jumpPressed:Boolean = false;
		
		public function ButtonPoll(displayObj:DisplayObject) 
		{
			_displayObj = displayObj;
			_displayObj.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(event:TouchEvent):void 
		{
			var touches:Vector.<Touch> = event.getTouches(_displayObj);
			
			// single touch
			if (touches.length == 1)
			{
				var touch:Touch = touches[0];
				var target:EventDispatcher = touch.target;
				var className:String = getQualifiedClassName(target);
				
				if (touch.phase == TouchPhase.BEGAN)
				{
					jumpPressed = (className == "com.poddcorp.platformer.ui::JumpButton");
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					jumpPressed = !(className == "com.poddcorp.platformer.ui::JumpButton");
				}
			}
			
		}
		
	}

}