require 'ruby2d'
require '../asteroid_game/components/asteroid_class'
require '../asteroid_game/methods/move.rb'
require '../asteroid_game/methods/degree_to_radian.rb'
require '../asteroid_game/methods/degrees_between_coordinates.rb'

# Set Asteroid default location cleato surface of Planet
def default_position(small_circle, big_circle)
    small_circle.x = Math.cos(degree_to_radian(-90)) * (big_circle.radius + small_circle.radius) + big_circle.x
    small_circle.y = Math.sin(degree_to_radian(-90)) * (big_circle.radius + small_circle.radius) + big_circle.y
end