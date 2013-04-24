package com.poddcorp.platformer.views
{
	import com.poddcorp.platformer.Assets;
	
	import starling.display.Image;
	
	public class BallView extends Image
	{
		public function BallView()
		{
			super(Assets.getAtlas().getTexture("100px-basketball"));
			this.pivotX = Math.ceil(this.width >> 1);
			this.pivotY = Math.ceil(this.height >> 1);
			this.touchable = false;
		}
	}
}