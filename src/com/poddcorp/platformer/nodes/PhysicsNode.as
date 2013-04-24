package com.poddcorp.platformer.nodes
{
	import com.poddcorp.platformer.components.Motion;
	import com.poddcorp.platformer.components.Position;
	
	import ash.core.Node;
	
	import nape.phys.Body;
	
	public class PhysicsNode extends Node
	{
		public var body:Body;
		public var position:Position;
		public var motion:Motion;
	}
}