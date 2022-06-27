# Gets current angle of small circle


def degrees_between_coordinates(x_1, y_1, x_2, y_2)
  Math.atan2(y_2 - y_1, x_2 - x_1) * (180 / Math::PI)
end