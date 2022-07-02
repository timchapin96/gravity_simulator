require 'ruby2d'
require '../asteroid_game/components/asteroid_class'
require '../asteroid_game/methods/degree_to_radian'
require '../asteroid_game/methods/degrees_between_coordinates'
require '../asteroid_game/methods/apply_gravity'

def move_in_space (small_circle, big_circle, degree, new_x_position, new_y_position)
    small_circle.x = Math.cos(degree_to_radian(degree)) + new_x_position
    small_circle.y = Math.sin(degree_to_radian(degree)) + new_y_position
end