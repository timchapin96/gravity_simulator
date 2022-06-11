# Take values from key_held and move small circle

def move (small_circle, big_circle, degree)
    small_circle.x = Math.cos(degree_to_radian(degree)) * (small_circle.radius + big_circle.radius) + big_circle.x
    small_circle.y = Math.sin(degree_to_radian(degree)) * (small_circle.radius + big_circle.radius) + big_circle.y
end