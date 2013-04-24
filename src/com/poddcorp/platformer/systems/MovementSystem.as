package com.poddcorp.platformer.systems
{
	import com.poddcorp.platformer.components.Motion;
	import com.poddcorp.platformer.components.Position;
	import com.poddcorp.platformer.nodes.MovementNode;
	
	import ash.core.NodeList;
	import ash.core.System;
	
	public class MovementSystem extends System
	{
		[Inject(nodeType="com.poddcorp.platformer.nodes.MovementNode")]
		public var movementNodes:NodeList;
		
		override public function update(time:Number):void
		{
			var node:MovementNode;
			var position:Position;
			var motion:Motion;
			for (node = movementNodes.head; node; node = node.next)
			{
				position = node.position;
				motion = node.motion;
				
				position.position.x += motion.velocity.x * time;
				position.position.y += motion.velocity.y * time;
				
			}
		}
		
	}
}