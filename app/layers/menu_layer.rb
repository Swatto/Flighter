class MenuLayer < Joybox::Core::Layer

  scene

  def on_enter
    bg = Sprite.new file_name: "bg.jpg", position:[Screen.half_width,Screen.half_height]
    self << bg

    title = Label.new  text: "Flighter", font_size: 54,position: [Screen.half_width, Screen.height- 50]
    self << title


    MenuLabel.default_font_size = 24
    play_label = MenuLabel.new text: "Play", color: Color.from_hex('#c2c2c2') do |menu_item|
      director = Joybox.director
      director.replace_scene GameLayer.scene
    end

    menu = Menu.new items:[play_label], position: [Screen.half_width, 100]
    self << menu
  end

end