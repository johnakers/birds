package objects;

import flixel.FlxSprite;

class Feed extends FlxSprite
{
  public var hp:Int;

  public function new(x:Float, y:Float)
  {
    super(x, y);

    this.loadGraphic("assets/images/feed/spritesheet.png", true, 8, 8, true, "feed");

    this.animation.add("3", [0], 30, true);
    this.animation.add("2", [1], 30, true);
    this.animation.add("1", [2], 30, true);

    this.hp = 3;
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    this.animation.play("" + this.hp);
  }
}
