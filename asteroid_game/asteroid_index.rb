require 'ruby2d'
require '../asteroid_game/components/asteroid_class'

set title: 'Angry Birds' , width: 1920, height: 1000, resizable: true

#Declare variables
degrees = -90
big_g = 15
$real_big_g = 8000
asteroid_radius = 25
planet1_radius = 150
jump_strength = 4
$my_text = Text.new("test")

Planet1 = Circle.new(
  x: Window.width / 2, y: Window.height / 2,
  radius: planet1_radius,
  sectors: 120,
  color: 'blue',
  z: 1
)
Planet1_gravity_field = Circle.new(
  x: Window.width / 2, y: Window.height / 2,
  radius: planet1_radius + asteroid_radius + 1,
  sectors: 120,
  color: 'blue',
  z: 0,
  opacity: 0.2
)

small_circle1 = Asteroid.new(asteroid_radius)

# Degree to Radian method
def degree_to_radian(deg)
  (deg * Math::PI) / 180
end

# Gets current angle of small circle
def degrees_between_coordinates(x_1, y_1, x_2, y_2)
  Math.atan2(y_2 - y_1, x_2 - x_1) * (180 / Math::PI)
end

# Set Asteroid default location cleato surface of Planet
def default_position(small_circle, big_circle)
  small_circle.x = Math.cos(degree_to_radian(-90)) * (big_circle.radius + small_circle.radius) + big_circle.x  
  small_circle.y = Math.sin(degree_to_radian(-90)) * (big_circle.radius + small_circle.radius) + big_circle.y
end

# Take values from key_held and move small circle
def move (small_circle, big_circle, degree)
  small_circle.x = Math.cos(degree_to_radian(degree)) * (small_circle.radius + big_circle.radius) + big_circle.x
  small_circle.y = Math.sin(degree_to_radian(degree)) * (small_circle.radius + big_circle.radius) + big_circle.y
end

def apply_gravity(small_circle, planet, big_g)
  # Calculate distance from small_circle to get Gravity strength

  # I think we need to calculate "gravity" as one value and then get a y and x component out of it using the the cos sin stuff

  distance_y = (planet.y - small_circle.body.y)
  distance_x = (planet.x - small_circle.body.x)

  degrees = degrees_between_coordinates(planet.x, planet.y, small_circle.body.x, small_circle.body.y)

  # Calculate gravity using the newtons formula
  gravity_force = -1 * $real_big_g / ((distance_y * distance_y + distance_x * distance_x )) 
  cosx = Math.cos(degree_to_radian(degrees))
  siny = Math.sin(degree_to_radian(degrees))
  gravity_force_x = cosx * gravity_force
  gravity_force_y = siny * gravity_force

  $my_text.remove
  $my_text = Text.new("Grav_F#{gravity_force}, x_ratio:#{cosx}, y_ratio:#{siny}, x_F:#{gravity_force_x}, y_F:#{gravity_force_y}")

  small_circle.increase_y_velocity(gravity_force_y)
  small_circle.increase_x_velocity(gravity_force_x)
end

# Left and right arrow key to move around circle
on :key_held do |event|
  # A key is being held down
  if event.key == 'left'
    degrees -= small_circle1.speed
    move(small_circle1.body, Planet1, degrees)
  elsif event.key == 'right'
    degrees += small_circle1.speed
    move(small_circle1.body, Planet1, degrees)
  end
end

on :key_down do |event|
  # All keyboard interaction
  if event.key == 'space'
    degrees = degrees_between_coordinates(Planet1.x, Planet1.y, small_circle1.body.x, small_circle1.body.y)
    x_acceleration = Math.cos(degree_to_radian(degrees)) * jump_strength
    y_acceleration = Math.sin(degree_to_radian(degrees)) * jump_strength
    small_circle1.increase_y_velocity(y_acceleration)
    small_circle1.increase_x_velocity(x_acceleration)
    puts("Acceleration : y:#{y_acceleration}}, x:#{x_acceleration}, Velocity: y:#{small_circle1.y_velocity}, x:#{small_circle1.x_velocity}")
  end
end

default_position(small_circle1.body, Planet1);

update do

  # we should only apply changes in velocity due to gravity if we are NOT on the planet
  if !Planet1_gravity_field.contains? small_circle1.body.x,small_circle1.body.y
    apply_gravity(small_circle1 ,Planet1, big_g)
  end

  # Caclulate the new position of the object based on it's current velocity
  new_x_position = small_circle1.body.x + small_circle1.x_velocity
  new_y_position = small_circle1.body.y + small_circle1.y_velocity
  
  # If small circle crosses the big circle boundry place it on the big circle
  if Planet1_gravity_field.contains? new_x_position, new_y_position
    # Set y position to big circle surface
    move(small_circle1.body, Planet1, degrees_between_coordinates(Planet1.x, Planet1.y, small_circle1.body.x, small_circle1.body.y))
    # if we are on the planet now, we should kill our velocity
    small_circle1.kill_velocity
  else
    small_circle1.body.y = new_y_position
    small_circle1.body.x = new_x_position
  end

end



show