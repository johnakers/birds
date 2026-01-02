package objects;

import flixel.FlxSprite;

class Shadow extends FlxSprite
{
  public function new(x:Float, y:Float)
  {
    super(x, y);

    loadGraphic("assets/images/bird/shadow.png", true, 14, 8, true, "shadow");
  }

  override public function update(elapsed:Float)
  {
    offset.y = -14;
    offset.x = -1;
  }
}
