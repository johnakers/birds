package objects;

import flixel.FlxSprite;

enum HeartState
{
  Empty;
  Filled;
}

class Heart extends FlxSprite
{
  var state:HeartState;

  public function new(x:Float, y:Float)
  {
    super(x, y);

    this.loadGraphic("assets/images/heart/spritesheet.png", true, 7, 7, true, "bird");

    this.state = HeartState.Filled;
    this.animation.add("empty", [0]);
    this.animation.add("filled", [1]);
  }

  override public function update(elapsed:Float)
  {
    // offset.y = 8; // TODO: Test this

    switch(this.state)
    {
      case HeartState.Empty:
        this.animation.play("empty");
      case HeartState.Filled:
        this.animation.play("filled");
    }
  }
}
