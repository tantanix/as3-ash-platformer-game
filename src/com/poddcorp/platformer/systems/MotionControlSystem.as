package com.poddcorp.platformer.systems
{
	import com.poddcorp.platformer.input.ButtonPoll;
	import com.poddcorp.platformer.nodes.MotionControlNode;
	
	import ash.core.NodeList;
	import ash.core.System;
	
	import nape.phys.Body;
	
	public class MotionControlSystem extends System
	{
		[Inject]
		public var buttonPoll:ButtonPoll;
		
		[Inject(nodeType="com.poddcorp.platformer.nodes.MotionControlNode"]
		public var motionControlNodes:NodeList;
		
		override public function update(time:Number):void
		{
			var node:MotionControlNode;
			var body:Body;
			
			for (node = motionControlNodes.head; node; node = node.next)
			{
				body = node.body;
				if (node.controls.canJump)
				{
					if (buttonPoll.jumpPressed)
					{
						if (body.position.y > 100)
						{
							body.velocity.y = -800;
						}
					}
				}
			}
			
		}
		
	}
}