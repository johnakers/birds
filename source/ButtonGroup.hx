package;

import flixel.group.FlxGroup;
import flixel.ui.FlxButton;

class ButtonGroup extends FlxGroup
{
	public function new(onAddBird:Void->Void, onAddFeed:Void->Void)
	{
		super();

		var btnAddBird = new FlxButton(10, 10, "Add Bird", onAddBird);
		add(btnAddBird);

		var btnAddFeed = new FlxButton(10, 40, "Add Feed", onAddFeed);
		add(btnAddFeed);
	}
}