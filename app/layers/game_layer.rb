class GameLayer < Joybox::Core::Layer
  attr_accessor :world

  scene

  def on_enter
    setup
    schedule_update
  end

  def setup
    self.world = World.new(gravity:[0.0, -2])
    $score = 0

    bg = Sprite.new file_name: "bg.jpg", position:[Screen.half_width,Screen.half_height]
    self << bg

    @player = PlayerEntity.alloc.initWithWorld self.world
    self << @player.sprite

    @stars=[]
    self.schedule :generateBonus, interval:0.8

    @label = Label.new  text: "Score: #{$score}",
                   font_size: 24,
                   position: [Screen.half_width, Screen.height-40]

    self << @label

    on_touches_began do |touches, event|
      @player.up = true
    end

    on_touches_ended do |touches, event|
      @player.up = false
    end
  end

  def generateBonus
    bonus = BonusEntity.alloc.initWithWorld self.world
    @stars.push bonus
    self << @stars.last.sprite
  end

  def update(dt)
    self.world.step delta: dt

    @player.update(dt)
    @label.text = "Score: #{$score}"

    @stars.each do |bonus|
      if bonus.out == false
        bonus.update(dt)
      else
        @stars.delete(bonus)
      end
    end
  end

end