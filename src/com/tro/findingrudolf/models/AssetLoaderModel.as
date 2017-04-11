/**
 * Created by russellmilburn on 15/10/15.
 */
package com.tro.findingrudolf.models
{

	import com.tro.findingrudolf.events.AssetLoaderModelEvent;
	import starling.utils.AssetManager;

	public class AssetLoaderModel extends BaseModel
	{
		private var _assetManager:AssetManager;
		private var hasElfZilla:Boolean = true;
		
		public function AssetLoaderModel()
		{
			super();
		}
		
		public function loadAssets() : void
		{
			logger.debug("MODEL: LoadAssets");
			
			dispatch(new AssetLoaderModelEvent(AssetLoaderModelEvent.ON_START_LOAD_ASSETS));
			//TODO: Setup function to get all files in folder and load through loop
			
			assetManager = new AssetManager();
			assetManager.enqueue("assets/textures/book1Assets0.xml");
			assetManager.enqueue("assets/textures/book1Assets0.atf");
			assetManager.enqueue("assets/textures/book1Assets1.xml");
			assetManager.enqueue("assets/textures/book1Assets1.atf");
			assetManager.enqueue("assets/textures/book1Assets2.xml");
			assetManager.enqueue("assets/textures/book1Assets2.atf");
			assetManager.enqueue("assets/textures/book2Assets0.xml");
			assetManager.enqueue("assets/textures/book2Assets0.atf");
			assetManager.enqueue("assets/textures/book2Assets1.xml");
			assetManager.enqueue("assets/textures/book2Assets1.atf");
			assetManager.enqueue("assets/textures/book2Assets2.xml");
			assetManager.enqueue("assets/textures/book2Assets2.atf");
			assetManager.enqueue("assets/textures/book3Assets0.xml");
			assetManager.enqueue("assets/textures/book3Assets0.atf");
			assetManager.enqueue("assets/textures/book3Assets1.xml");
			assetManager.enqueue("assets/textures/book3Assets1.atf");
			assetManager.enqueue("assets/textures/book3Assets2.xml");
			assetManager.enqueue("assets/textures/book3Assets2.atf");
			assetManager.enqueue("assets/textures/randomAnimationAssets0.xml");
			assetManager.enqueue("assets/textures/randomAnimationAssets0.atf");
			assetManager.enqueue("assets/textures/randomAnimationAssets1.xml");
			assetManager.enqueue("assets/textures/randomAnimationAssets1.atf");
			assetManager.enqueue("assets/textures/staticAssets0.xml");
			assetManager.enqueue("assets/textures/staticAssets0.atf");
			assetManager.enqueue("assets/textures/staticAssets1.xml");
			assetManager.enqueue("assets/textures/staticAssets1.atf");
			assetManager.enqueue("assets/textures/staticAssets2.xml");
			assetManager.enqueue("assets/textures/staticAssets2.atf");


			if (hasElfZilla)
			{
				assetManager.enqueue("assets/textures/elfzilla0.xml");
				assetManager.enqueue("assets/textures/elfzilla0.atf");
				assetManager.enqueue("assets/textures/elfzilla1.xml");
				assetManager.enqueue("assets/textures/elfzilla1.atf");
			}

			assetManager.loadQueue(onAssetLoadProgress);
		}
		protected function onAssetLoadProgress(ratio : Number):void
		{
			if (ratio == 1.0)
			{
				dispatch(new AssetLoaderModelEvent(AssetLoaderModelEvent.ON_COMPLETE_LOAD_ASSETS));
			}
		}
		
		public function get assetManager():AssetManager 
		{
			return _assetManager;
		}
		
		public function set assetManager(value:AssetManager):void 
		{
			_assetManager = value;
		}
	}
}
