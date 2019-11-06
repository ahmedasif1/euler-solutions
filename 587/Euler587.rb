#!ruby


def solve_quadratic_equation(a,b,c)
    temp = b**2 - 4*a*c
    temp = Math.sqrt(temp)
    x1 = (-b + temp)/(2 * a)
    x2 = (-b - temp)/(2 * a)
    [x1,x2]
end

def find_angle_in_circle(circles)
    y = solve_quadratic_equation(circles**2 +1, -2*circles -2, 1).min
    Math::acos(1-y)
end

def shaded_area_ratio(angle, circles)
    x = 1.0/circles
    (2 * (x - (angle - (1 - x)*Math::sin(angle))))/(4-Math::PI)
end

t1=Time.now

circles = 2
while true
    angle = find_angle_in_circle(circles)
    ratio = shaded_area_ratio(angle, circles)
    if ratio <=0.001
        break
    end
    circles+=1
end

t2=Time.now

puts "Euler 587 - Concave Triangles"
puts "Solution: #{circles}"
puts "Time: #{'%0.2f'%((t2-t1)*1000)} ms"
