package com.poddcorp.platformer.nodes
{
	import com.poddcorp.platformer.components.MotionControls;
	
	import ash.core.Node;
	
	import nape.phys.Body;
	
	public class MotionControlNode extends Node
	{
		public var controls:MotionControls;
		public var body:Body;
	}
}