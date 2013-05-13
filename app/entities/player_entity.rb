class PlayerEntity < CCNode
  attr_accessor :sprite, :body, :up

  def initWithWorld(world)
    self.up = false
    self.body = world.new_body(position: [Screen.half_width,Screen.half_height], type: KDynamicBodyType)do
      polygon_fixture(box:[30,30],friction: 0.0,density: 100.0)
    end

    self.sprite = PhysicsSprite.new(
      file_name: 'sprites/player.png',
      body: self.body
      )
    self
  end

  def update(dt)
    if up
      self.body.apply_force force: ([0,1000])
    end
    if self.body.position.y < -3 || self.body.position.y>12 || self.body.position.x < -3
      director = Joybox.director
      director.replace_scene MenuLayer.scene
    end
  end

end