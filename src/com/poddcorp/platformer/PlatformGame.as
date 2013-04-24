package com.poddcorp.platformer
{
	import com.poddcorp.platformer.input.ButtonPoll;
	import com.poddcorp.platformer.systems.GameSystem;
	import com.poddcorp.platformer.systems.MotionControlSystem;
	import com.poddcorp.platformer.systems.MovementSystem;
	import com.poddcorp.platformer.systems.PhysicsSystem;
	import com.poddcorp.platformer.systems.RenderSystem;
	import com.poddcorp.platformer.systems.SystemPriorities;
	import com.poddcorp.platformer.ui.JumpButton;
	
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	import ash.core.Engine;
	import ash.integration.starling.StarlingFrameTickProvider;
	import ash.integration.swiftsuspenders.SwiftSuspendersEngine;
	
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	
	import org.swiftsuspenders.Injector;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Christian Noel C. Mascariñas
	 */
	public class PlatformGame extends Sprite 
	{
		private const JOYSTICK_PADDING:Number = 100;
		
		private var _engine:Engine;
		private var _injector:Injector;
		private var _config:GameConfig;
		private var _tickProvider:StarlingFrameTickProvider;
		private var _buttonPoll:ButtonPoll;
		private var _space:Space;
		private var _debug:BitmapDebug;
		private var _jumpButton:JumpButton;
		
		public function PlatformGame() 
		{	
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			prepare();
			createUI();
			start();
		}
		
		private function prepare():void 
		{
			_injector = new Injector();
			_engine = new SwiftSuspendersEngine(_injector);
			_buttonPoll = new ButtonPoll(this);
			
			_injector.map(Engine).toValue(_engine);
			_injector.map(DisplayObjectContainer).toValue(this);
			_injector.map(GameConfig).asSingleton();
			_injector.map(EntityCreator).asSingleton();
			_injector.map(ButtonPoll).toValue(_buttonPoll);
			_injector.map(Space).asSingleton();
			
			_config = _injector.getInstance(GameConfig);
			var viewPort:Rectangle = Starling.current.viewPort;
			_config.width = viewPort.width;
			_config.height = viewPort.height;
			
			// Add the systems to operate on the nodes
			_engine.addSystem(new GameSystem(), SystemPriorities.GAME);
			_engine.addSystem(new PhysicsSystem(), SystemPriorities.PHYSICS);
			_engine.addSystem(new MotionControlSystem(), SystemPriorities.CONTROL);
			_engine.addSystem(new MovementSystem(), SystemPriorities.UPDATE);
			_engine.addSystem(new RenderSystem(), SystemPriorities.RENDER);
			
			// Create the Nape Space object
			_space = _injector.getInstance(Space);
			_space.gravity = new Vec2(0, 3000);
			_space.worldLinearDrag = 0;
			_space.worldAngularDrag = 0;
			
//			_debug = new BitmapDebug(config.width, config.height, 0x000000);
//			Starling.current.nativeStage.addChild(_debug.display);
			
			// Create the game
			var creator:EntityCreator = _injector.getInstance(EntityCreator);
			creator.createGame();
		}
		
		private function createUI():void
		{
			_jumpButton = new JumpButton();
			addChild(_jumpButton);
			
			_jumpButton.x = _config.width - 150;
			_jumpButton.y = _config.height - 150;
			
		}
		
		private function start():void 
		{
			_tickProvider = new StarlingFrameTickProvider(Starling.current.juggler);
			_tickProvider.add(_engine.update);
			_tickProvider.add(updatePhysics);
			_tickProvider.start();
		}
		
		private function updatePhysics(time:Number):void
		{
			_space.step(time);
			
//			_debug.clear();
//			_debug.draw(_space);
//			_debug.flush();
		}
	}
}