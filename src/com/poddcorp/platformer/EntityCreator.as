package com.poddcorp.platformer
{
	import com.poddcorp.platformer.components.Display;
	import com.poddcorp.platformer.components.GameState;
	import com.poddcorp.platformer.components.Hero;
	import com.poddcorp.platformer.components.Motion;
	import com.poddcorp.platformer.components.MotionControls;
	import com.poddcorp.platformer.components.Platform;
	import com.poddcorp.platformer.components.Position;
	import com.poddcorp.platformer.views.BallView;
	import com.poddcorp.platformer.views.PlatformView;
	
	import ash.core.Engine;
	import ash.core.Entity;
	
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Christian Noel C. Mascariñas
	 */
	public class EntityCreator
	{
		[Inject]
		public var engine:Engine;
		
		[Inject]
		public var space:Space;
		
		[Inject]
		public var config:GameConfig;
		
		[Inject]
		public var container:DisplayObjectContainer
		
		
		public function destroyEntity(entity:Entity):void
		{
			engine.removeEntity(entity);
		}
		
		public function createGame():Entity
		{
			var game:Entity = new Entity()
				.add(new GameState());
			engine.addEntity(game);
			return game;
		}
		
		public function createHero():Entity
		{
			var body:Body = new Body(BodyType.DYNAMIC);
			body.shapes.add(new Circle(50, null, new Material(0, 0, 0)));
			body.position.setxy(100, config.height >> 1);
			body.velocity.setxy(0, 0);
			body.space = space;
			
			var hero:Entity = new Entity()
				.add(body)
				.add(new Hero())
				.add(new Position(body.position.x, body.position.y, 0, 0))
				.add(new Motion(body.velocity.x, body.velocity.y, 0, 0))
				.add(new MotionControls(true, true))
				.add(new Display(new BallView()));
			engine.addEntity(hero);
			return hero;
		}
		
		public function createPlatform(len:int = 1, posX:Number = 0, posY:Number = 0, velocityX:Number = 0):Entity
		{
			var body:Body = new Body(BodyType.KINEMATIC)
			body.shapes.add(new Polygon(Polygon.rect(0, 0, Platform.MINIMUM_LENGTH * len, 100)));
			body.position.setxy(posX, posY);
			body.velocity.setxy(velocityX, 0);
			body.space = space;
			
			var platform:Entity = new Entity()
				.add(body)
				.add(new Platform(len))
				.add(new Position(body.position.x, body.position.y, 0, 0))
				.add(new Motion(body.velocity.x, body.velocity.y, 0, 0))
				.add(new MotionControls(true, false))
				.add(new Display(new PlatformView(len)));
			
			engine.addEntity(platform);
			return platform;
		}	
		
	}

}