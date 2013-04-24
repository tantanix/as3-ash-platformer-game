package com.poddcorp.platformer.components
{
	public class Platform
	{
		public static const MINIMUM_LENGTH:Number = 200;
		public var len:int;
		
		public function Platform(len:int)
		{
			this.len = len;
		}
	}
}