# Flighter

A simple prototype game that I write in [RubyMotion](http://www.rubymotion.com/) with the [Joybox](https://github.com/rubymotion/Joybox) library. The code is looking to explore a way to create a game with an entities workflow with Joybox. Please, don't use it as a perfect way to embed that kind of goal.

## Entity without passing args

```ruby
class AsteroidEntity < CCNode
  attr_accessor :sprite, :out

  def init
    super
    self.sprite = Sprite.new(
      file_name: 'sprites/asteroide.png',
      position: [rand(Screen.width),Screen.height+40]
      )
    self.out = false
    self
  end

  def update(dt)
    pos = self.sprite.position
    self.sprite.position = [pos.x,pos.y - 200*dt]
    if self.sprite.position.y < -40
      self.sprite.removeFromParentAndCleanup true
      self.out = true
    end
  end
end

# In your layer, you want to generate an asteroid
asteroid = AsteroidEntity.new
asteroid.sprite # return the sprite of the entity
self << asteroid.sprite
```


## Entity with passing args

If you need to expose some element to the entity on the creation, here's my approch. In this exemple, I need the world for the physics

```ruby
class BonusEntity < CCNode
  attr_accessor :sprite, :body, :out

  def initWithWorld(world)
    self.out = false

    self.body = world.new_body(
      position: [500,rand(Screen.height)],
      type: KDynamicBodyType) do
        circle_fixture(radius:30,friction: 0.0,density: 0.0)
    end

    self.sprite = PhysicsSprite.new(
      file_name: 'sprites/Star.png',
      body: self.body
      )
    self
  end
end

# In your layer, you want to generate mass of bonus
@world = World.new(gravity:[0.0, -2])
@stars = []
10.times do
  bonus = BonusEntity.alloc.initWithWorld @world
  @stars.push bonus
  layer << @stars.last.sprite
end
```

## Authors
* Images by [Daniel Cook](http://www.lostgarden.com/2007/05/dancs-miraculously-flexible-game.html) from the PlanetCute project.
* Code by [Gaël Gillard](http://blog.gaelgillard.com)