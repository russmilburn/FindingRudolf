/**
 * Created by russellmilburn on 27/10/15.
 */
package com.tro.findingrudolf.models
{

	import com.tro.findingrudolf.events.AnimationFactoryEvent;
	import com.tro.findingrudolf.interfaces.IAnimationClip;
	import com.tro.findingrudolf.views.animations.AbstractAnimation;
	import com.tro.findingrudolf.views.animations.AnimationClip;
	import com.tro.findingrudolf.views.animations.AnimationList;
	import com.tro.findingrudolf.views.animations.ElfCricket;
	import com.tro.findingrudolf.views.animations.ElvesWindowSinging;
	import com.tro.findingrudolf.views.animations.SkiingAccident;
	import com.tro.findingrudolf.views.animations.SnowLandsOnElf;

	import starling.textures.Texture;

	public class AnimationFactory extends BaseModel
	{
		[Inject]
		public var assetsModel : AssetLoaderModel;

		private var _randomAnimations : Array;

		private var _redAnimations : Array;
		private var _greenAnimations : Array;
		private var _blueAnimations : Array;

		private var _isPlayingRed : Boolean = false;
		private var _isPlayingGreen : Boolean = false;
		private var _isPlayingBlue : Boolean = false;

		public function AnimationFactory()
		{
			super();

		}

		public function init():void
		{
			_randomAnimations = generateRandomAnimationsInOrder().slice();
			_redAnimations = generateRedAnimationsInOrder().slice();
			_greenAnimations = generateGreenAnimationsInOrder().slice();
			_blueAnimations = generateBlueAnimationsInOrder().slice();
		}

		public function generateRedAnimationsInOrder() : Array
		{
			var array : Array = new Array();
			array.push(AnimationList.B1_01);
			array.push(AnimationList.B1_02);
			array.push(AnimationList.B1_03);
			array.push(AnimationList.B1_04);
			array.push(AnimationList.B1_05);
			array.push(AnimationList.B1_06);
			array.push(AnimationList.B1_07);
			array.push(AnimationList.B1_08);
			array.push(AnimationList.B1_09);
			array.push(AnimationList.B1_10);
			//return array;
			return radomizeArray(array);
		}



		public function generateGreenAnimationsInOrder() : Array
		{
			var array : Array = new Array();
			array.push(AnimationList.B2_01);
			array.push(AnimationList.B2_02);
			array.push(AnimationList.B2_03);
			array.push(AnimationList.B2_04);
			array.push(AnimationList.B2_05);
			array.push(AnimationList.B2_06);
			array.push(AnimationList.B2_07);
			array.push(AnimationList.B2_08);
			array.push(AnimationList.B2_09);
			array.push(AnimationList.B2_10);
			//return array;
			return radomizeArray(array);
		}

		public function generateBlueAnimationsInOrder() : Array
		{
			var array : Array = new Array();
			array.push(AnimationList.B3_01);
			array.push(AnimationList.B3_02);
			array.push(AnimationList.B3_03);
			array.push(AnimationList.B3_04);
			array.push(AnimationList.B3_05);
			array.push(AnimationList.B3_06);
			array.push(AnimationList.B3_07);
			array.push(AnimationList.B3_08);
			array.push(AnimationList.B3_09);
			//return array;
			return radomizeArray(array);
		}

		public function generateRandomAnimationsInOrder() : Array
		{
			var array : Array = new Array();
			array.push(AnimationList.R1_01);
			array.push(AnimationList.R1_02);
			array.push(AnimationList.R1_03);
			array.push(AnimationList.R1_04);
			array.push(AnimationList.R1_05);
			array.push(AnimationList.R1_06);
			//array.push(AnimationList.R1_07);
			//array.push(AnimationList.R1_08);
			//array.push(AnimationList.R1_09);
			//array.push(AnimationList.R1_10);
			array.push(AnimationList.R1_11);
			array.push(AnimationList.R1_12);
			array.push(AnimationList.R1_13);
			array.push(AnimationList.R1_14);
			array.push(AnimationList.R1_15);
			array.push(AnimationList.R1_16);
			return array;
			//return radomizeArray(array);
		}

		public function createRandomAnimation(id : String) : void
		{
			//logger.info(id);
			var textures : Vector.<Texture> = assetsModel.assetManager.getTextures(id);
			var anim : IAnimationClip = new AnimationClip(textures);
			var layerId : String = AbstractAnimation.BACK_LAYER;
			var frameRate : Number = 24;
			var loop : Boolean = false;

			switch (id)
			{
				case AnimationList.R1_11:
					layerId = AbstractAnimation.FRONT_LAYER;
					break;
				case AnimationList.R1_12:
				case AnimationList.R1_13:
				case AnimationList.R1_16:
					layerId = AbstractAnimation.BACK_LAYER;
					break;
				case AnimationList.R1_14:
				case AnimationList.R1_15:
					layerId = AbstractAnimation.MID_LAYER;
					break;
			}

			anim.assetID = id;
			anim.loop = loop;
			anim.frameRate = frameRate;
			anim.layerId = layerId;

			var evt : AnimationFactoryEvent = new AnimationFactoryEvent(AnimationFactoryEvent.ON_CREATE_ANIMATION);
			evt.anim = anim;
			dispatch(evt)

		}

		public function createInteractiveAnimation(id : String) : void
		{
			var textures : Vector.<Texture> = assetsModel.assetManager.getTextures(id);
			var anim : IAnimationClip = new AnimationClip(textures);
			var layerId : String;
			var frameRate : Number = 24;
			var loop : Boolean = false;

			switch (id)
			{
				case AnimationList.B1_02:
				case AnimationList.B1_03:
				case AnimationList.B1_04:
				case AnimationList.B2_05:
				case AnimationList.B2_07:
				case AnimationList.B3_01:
				case AnimationList.B3_03:
				case AnimationList.B3_07:
					layerId = AbstractAnimation.BACK_LAYER;
					break;
				case AnimationList.B1_01:
				case AnimationList.B1_06:
				case AnimationList.B1_07:
				case AnimationList.B1_08:
				case AnimationList.B2_02:
				case AnimationList.B2_04:
				case AnimationList.B3_04:
					layerId = AbstractAnimation.MID_LAYER;
					break;

				case AnimationList.B1_05:
				case AnimationList.B1_09:
				case AnimationList.B1_10:
				case AnimationList.B2_03:
				case AnimationList.B2_08:
				case AnimationList.B2_09:
				case AnimationList.B3_05:
				case AnimationList.B3_06:
				case AnimationList.B3_08:
				case AnimationList.B3_09:
					layerId = AbstractAnimation.FRONT_LAYER;
					break;

				case AnimationList.B2_06:
					var skiing : SkiingAccident = new SkiingAccident(textures);
					skiing.skiingTexture = assetsModel.assetManager.getTexture("SkiingAccidentElf");
					layerId = AbstractAnimation.BACK_LAYER;
					anim = skiing;
					break;
				case AnimationList.B2_10:
					var elfCricket:ElfCricket = new ElfCricket(textures);
					elfCricket.snowballTexture = assetsModel.assetManager.getTexture("ElfCricket_Snowball");
					layerId = AbstractAnimation.MID_LAYER;
					anim = elfCricket;
					break;
					
				case AnimationList.B2_01:
					var snowLandsOnElf:SnowLandsOnElf = new SnowLandsOnElf(textures);
					layerId = AbstractAnimation.BACK_LAYER;
					anim = snowLandsOnElf;
					break;
				case AnimationList.B3_02:
					
					var elvesWindowSinging:ElvesWindowSinging = new ElvesWindowSinging(assetsModel.assetManager.getTextures(id + "01"));
					var animationVector:Vector.<Vector.<Texture>> = new Vector.<Vector.<Texture>>();
					
					animationVector.push(assetsModel.assetManager.getTextures(id + "02"));
					animationVector.push(assetsModel.assetManager.getTextures(id + "03"));
					animationVector.push(assetsModel.assetManager.getTextures(id + "04"));
					animationVector.push(assetsModel.assetManager.getTextures(id + "05"));
					animationVector.push(assetsModel.assetManager.getTextures(id + "06"));
					animationVector.push(assetsModel.assetManager.getTextures(id + "07"));
					elvesWindowSinging.createAnimations(animationVector);
					layerId = AbstractAnimation.BACK_LAYER;
					anim = elvesWindowSinging;
					
					break;
				default :
					logger.error("NO CONDITION FOR animation ID :" + id );
					return;
					break;

			}

			
			anim.assetID = id;
			anim.loop = loop;
			anim.frameRate = frameRate;
			anim.layerId = layerId;

			setAnimationPlaying(id);

			var evt : AnimationFactoryEvent = new AnimationFactoryEvent(AnimationFactoryEvent.ON_CREATE_ANIMATION);
			evt.anim = anim;
			dispatch(evt)

		}

		private function setAnimationPlaying(id : String) : void
		{
			if (id.search(AnimationList.BOOK + "1") !=  -1)
			{
				isPlayingRed = true;
			}
			else if (id.search(AnimationList.BOOK + "2") !=  -1)
			{
				isPlayingGreen = true;
			}
			else if (id.search(AnimationList.BOOK + "3") !=  -1)
			{
				isPlayingBlue = true;
			}
		}


		private function generateIDString(type : String, bookId : String, animID : String, animName : String) : String
		{
			var id : String = type + bookId + "_" + animID + "_" + animName;
			return id;
		}


		private function radomizeArray(arr:Array):Array
		{
			var len:int = arr.length;
			var temp:*;
			var i:int = len;
			while (i--)
			{
				var rand:int = Math.floor(Math.random() * len);
				temp = arr[i];
				arr[i] = arr[rand];
				arr[rand] = temp;
			}
			return arr;
		}


		public function get redAnimations():Array
		{
			return _redAnimations;
		}

		public function set redAnimations(value:Array):void
		{
			_redAnimations = value;
		}

		public function get blueAnimations():Array
		{
			return _blueAnimations;
		}

		public function set blueAnimations(value:Array):void
		{
			_blueAnimations = value;
		}

		public function get greenAnimations():Array
		{
			return _greenAnimations;
		}

		public function set greenAnimations(value:Array):void
		{
			_greenAnimations = value;
		}


		public function get randomAnimations():Array
		{
			return _randomAnimations;
		}

		public function set randomAnimations(value:Array):void
		{
			_randomAnimations = value;
		}


		public function get isPlayingRed():Boolean
		{
			return _isPlayingRed;
		}

		public function set isPlayingRed(value:Boolean):void
		{
			_isPlayingRed = value;
		}

		public function get isPlayingGreen():Boolean
		{
			return _isPlayingGreen;
		}

		public function set isPlayingGreen(value:Boolean):void
		{
			_isPlayingGreen = value;
		}

		public function get isPlayingBlue():Boolean
		{
			return _isPlayingBlue;
		}

		public function set isPlayingBlue(value:Boolean):void
		{
			_isPlayingBlue = value;
		}
	}
}
