--
--	math extension example for batteries
--

require("common")

-------------------------------------------------------------------------------
heading("wrap")

--wrap turns a linear value into a value on the interval [lo, hi)
--which can be very useful for things like wrapping maps and the like
local pre_wrap = 27
print("pre wrap", pre_wrap)
print("wrapped 0, 10", math.wrap(pre_wrap, 0, 10))
print("wrapped -20, 20", math.wrap(pre_wrap, -20, 20))

--you can also wrap indices onto sequential tables
local t = {1, 2, 3, 4, 5}
print_table("t", t)
print("wrapped index", math.wrap_index(pre_wrap, t))

-------------------------------------------------------------------------------
heading("clamp")

--clamp lets you ensure a number is on an interval, with it being set to
--either the low or high end if it's too high or two low respectively
--(this is somehow much easier to get right first time than math.max/min!)
local pre_clamp = 13.2
print("pre clamp", pre_clamp)
print("clamped 0, 10", math.clamp(pre_clamp, 0, 10))
print("clamped 20, 30", math.clamp(pre_clamp, 20, 30))

--clamp01 is available as a shorthand for clamping something on the interval
--from 0 to 1, such as for colours or lerp factors or whatever
pre_clamp = {-0.5, 0.0, 0.5, 1.0, 1.5}
print_table("pre clamp", pre_clamp)
print_table("clamp01", table.map(pre_clamp, math.clamp01))

-------------------------------------------------------------------------------
heading("lerp")

--speaking of lerp, lets learn about that
--lerp is a common shortening of "linear interpolation", which
--is maths-speak for going straight from one value to another based
--on a factor between zero and one

--lets set up some data to demo this
local a, b = 5, 10
print("a", a)
print("b", b)

--if the factor is zero, the first value should be returned
--if the factor is one, the second should be returned
print("f = 0", math.lerp(a, b, 0))
print("f = 1", math.lerp(a, b, 1))

--if the factor is 0.5, it should be halfway between both values
print("f = 0.5", math.lerp(a, b, 0.5))

--this works for any factor between zero and one
print("f = 0.1", math.lerp(a, b, 0.1))

--and extrapolates linearly beyond that
print("f = -1", math.lerp(a, b, -1))
print("f = 2", math.lerp(a, b, 2))

-------------------------------------------------------------------------------
heading("smoothstep")
--lerp is commonly used to animate things procedurally
--and to make transitions smoother, you can use easing functions on the
--interpolation factor, to transform things from a linear blend to
--a non-linear blend.
local factors = {0, 0.25, 0.5, 0.75, 1.0}
print_table("factors", factors)
print_table("plain lerp", table.map(factors, function(f)
	return math.lerp(a, b, f)
end))
--a common interpolant smoothing function is smoothstep, which goes through
--the same points as usual at 0, 0.5 and 1, but ramps up and down "smoothly"
print_table("smoothstep", table.map(factors, function(f)
	return math.lerp(a, b, math.smoothstep(f))
end))
--smootherstep is a slightly more expensive extension to that which
--has slightly better properties for chained animations
print_table("smootherstep", table.map(factors, function(f)
	return math.lerp(a, b, math.smootherstep(f))
end))

--you can read more about these online :)
--batteries provides an implementation of both

-------------------------------------------------------------------------------
heading("angle handling")

--wrap any angle onto the interval [-math.pi, math.pi)
--useful for not getting extremely high angles
local big_angle = 5.5
print("big angle", big_angle)
print("normalised", math.normalise_angle(big_angle))

--get the angle between two angles
--neither required to be normalised, result is normalised
local a1 = 0.45 * math.tau
local a2 = -0.45 * math.tau
print("a1", a1)
print("a2", a2)
print("angle between", math.relative_angle(a1, a2))

--geometric rotation multi-return
--quarter turn
local ox, oy = 1, 2
print("original point", ox, oy)
local rx, ry = math.rotate(ox, oy, math.tau * 0.25)
print("quarter turn", rx, ry)
