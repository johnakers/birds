package;

import flixel.FlxObject;
import flixel.group.FlxGroup;
import objects.*;

class BirdGroup extends FlxGroup
{
  public var birds:Array<Bird> = [];
  public var shadows:Array<Shadow> = [];
  public var hearts:Array<Array<Heart>> = [];

  public function new(x:Float, y:Float):Void
  {
    super();

    this.addBird(x, y);
    this.birds[0].screenCenter();
    this.addBird(100, 100);
  }

  public function addBird(x:Float, y:Float):Void
  {
    var bird = new Bird(x, y);
    var shadow = new Shadow(bird.x, bird.y);
    var birdHearts:Array<Heart> = [];

    for (_i in 0...bird.hp)
    {
      var heart = new Heart(bird.x, bird.y);
      this.add(heart);
      birdHearts.push(heart);
    }

    this.add(shadow);
    this.add(bird);

    this.birds.push(bird);
    this.shadows.push(shadow);
    this.hearts.push(birdHearts);
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    var i = this.birds.length - 1;
    while (i >= 0)
    {
      var bird = this.birds[i];
      var birdHearts = this.hearts[i];

      if (bird.hp <= 0)
      {
        for (heart in birdHearts)
        {
          this.remove(heart);
          heart.destroy();
        }
        this.remove(this.shadows[i]);
        this.shadows[i].destroy();
        this.remove(bird);
        bird.destroy();

        this.birds.splice(i, 1);
        this.shadows.splice(i, 1);
        this.hearts.splice(i, 1);
        i--;
        continue;
      }

      while (birdHearts.length < bird.hp)
      {
        var heart = new Heart(bird.x, bird.y);
        this.add(heart);
        birdHearts.push(heart);
      }

      while (birdHearts.length > bird.hp)
      {
        var heart = birdHearts.pop();
        this.remove(heart);
        heart.destroy();
      }

      this.shadows[i].x = bird.x;
      this.shadows[i].y = bird.y;

      var scale = 1 - (bird.z / 40);
      this.shadows[i].scale.set(scale, scale);

      var totalWidth = (birdHearts.length - 1) * 8 + 7;
      var startX = bird.x + (bird.width - totalWidth) / 2;

      for (j in 0...birdHearts.length)
      {
        birdHearts[j].x = startX + (j * 8);
        birdHearts[j].y = bird.y - 10;
        birdHearts[j].offset.y = bird.offset.y;
      }
      i--;
    }
  }
}
