package com.poddcorp.platformer.systems
{
	import com.poddcorp.platformer.GameConfig;
	import com.poddcorp.platformer.components.Position;
	import com.poddcorp.platformer.nodes.RenderNode;
	
	import ash.core.NodeList;
	import ash.core.System;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	public class RenderSystem extends System
	{
		[Inject]
		public var config:GameConfig;
		
		[Inject]
		public var container:DisplayObjectContainer;
		
		[Inject(nodeType="com.poddcorp.platformer.nodes.RenderNode")]
		public var renderNodes:NodeList;
		
		[PostConstruct]
		public function setUpListeners() : void
		{
			for(var node:RenderNode = renderNodes.head; node; node = node.next)
			{
				addToDisplay( node );
			}
			renderNodes.nodeAdded.add( addToDisplay );
			renderNodes.nodeRemoved.add( removeFromDisplay );
		}
		
		private function addToDisplay(node:RenderNode):void
		{
			container.addChild(node.display.displayObject);
		}
		
		private function removeFromDisplay(node:RenderNode):void
		{
			container.removeChild(node.display.displayObject);
		}
		
		override public function update(time:Number):void
		{
			var node:RenderNode;
			var position:Position;
			var displayObject:DisplayObject;
			
			for (node = renderNodes.head; node; node = node.next)
			{
				position = node.position;
				displayObject = node.display.displayObject;
				
				displayObject.x = position.position.x;
				displayObject.y = position.position.y;
				displayObject.rotation = position.rotation;
			}
			 
		}
		
	}
}