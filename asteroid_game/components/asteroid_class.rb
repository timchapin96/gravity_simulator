# Create Little circle
# MAKE THIS CLASS NOT SHIT
class Asteroid
  def initialize(radius)
    @body = Circle.new(
      radius: radius,
      x: Window.width / 2,
      y: Window.height / 2,
      sectors: 60,
      color: 'red',
      z: 2,
      opacity: 0.5
    )
    @speed = 1

    @y_velocity = 0
    @x_velocity = 0

    @max_y_velocity = 5
    @min_y_velocity = -5

    @max_x_velocity = 5
    @min_x_velocity = -5
  end

  attr_reader :body, :speed, :y_velocity, :x_velocity

  def increase_y_velocity(new_y)
    @y_velocity += new_y
    if @y_velocity > @max_y_velocity
      @y_velocity = @max_y_velocity
    elsif @y_velocity < @min_y_velocity
      @y_velocity = @min_y_velocity
    end
  end

  def increase_x_velocity(new_x)
    @x_velocity += new_x
    if @x_velocity > @max_x_velocity
      @x_velocity = @max_x_velocity
    elsif @x_velocity < @min_x_velocity
      @x_velocity = @min_x_velocity
    end
  end

  def kill_velocity
    @y_velocity = 0
    @x_velocity = 0
  end
end
