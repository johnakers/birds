package;

import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class ButtonGroup extends FlxGroup
{
	public function new(onAddBird:Void->Void, onAddFeed:Void->Void)
	{
		super();

		var btnAddBird = new FlxButton(10, 10, "Add Bird", onAddBird);
		btnAddBird.label.font = "assets/fonts/04B_03__.TTF";
		btnAddBird.label.setFormat(null, 10, FlxColor.BLACK);
		add(btnAddBird);

		var btnAddFeed = new FlxButton(10, 40, "Add Feed", onAddFeed);
		btnAddFeed.label.font = "assets/fonts/04B_03__.TTF";
		btnAddFeed.label.setFormat(null, 10, FlxColor.BLACK);
		add(btnAddFeed);
	}
}
