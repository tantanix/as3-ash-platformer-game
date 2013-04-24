package com.poddcorp.platformer.views
{
	import com.poddcorp.platformer.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class PlatformView extends Sprite
	{
		private var _len:int;
		private var _platformTexture:Texture;
		private var _edgeTexture:Texture;
		
		public function PlatformView(len:int)
		{
			super();
			_len = len;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createTextures();
			createPlatform();
			
			this.pivotX = 0;
			this.pivotY = 0;
			this.flatten();
			this.touchable = false;
		}
		
		private function createPlatform():void
		{
			// Create the left edge
			var leftEdge:Image = new Image(_edgeTexture);
			leftEdge.x = 0;
			leftEdge.y = 0;
			addChild(leftEdge);
			
			// Create the body of the platform
			var offsetX:Number = leftEdge.x + leftEdge.width - 1; // -1 here is the extra 1 pixel space
			for (var i:int = 0; i < _len; i++) 
			{
				var platformImage:Image = new Image(_platformTexture);
				addChild(platformImage);
				platformImage.x = offsetX;
				platformImage.y = 0;
				
				offsetX = platformImage.x + platformImage.width - 1; // -1 here is the extra 1 pixel space
			}
			
			// Create right edge using same texture...just flip the image
			var rightEdge:Image = new Image(_edgeTexture);
			rightEdge.pivotX = rightEdge.width;
			rightEdge.scaleX = -1;
			rightEdge.x = offsetX;
			rightEdge.y = 0;
			addChild(rightEdge);
		}
		
		private function createTextures():void
		{
			_platformTexture = Assets.getAtlas().getTexture("platform1");
			_edgeTexture = Assets.getAtlas().getTexture("platform1_edge1");
		}
		
	}
}