require 'ruby2d'
require '../asteroid_game/components/asteroid_class'
require '../asteroid_game/methods/move.rb'
require '../asteroid_game/methods/degree_to_radian.rb'
require '../asteroid_game/methods/degrees_between_coordinates.rb'

def apply_gravity(small_circle, planet, big_g, real_big_g)
  # Calculate distance from small_circle to get Gravity strength

  distance_y = (planet.y - small_circle.body.y)
  distance_x = (planet.x - small_circle.body.x)

  degrees = degrees_between_coordinates(planet.x, planet.y, small_circle.body.x, small_circle.body.y)

  # Calculate gravity using the newtons formula
  gravity_force = -1 * real_big_g / ((distance_y * distance_y + distance_x * distance_x )) 
  cosx = Math.cos(degree_to_radian(degrees))
  siny = Math.sin(degree_to_radian(degrees))
  gravity_force_x = cosx * gravity_force
  gravity_force_y = siny * gravity_force

  small_circle.increase_y_velocity(gravity_force_y)
  small_circle.increase_x_velocity(gravity_force_x)
end