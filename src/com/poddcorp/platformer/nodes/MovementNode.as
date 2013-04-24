package com.poddcorp.platformer.nodes
{
	import com.poddcorp.platformer.components.Motion;
	import com.poddcorp.platformer.components.Position;
	
	import ash.core.Node;
	
	public class MovementNode extends Node
	{
		public var position:Position;
		public var motion:Motion;
	}
}