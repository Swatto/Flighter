class BonusEntity < CCNode
  attr_accessor :sprite, :body, :out

  def initWithWorld(world)
    self.out = false
    x = [-30,500].sample

    self.body = world.new_body(position: [x,rand(Screen.height)],type: KDynamicBodyType, gravityScale: 0) do
      circle_fixture(radius:30,friction: 0.0,density: 0.0)
    end

    if x == -30
      @way = "right"
    else
      @way = "left"
    end

    self.sprite = PhysicsSprite.new(
      file_name: 'sprites/Star.png',
      body: self.body
      )

    world.when_collide self.body do |collision_body, is_touching|
      $score += 10
      self.sprite.removeFromParentAndCleanup true
      self.out = true
    end

    self
  end

  def update(dt)
    if self.body.position.x < -10 || self.body.position.x > 16
      self.sprite.removeFromParentAndCleanup true
      self.out = true
    else
      if @way == "left"
        self.body.apply_force force: ([-2,1])
      else
        self.body.apply_force force: ([2,1])
      end
    end
  end

end