package;

import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class ButtonGroup extends FlxGroup
{
	public function new(onAddBird:Void->Void, onAddFeed:Void->Void)
	{
		super();

		var btnAddBird = new FlxButton(10, 10, "Add Bird", onAddBird);
		btnAddBird.label.setFormat("assets/fonts/04B_03__.TTF", 10, FlxColor.BLACK, FlxTextAlign.CENTER);
		add(btnAddBird);

		var btnAddFeed = new FlxButton(10, 40, "Add Feed", onAddFeed);
		btnAddFeed.label.setFormat("assets/fonts/04B_03__.TTF", 10, FlxColor.BLACK, FlxTextAlign.CENTER);
		add(btnAddFeed);
	}
}
