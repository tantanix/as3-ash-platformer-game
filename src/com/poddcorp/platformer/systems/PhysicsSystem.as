package com.poddcorp.platformer.systems
{
	import com.poddcorp.platformer.EntityCreator;
	import com.poddcorp.platformer.GameConfig;
	import com.poddcorp.platformer.components.Motion;
	import com.poddcorp.platformer.components.Position;
	import com.poddcorp.platformer.nodes.PhysicsNode;
	import com.poddcorp.platformer.nodes.RenderNode;
	
	import flash.geom.Point;
	
	import ash.core.NodeList;
	import ash.core.System;
	
	import nape.phys.Body;
	import nape.space.Space;
	
	public class PhysicsSystem extends System
	{
		[Inject]
		public var config:GameConfig;
		
		[Inject]
		public var creator:EntityCreator;
		
		[Inject]
		public var space:Space;
		
		[Inject(nodeType="com.poddcorp.platformer.nodes.PhysicsNode")]
		public var physicsNodes:NodeList;
		
		[PostConstruct]
		public function setUpListeners() : void
		{
			physicsNodes.nodeRemoved.add( destroyBody );
		}
		
		private function destroyBody(node:PhysicsNode):void
		{
			space.bodies.remove(node.body);
		}
		
		override public function update(time:Number):void
		{
			for (var node:PhysicsNode = physicsNodes.head; node; node = node.next)
			{
				var body:Body = node.body;
				var position:Position = node.position;
				var motion:Motion = node.motion;
				
				position.position = new Point(body.position.x, body.position.y);
				position.rotation = body.rotation;
				motion.velocity = new Point(body.velocity.x, body.velocity.y);
			}
		}
	}
}