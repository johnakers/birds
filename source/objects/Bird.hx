package objects;

import flixel.FlxSprite;

enum BirdState
{
  Idle;
  Walking;
  Feeding;
  Flying;
}

class Bird extends FlxSprite
{
  public var state:BirdState;
  public var maxHP:Int;
  public var hp:Int;
  public var z:Float = 0;
  private var eatTimer:Float = 0;
  private var idleTimer:Float = 0;
  private var flyTimer:Float = 0;

  public function new(x:Float, y:Float):Void
  {
    super(x, y);

    this.loadGraphic("assets/images/bird/spritesheet.png", true, 16, 16, true, "bird");

    this.setFacingFlip(LEFT, false, false);
    this.setFacingFlip(RIGHT, true, false);

    this.animation.add("idle", [4], 15, true);
    this.animation.add("feed", [0, 1], 15, true);
    this.animation.add("fly",  [2,3], 15, true);
    this.animation.add("walk", [4, 9], 15, true);

    this.state = BirdState.Idle;
    this.hp = 3;
    this.maxHP = 3;
  }

  override public function update(elapsed:Float):Void
  {
    super.update(elapsed);

    updateMovement();
    updateCurrentAnimation();
  }

  private function updateMovement():Void
  {
    if (this.state == BirdState.Idle)
    {
      this.idleTimer += flixel.FlxG.elapsed;
      if (this.idleTimer >= 3)
      {
        this.state = BirdState.Flying;
        this.z = 0;
        this.flyTimer = 0;
        this.velocity.set(flixel.FlxG.random.float(-40, 40), flixel.FlxG.random.float(-40, 40));
      }
    }
    else if (this.state == BirdState.Flying)
    {
      this.flyTimer += flixel.FlxG.elapsed;

      if (this.flyTimer <= 1)
        this.z = this.flyTimer * 20;
      else if (this.flyTimer >= 6)
        this.z = (7 - this.flyTimer) * 20;
      else
        this.z = 20;

      if (this.flyTimer >= 7)
      {
        this.state = BirdState.Idle;
        this.z = 0;
        this.velocity.set(0, 0);
        this.idleTimer = 0;
        this.hp--;
      }

      if (this.x < 0 && this.velocity.x < 0) this.velocity.x *= -1;
      if (this.x > flixel.FlxG.width && this.velocity.x > 0) this.velocity.x *= -1;
      if (this.y < 0 && this.velocity.y < 0) this.velocity.y *= -1;
      if (this.y > flixel.FlxG.height && this.velocity.y > 0) this.velocity.y *= -1;
    }

    offset.y = z;
  }

  private function updateCurrentAnimation():Void
  {
    if (velocity.x != 0)
    {
      facing = velocity.x < 0 ? LEFT : RIGHT;
    }

    switch(this.state)
    {
      case BirdState.Idle:
        this.animation.play("idle");
      case BirdState.Walking:
        this.animation.play("walk");
      case BirdState.Feeding:
        this.animation.play("feed");
      case BirdState.Flying:
        this.animation.play("fly");
    }
  }

	public function updateBehavior(target:Feed):Void
	{
		if (this.state == BirdState.Flying) return;

		if (target == null)
		{
			this.eatTimer = 0;
			if (this.state == BirdState.Walking || this.state == BirdState.Feeding)
			{
				this.state = BirdState.Idle;
				this.velocity.set(0, 0);
			}
			return;
		}

		this.idleTimer = 0;
		this.flyTimer = 0;
		this.z = 0;

		var dist:Float = flixel.math.FlxMath.distanceBetween(this, target);

		if (dist < 20)
		{
			this.velocity.set(0, 0);
			this.state = BirdState.Feeding;

			this.eatTimer += flixel.FlxG.elapsed;
			if (this.eatTimer >= 1)
			{
				target.hp--;
				this.hp++;
				if (target.hp <= 0)
				{
					target.kill();
				}
				this.eatTimer = 0;
			}
		}
		else
		{
			flixel.math.FlxVelocity.moveTowardsObject(this, target, 10);
			this.state = BirdState.Walking;
			this.eatTimer = 0;
		}
	}
}
