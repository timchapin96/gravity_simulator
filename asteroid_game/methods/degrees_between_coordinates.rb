require 'ruby2d'
require '../asteroid_game/components/asteroid_class'
require '../asteroid_game/methods/move.rb'
require '../asteroid_game/methods/degree_to_radian.rb'
require '../asteroid_game/methods/apply_gravity.rb'

# Gets current angle of small circle


def degrees_between_coordinates(x_1, y_1, x_2, y_2)
  Math.atan2(y_2 - y_1, x_2 - x_1) * (180 / Math::PI)
end