package com.poddcorp.platformer.components
{
	public class MotionControls
	{
		public var canDash:Boolean;
		public var canJump:Boolean;
		
		public function MotionControls(canDash:Boolean, canJump:Boolean)
		{
			this.canDash = canDash;
			this.canJump = canJump;
		}
	}
}