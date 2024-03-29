require 'ruby2d'
require '../asteroid_game/components/asteroid_class'
require '../asteroid_game/methods/degree_to_radian.rb'
require '../asteroid_game/methods/degrees_between_coordinates.rb'
require '../asteroid_game/methods/apply_gravity.rb'

# Take values from key_held and move small circle

def move (small_circle, big_circle, degree)
    small_circle.x = Math.cos(degree_to_radian(degree)) * (small_circle.radius + big_circle.radius) + big_circle.x
    small_circle.y = Math.sin(degree_to_radian(degree)) * (small_circle.radius + big_circle.radius) + big_circle.y
end