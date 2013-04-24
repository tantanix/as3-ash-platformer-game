package com.poddcorp.platformer.ui
{
	import com.poddcorp.platformer.Assets;
	
	import feathers.controls.Button;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class JumpButton extends Button
	{
		public function JumpButton()
		{
			super();
			this.defaultSkin = createDefaultSkin();
			this.hoverSkin = createHoverSkin();
		}
		
		private function createDefaultSkin():Image
		{
			var texture:Texture = Assets.getAtlas().getTexture("btn_jump");
			return new Image(texture);
		}
		
		private function createHoverSkin():Image
		{
			var texture:Texture = Assets.getAtlas().getTexture("btn_jump_hover");
			return new Image(texture);
		}
	}
}