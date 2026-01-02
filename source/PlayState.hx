package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import objects.Bird;
import objects.Feed;

class PlayState extends FlxState
{
	private var birdGroup:BirdGroup;
	private var feedGroup:FlxTypedGroup<Feed>;
	private var buttonGroup:ButtonGroup;

	override public function create()
	{
		super.create();

		// For debugging
		// FlxG.debugger.visible = true;
		// FlxG.debugger.drawDebug = true;
		// FlxG.log.redirectTraces = true;

		this.birdGroup = new BirdGroup(0, 0);
		this.add(this.birdGroup);

		this.feedGroup = new FlxTypedGroup<Feed>();
		this.add(this.feedGroup);

		this.buttonGroup = new ButtonGroup(clickAddBird, clickAddFeed);
		this.add(this.buttonGroup);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		updateBirds();
	}

	private function clickAddBird():Void
	{
		birdGroup.addBird(FlxG.random.int(0, FlxG.width), FlxG.random.int(0, FlxG.height));
	}

	private function clickAddFeed():Void
	{
		var feed = new Feed(FlxG.random.int(0, FlxG.width), FlxG.random.int(0, FlxG.height));
		feedGroup.add(feed);
	}

	private function updateBirds():Void
	{
		birdGroup.forEachAlive(function(basic:FlxBasic)
		{
			if (!Std.isOfType(basic, Bird)) return;

			var bird:Bird = cast basic;
			var closestFeed:Feed = null;
			var minDistance:Float = 50;

			feedGroup.forEachAlive(function(feed:Feed)
			{
				var dist:Float = FlxMath.distanceBetween(bird, feed);
				if (dist < minDistance)
				{
					minDistance = dist;
					closestFeed = feed;
				}
			});

			bird.updateBehavior(closestFeed);
		});
	}
}
