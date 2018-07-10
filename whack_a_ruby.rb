require 'gosu'

class WhackARuby < Gosu::Window
  def initialize
    super(1080, 720)
    self.caption = "Whack a ruby!"
    @image = Gosu::Image.new('img\rubys.png')
    @x = 200
    @y = 200
    @width = 50
    @height = 43
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hammer = Gosu::Image.new('img\hammers.png')
    @hit = 0
  end

  def update()
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= -1 if @x + @width / 2 > 1080 || @x - @width / 2 < 0
    @velocity_y *= -1 if @y + @height / 2 > 720 || @y - @height / 2 < 0
    @visible -= 1
    @visible = 30 if @visible < -10 && rand < 0.01
  end

  def draw()
    if @visible > 0
      @image.draw(@x - @width / 2, @y - @height / 2, 1)
    end
    @hammer.draw(mouse_x - 40, mouse_y - 10, 1)
    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::RED
    elsif @hit == -1
      c = Gosu::Color::GREEN
    end
    draw_quad(0, 0, c, 1080, 0, c, 1080, 720, c, 0, 720, c)
    @hit = 0
  end

  def button_down(id)
    if (id == Gosu::MsLeft)
      if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
        @hit = 1
      else
        @hit = -1
      end
    end
  end
end

window = WhackARuby.new
window.show
