/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 5/29/11
 * Time: 10:37 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.matchhack.activities.transitions
{
    import com.jessefreeman.factivity.activities.BaseActivity;
    import com.jessefreeman.factivity.activities.transitions.ActivitySwapTransition;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.geom.Rectangle;

    import spark.primitives.Rect;

    import uk.co.soulwire.display.PaperSprite;

    public class ActivityTileFlipTransition extends ActivitySwapTransition
    {

        private var currentActivityBitmapData:BitmapData = new BitmapData(BaseActivity.fullSizeWidth, BaseActivity.fullSizeHeight, false, 0);
        private var newActivityBitmapData:BitmapData = new BitmapData(BaseActivity.fullSizeWidth, BaseActivity.fullSizeHeight, false, 0);
        private var activeFlipCard:PaperSprite;

        public function ActivityTileFlipTransition()
        {
            super();
        }


        override public function set target(value:DisplayObjectContainer):void
        {
            super.target = value;

        }

        override public function onSwapActivities(newActivity:BaseActivity):void
        {
            //currentActivityBitmapData = new BitmapData(BaseActivity.fullSizeWidth, BaseActivity.fullSizeHeight, false, 0);
            if(_currentActivity)
                currentActivityBitmapData.draw(_currentActivity);

            super.onSwapActivities(newActivity);
        }

        override protected function addActivity(newActivity:BaseActivity):void
        {
            if(_currentActivity)
                _currentActivity.onStop();

            _currentActivity = newActivity;

            //newActivityBitmapData.fillRect(new Rectangle(0,0,newActivity.width, newActivity.height), 0);
            newActivityBitmapData.draw(_currentActivity);

            activeFlipCard = new PaperSprite(new Bitmap(currentActivityBitmapData), new Bitmap(newActivityBitmapData));
            //activeFlipCard.flipTime = 10;
            activeFlipCard.x += (activeFlipCard.width * .5);
            activeFlipCard.y += (activeFlipCard.height * .5);

            _target.addChild(activeFlipCard);
            activeFlipCard.flip();
            activeFlipCard.addEventListener(Event.COMPLETE, onFlipComplete);
        }

        private function onFlipComplete(event:Event):void
        {
            _target.removeChild(activeFlipCard);
            activeFlipCard = null;

            _target.addChild(_currentActivity);
            _currentActivity.onStart();

        }
    }
}
