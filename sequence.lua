--
--	sequence - simple oop wrapper on ordered tables, with method chaining
--

require("common")

-------------------------------------------------------------------------------
heading("seamless")

-- everything in table and tablex work basically out of the box
-- here is the stack and queue section from the table example
-- translated, with comments stripped - looking at both
-- might help to see how things map

local t = sequence{1, 2, 3, 4, 5}
print_var("t", t)

print("front", t:front())
print("back", t:back())

v = t:pop()
print("popped", v)
print_var("after pop", t)
t:push(v)
print_var("after push", t)

v = t:shift()
print("shifted", v)
print_var("after shift", t)
t:push(v)
print_var("after push", t)

t:unshift(t:pop())
print_var("replace at front", t)

-------------------------------------------------------------------------------
heading("functional and type preserving")

-- anything sequential returned from a sequence method is also a sequence
-- allows method chaining for a sequentially readable functional approach
-- not for use in some hot inner loop, but leads to very readable code

local doubled_and_squared = t:map(function(v)
	return v * 2
end):map(function(v)
	return v * v
end)
print_var("doubled, squared", doubled_and_squared)

local min, max = doubled_and_squared:minmax()
print("min, max", min, max)

--can be used to upgrade some existing table transparently too
--(generate data here, but it could come from anywhere and look like anything)
local preexisting = functional.generate(10, function()
	return {length = love.math.random() * 100}
end)

--find the mean length
local mean_length =
	--convert
	sequence(preexisting)
	--map values
	:map(function(v)
		return v.length
	end)
	--get the mean
	:mean()

print("mean length", mean_length)
