package com.poddcorp.platformer.components
{
	public class GameState
	{
		public var distanceCovered:Number;
		public var speed:Number;
		public var savePoints:int;
		public var lives:int;
		
		public function GameState()
		{
			distanceCovered = 0;
			speed = 1;
			savePoints = 0;
			lives = 3;
		}
	}
}