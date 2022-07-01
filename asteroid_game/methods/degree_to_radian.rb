require 'ruby2d'
require '../asteroid_game/components/asteroid_class'
require '../asteroid_game/methods/move.rb'
require '../asteroid_game/methods/degrees_between_coordinates.rb'
require '../asteroid_game/methods/apply_gravity.rb'

# Degree to Radian method
def degree_to_radian(deg)
  (deg * Math::PI) / 180
end