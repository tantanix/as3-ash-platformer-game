package com.poddcorp.platformer.ui 
{
	import feathers.controls.Button;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Christian Noel C. Mascariñas
	 */
	public class RightButton extends Button 
	{
		public function RightButton() 
		{
			this.defaultSkin = createDefaultSkin();
		}
		
		private function createDefaultSkin():Image
		{
			const RADIUS:Number = 80;
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x4A9315);
			shape.graphics.drawCircle(0, 0, RADIUS);
			shape.graphics.endFill();
			
			var bmd:BitmapData = new BitmapData(RADIUS * 2, RADIUS * 2, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.tx = RADIUS;
			matrix.ty = RADIUS;
			bmd.draw(shape, matrix, null, null, null, true);
			
			this.pivotX = RADIUS;
			this.pivotY = RADIUS;
			
			return new Image(Texture.fromBitmapData(bmd));
		}
	}

}