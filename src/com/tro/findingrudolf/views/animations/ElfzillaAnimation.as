package com.tro.findingrudolf.views.animations
{

	import com.tro.findingrudolf.events.ElfzillaEvent;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.deg2rad;

	/**
	 * ...
	 * @author Andrew Day
	 */
	public class ElfzillaAnimation extends Sprite 
	{
		private var elfBodyTexture:Texture;
		private var leftArmTexture:Texture;
		private var rightArmTexture:Texture;
		private var head01Texture:Texture;
		private var head02Texture:Texture;
		private var guide01Texture:Texture;
		private var guide02Texture:Texture;
		
		private var elfBody:Image;
		private var leftArmVector:Vector.<Texture>;
		private var leftArm:MovieClip;
		private var rightArm:Image;
		private var head01:Image;
		private var head02:Image;
		
		private var currentX:int;
		private var currentY:int;
		
		private var animationContainer:Sprite;
		private var startingX:int;
		private var startingY:int;
		
		private const ease:String = Transitions.EASE_IN;
		private const stepTime:int = 2;
		
		public function ElfzillaAnimation(elfBodyTexture:Texture, leftArmVector:Vector.<Texture>, rightArmTexture:Texture, head01Texture:Texture, head02Texture:Texture) 
		{
			this.elfBodyTexture = elfBodyTexture;
			this.leftArmVector = leftArmVector;
			this.rightArmTexture = rightArmTexture;
			this.head01Texture = head01Texture;
			this.head02Texture = head02Texture;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init); 
		}
		
		private function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init); 
			
			animationContainer = new Sprite();
			
			animationContainer.x = stage.stageWidth / 2;
			animationContainer.y = stage.stageHeight / 2;
			
			elfBody = new Image(elfBodyTexture);
			elfBody.pivotY = elfBody.height;
			elfBody.pivotX = elfBody.width / 2;
			elfBody.y = elfBody.height/2;
			elfBody.x = 0;
			animationContainer.addChild(elfBody);
			
			head01 = new Image(head01Texture);
			head01.alignPivot();
			head01.pivotX = head01.width / 2;
			head01.pivotY = head01.height - 20;
			head01.y = -620 + head01.height / 2 - 20;
			head01.x = 30;
			head01.visible = false;
			
			animationContainer.addChild(head01);
			
			head02 = new Image(head02Texture);
			head02.alignPivot();
			head02.pivotX = head02.width / 2;
			head02.pivotY = head02.height - 20;
			head02.x = 30;
			head02.y = -620 + head02.height / 2 - 20;
			head02.visible = true;
			animationContainer.addChild(head02);
			
			leftArm = new MovieClip(leftArmVector, 24);
			leftArm.pause();
			leftArm.pivotX = 323;
			leftArm.pivotY = 91;
			leftArm.x = -40;
			leftArm.y = -285;
			leftArm.rotation = deg2rad(20);
			animationContainer.addChild(leftArm);
			
			rightArm = new Image(rightArmTexture);
			rightArm.x = 40;
			rightArm.y = -300;
			rightArm.pivotX = 35;
			rightArm.pivotY = 35;
			animationContainer.addChild(rightArm);
			
			startingX = stage.stageWidth / 2 + 350;
			startingY = stage.stageHeight + 500;
			
			animationContainer.alignPivot();
			animationContainer.pivotY = animationContainer.height;
			
			animationContainer.scale = 0.8;
			animationContainer.x = startingX;
			animationContainer.y = startingY;
			
			addChild(animationContainer);
		}
		
		public function animate():void
		{
			animateToWave();
			
			var evt:ElfzillaEvent = new ElfzillaEvent(ElfzillaEvent.ANIMATION_START);
			dispatchEvent(evt);
		}
		
		private function animateToWave():void
		{
			leftArm.currentFrame = 1;
			
			walkingStateTwo(true);
			
			animationContainer.scale = 0.8;
			
			var stepOne:Tween = new Tween(animationContainer, stepTime, ease);
			stepOne.moveTo(startingX - 50, startingY - 100);
			stepOne.onComplete = stepTwo;
			
			Starling.juggler.add(stepOne);
		}
		
		private function stepTwo():void
		{
			walkingStateOne(true);
			
			var stepTwo:Tween = new Tween(animationContainer, stepTime, ease);
			stepTwo.moveTo(animationContainer.x + 100, animationContainer.y - 100);
			stepTwo.scaleTo(0.85);
			stepTwo.onComplete = stepThree;
			
			Starling.juggler.add(stepTwo);
		}
		
		private function stepThree():void
		{
			walkingStateTwo(true);
			
			var stepThree:Tween = new Tween(animationContainer, stepTime, ease);
			stepThree.moveTo(animationContainer.x - 100, animationContainer.y - 100);
			stepThree.scaleTo(0.9);
			stepThree.onComplete = stepFour;
			
			Starling.juggler.add(stepThree);
		}
		
		private function stepFour():void
		{
			walkingStateOne(true);
			
			var stepFour:Tween = new Tween(animationContainer, stepTime, ease);
			stepFour.moveTo(animationContainer.x + 100, animationContainer.y - 100);
			stepFour.scaleTo(0.95);
			stepFour.onComplete = stepFive;
			
			Starling.juggler.add(stepFour);
		}
		
		private function stepFive():void
		{
			walkingStateTwo(true);
			
			var stepFive:Tween = new Tween(animationContainer, stepTime, ease);
			stepFive.moveTo(animationContainer.x - 50, animationContainer.y - 100);
			stepFive.scaleTo(1);
			stepFive.onComplete = waveState;
			
			Starling.juggler.add(stepFive);
		}
		
		private function stepBackOne():void
		{
			walkingStateOne(false);
			leftArm.pause();
			//head01.visible = false;
			//head02.visible = true;
			
			var stepFive:Tween = new Tween(animationContainer, stepTime, ease);
			stepFive.scaleTo(0.95);
			stepFive.moveTo(animationContainer.x - 100, animationContainer.y + 100);
			
			stepFive.onComplete = stepBackTwo;
			
			Starling.juggler.add(stepFive);
		}
		
		private function stepBackTwo():void
		{
			walkingStateTwo(true);
			
			var stepFour:Tween = new Tween(animationContainer, stepTime, ease);
			stepFour.moveTo(animationContainer.x + 100, animationContainer.y + 100);
			stepFour.scaleTo(0.9);
			stepFour.onComplete = stepBackThree;
			
			Starling.juggler.add(stepFour);
		}
		
		private function stepBackThree():void
		{
			walkingStateOne(true);
			
			var stepThree:Tween = new Tween(animationContainer, stepTime, ease);
			stepThree.moveTo(animationContainer.x - 100, animationContainer.y + 100);
			stepThree.scaleTo(0.85);
			stepThree.onComplete = stepBackFour;
			
			Starling.juggler.add(stepThree);
		}
		
		private function stepBackFour():void
		{
			walkingStateTwo(true);
			
			var stepTwo:Tween = new Tween(animationContainer, stepTime, ease);
			stepTwo.moveTo(animationContainer.x + 50, animationContainer.y + 100);
			stepTwo.scaleTo(0.80);
			stepTwo.onComplete = stepBackFive;
			
			Starling.juggler.add(stepTwo);
		}
		
		private function stepBackFive():void
		{
			walkingStateOne(true);
			
			var stepOne:Tween = new Tween(animationContainer, stepTime, ease);
			stepOne.moveTo(startingX, startingY);
			stepOne.onComplete = cleanup;
			
			Starling.juggler.add(stepOne);
		}
		
		private function cleanup():void
		{
			dispatchEvent(new ElfzillaEvent(ElfzillaEvent.ANIMATION_COMPLETE));
			
			Starling.juggler.removeTweens(animationContainer); 
			Starling.juggler.removeTweens(leftArm); 
			Starling.juggler.removeTweens(rightArm);
		}
		
		private function walkingStateOne(step:Boolean):void
		{
			if (step)
			{
				var evt:ElfzillaEvent = new ElfzillaEvent(ElfzillaEvent.FOOT_STEP);
				dispatchEvent(evt);
			}
			
			Starling.juggler.removeTweens(leftArm);
			Starling.juggler.removeTweens(rightArm);
			
			var leftArmTween:Tween = new Tween(leftArm, 3, Transitions.EASE_IN_OUT);
			leftArmTween.animate("rotation", deg2rad( 30));
			
			var rightArmTween:Tween = new Tween(rightArm, 3, Transitions.EASE_IN_OUT);
			rightArmTween.animate("rotation", deg2rad( 30));
			
			var headTween:Tween = new Tween(head02, 0.3, Transitions.EASE_IN_OUT);
			headTween.animate("rotation", deg2rad( 2));
			headTween.delay = 1.9;
			
			var bodyTween:Tween = new Tween(animationContainer, 0.3, Transitions.EASE_IN_OUT);
			bodyTween.animate("rotation", deg2rad( 0.3));
			bodyTween.delay = 1.9;
			
			Starling.juggler.add(bodyTween);
			Starling.juggler.add(headTween);
			Starling.juggler.add(leftArmTween);
			Starling.juggler.add(rightArmTween);
		}
		
		private function walkingStateTwo(step:Boolean):void
		{	
			if (step)
			{
				var evt:ElfzillaEvent = new ElfzillaEvent(ElfzillaEvent.FOOT_STEP);
				dispatchEvent(evt);
			}
			
			Starling.juggler.removeTweens(leftArm);
			Starling.juggler.removeTweens(rightArm);
			
			var leftArmTween:Tween = new Tween(leftArm, 3, Transitions.EASE_IN_OUT);
			leftArmTween.animate("rotation", deg2rad( 0));
			
			var rightArmTween:Tween = new Tween(rightArm, 3, Transitions.EASE_IN_OUT);
			rightArmTween.animate("rotation", deg2rad( 0));
			
			var headTween:Tween = new Tween(head02, 0.3, Transitions.EASE_IN_OUT);
			headTween.animate("rotation", deg2rad( -2));
			headTween.delay = 1.9;
			
			var bodyTween:Tween = new Tween(animationContainer, 0.3, Transitions.EASE_IN_OUT);
			bodyTween.animate("rotation", deg2rad( -0.3));
			bodyTween.delay = 1.9;
			
			Starling.juggler.add(bodyTween);
			Starling.juggler.add(headTween);
			Starling.juggler.add(leftArmTween);
			Starling.juggler.add(rightArmTween);
		}
		
		public function waveState():void
		{
			var evt:ElfzillaEvent = new ElfzillaEvent(ElfzillaEvent.FOOT_STEP);
			dispatchEvent(evt);
			
			head01.visible = true;
			head02.visible = false;
			
			var leftArmTweenOne:Tween = new Tween(leftArm, 2, Transitions.EASE_IN_OUT);
			leftArmTweenOne.rotateTo(deg2rad( 45));
			
			
			leftArmTweenOne.onComplete = function():void { 
				
				
				
			};
			leftArm.play();
			
			//Starling.juggler.add(leftArmTweenOne);
			
			var leftArmTweenTwo:Tween = new Tween(leftArm, 2, Transitions.EASE_IN_OUT);
			leftArmTweenTwo.rotateTo(deg2rad( 5));
			leftArmTweenTwo.repeatCount = 6;
			leftArmTweenTwo.reverse = true;
			
			var rightArmTween:Tween = new Tween(rightArm, 2, Transitions.EASE_IN_OUT);
			rightArmTween.rotateTo(deg2rad( 20));
			
			var animationTween:Tween = new Tween(animationContainer, 2, Transitions.EASE_IN_OUT);
			animationTween.rotateTo(deg2rad( -1));
			animationTween.repeatCount = 6;
			animationTween.reverse = true;
			animationTween.onComplete = stepBackOne;
			
			var headTween:Tween = new Tween(head01, 2, Transitions.EASE_IN_OUT);
			headTween.rotateTo(deg2rad( -8));
			headTween.delay = 0.5;
			headTween.repeatCount = 6;
			headTween.reverse = true;
			
			Starling.juggler.add(leftArm); 
			Starling.juggler.add(headTween);
			Starling.juggler.add(rightArmTween);
			Starling.juggler.add(animationTween);
			
		}
	}
}