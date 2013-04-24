package com.poddcorp.platformer.systems
{
	import com.poddcorp.platformer.EntityCreator;
	import com.poddcorp.platformer.GameConfig;
	import com.poddcorp.platformer.components.Platform;
	import com.poddcorp.platformer.components.Position;
	import com.poddcorp.platformer.nodes.GameNode;
	import com.poddcorp.platformer.nodes.PhysicsNode;
	import com.poddcorp.platformer.nodes.PlatformAgeNode;
	
	import ash.core.NodeList;
	import ash.core.System;
	
	import nape.phys.Body;
	
	public class GameSystem extends System
	{
		[Inject]
		public var config:GameConfig;
		
		[Inject]
		public var creator:EntityCreator;
		
		[Inject(nodeType="com.poddcorp.platformer.nodes.GameNode")]
		public var gameNodes:NodeList;
		
		[Inject(nodeType="com.poddcorp.platformer.nodes.PlatformAgeNode")]
		public var platformNodes:NodeList; 
		
		[Inject(nodeType="com.poddcorp.platformer.nodes.PhysicsNode")]
		public var physicsNodes:NodeList;
		
		override public function update(time:Number):void
		{
			
			var gameNode:GameNode;
			for (gameNode = gameNodes.head; gameNode; gameNode = gameNode.next)
			{
				// Destroy platform if it is out of the stage
				var platformNode:PlatformAgeNode;
				var rightEdgeX:Number
				for (platformNode = platformNodes.head; platformNode; platformNode = platformNode.next)
				{
					rightEdgeX = platformNode.position.position.x + (Platform.MINIMUM_LENGTH * platformNode.platform.len);
					if (rightEdgeX < 0)
					{
						creator.destroyEntity(platformNode.entity);
					}
				}
				
				// If the last platform is visible on stage, create a new platform
				var lastPlatform:PlatformAgeNode = platformNodes.tail;
				if (lastPlatform) 
				{
					var platform:Platform = lastPlatform.platform;
					var platformPosition:Position = lastPlatform.position;
					rightEdgeX = platformPosition.position.x + (Platform.MINIMUM_LENGTH * platform.len);
					if (platformPosition.position.x < config.width)
					{
						creator.createPlatform(Math.ceil(Math.random() * 5), rightEdgeX + 300, config.height - 300, -400 - (gameNode.state.savePoints * 100));
					}
				}
				
				// Initial state of the game
				if (gameNode.state.lives == 3)
				{
					creator.createHero();
					gameNode.state.lives--;
					
					if (platformNodes.empty)
					{
						creator.createPlatform(10, 0, config.height - 300, -400 - (gameNode.state.savePoints * 100));
					}
				}
				
				// Increase velocity for every 1000 distance covered
				var distanceCovered:Number = gameNode.state.distanceCovered;
				if (distanceCovered != 0 && distanceCovered % 1000 == 0)
				{
					gameNode.state.savePoints++;
					
					var physicsNode:PhysicsNode;
					var body:Body;
					for (physicsNode = physicsNodes.head; physicsNode; physicsNode = physicsNode.next)
					{
						body = physicsNode.body;
						if (body.velocity.x != 0)
						{
							body.velocity.x = -400 - (gameNode.state.savePoints * 100);
						}
					}
				}
				
				gameNode.state.distanceCovered++;
				
			}
			
		}
		
	}
	
}