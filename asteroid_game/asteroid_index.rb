require 'ruby2d'
require '../asteroid_game/components/asteroid_class'
require '../asteroid_game/methods/move'
require '../asteroid_game/methods/degree_to_radian'
require '../asteroid_game/methods/degrees_between_coordinates'
require '../asteroid_game/methods/default_position'
require '../asteroid_game/methods/move_in_space'

set title: 'Gravity Simulator' , width: 1920, height: 1000, resizable: true

# Declare variables
degrees = -90
big_g = 15
real_big_g = 8000
asteroid_radius = 25
planet1_radius = 150
jump_strength = 4

background = Image.new(
  '../asteroid_game/images/space_background.jpeg',
  width: 1920, height: 1000,
  z: 0
)

Planet1 = Circle.new(
  x: Window.width / 2, y: Window.height / 2,
  radius: planet1_radius,
  sectors: 120,
  color: 'blue',
  z: 2
)
Planet1_gravity_field = Circle.new(
  x: Window.width / 2, y: Window.height / 2,
  radius: planet1_radius + asteroid_radius + 1,
  sectors: 120,
  color: 'blue',
  z: 1,
  opacity: 0.2
)

small_circle1 = Asteroid.new(asteroid_radius)


# Left and right arrow key to move around circle
on :key_held do |event|
  puts(degrees)
  # If asteroid leaves gravity field call move_in_space method
  if !(Planet1_gravity_field.contains? small_circle1.body.x, small_circle1.body.y) && (event.key == 'left')
    degrees -= small_circle1.speed
    move_in_space(small_circle1.body, Planet1, degrees, $new_x_position, $new_y_position)
  elsif !(Planet1_gravity_field.contains? small_circle1.body.x, small_circle1.body.y) && (event.key == 'right')
    degrees += small_circle1.speed
    move_in_space(small_circle1.body, Planet1, degrees, $new_x_position, $new_y_position)
  # If asteroid is in gravity field call move method
  # Recalculate where the asteroid landed and move from there with degrees-bet_coor func
  elsif event.key == 'left'
    degrees = degrees_between_coordinates(Planet1.x, Planet1.y, small_circle1.body.x, small_circle1.body.y)
    degrees -= small_circle1.speed
    move(small_circle1.body, Planet1, degrees)
  elsif event.key == 'right'
    degrees = degrees_between_coordinates(Planet1.x, Planet1.y, small_circle1.body.x, small_circle1.body.y)
    degrees += small_circle1.speed
    move(small_circle1.body, Planet1, degrees)
  end
  # puts(small_circle1.body.x)
end

on :key_down do |event|
  # All keyboard interaction
  if event.key == 'space'
    degrees = degrees_between_coordinates(Planet1.x, Planet1.y, small_circle1.body.x, small_circle1.body.y)
    x_acceleration = Math.cos(degree_to_radian(degrees)) * jump_strength
    y_acceleration = Math.sin(degree_to_radian(degrees)) * jump_strength
    small_circle1.increase_y_velocity(y_acceleration)
    small_circle1.increase_x_velocity(x_acceleration)
  end
end

default_position(small_circle1.body, Planet1)

update do

  # we should only apply changes in velocity due to gravity if we are NOT on the planet
  if !Planet1_gravity_field.contains? small_circle1.body.x,small_circle1.body.y
    apply_gravity(small_circle1, Planet1, big_g, real_big_g)
  end

  # Caclulate the new position of the object based on it's current velocity
  $new_x_position = small_circle1.body.x + small_circle1.x_velocity
  $new_y_position = small_circle1.body.y + small_circle1.y_velocity
  # If small circle crosses the big circle boundry place it on the big circle
  if Planet1_gravity_field.contains? $new_x_position, $new_y_position
    # Set y position to big circle surface
    move(small_circle1.body, Planet1, degrees_between_coordinates(Planet1.x, Planet1.y, small_circle1.body.x, small_circle1.body.y))
    # if we are on the planet now, we should kill our velocity
    small_circle1.kill_velocity
  else
    small_circle1.body.y = $new_y_position
    small_circle1.body.x = $new_x_position
  end

end

show
