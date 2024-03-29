--
--	functional programming
--

-- load helpers
require("common")

-------------------------------------------------------------------------------
heading("numeric data")
-- we'll set up some example numeric data to demo the basics
local numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
print_var("numbers", numbers)

-------------------------------------------------------------------------------
heading("map and filter")
-- map and filter are the "go to" functional programming primitives
-- map creates a new table with each member replaced with the result
-- of a function call.

-- lets map each value to its square
print_var("squares", functional.map(numbers, function(v)
	return v * v
end))

-- filter creates a new table containing only the elements for
-- which the passed function returns true

-- filter only the even elements
print_var("even", functional.filter(numbers, function(v)
	return (v % 2) == 0
end))

---map tables by their keys into one sequence
local tables = {
	{a = 1, b = 4},
	{a = 2, b = 5},
	{a = 3, b = 6},
}
print_var("mapped_field", functional.map_field(tables, "b"))

-- map objects by their function call results
-- or map objects into a sequence from the result of a function
function my_function(element, one, two)
	local x, y = element:unpack()
	return (one * x) * (two * y)
end

local vectors = {
	vec2(4, 20),
	vec2(6, 9)
}
print_var("mapped_seq_a", functional.map_call(vectors, "rotate", math.pi))
print_var("mapped_seq_b", functional.map_call(vectors, my_function, 1, 2))

-------------------------------------------------------------------------------
heading("aggregate")
-- these functions work on the passed table as an aggregate, returning
-- some information about the collection as a whole

-- sum adds up all the elements
local sum = functional.sum(numbers)
print("sum", sum)

-- mean gets the average of all the elements
local mean = functional.mean(numbers)
print("mean", mean)

-- minmax gets the minimum and maximum in a single pass
-- there are separate min and max functions if you just need one :)
local min, max = functional.minmax(numbers)
print("min", min, "max", max)

-- all checks that all members pass a certain test
print("all numbers", functional.all(numbers, function(v)
	return type(v) == "number"
end))
-- any checks if any member passes the test
print("any functions", functional.any(numbers, function(v)
	return type(v) == "function"
end))
-- none checks that no member passes
print("no strings", functional.none(numbers, function(v)
	return type(v) == "string"
end))
-- count tallies up the number of matches;
-- in this case, we count the multiples of 3
print("count 3 * n", functional.count(numbers, function(v)
	return (v % 3) == 0
end))
-- contains checks if a specific element is present
print("contains 7", functional.contains(numbers, 7))

-------------------------------------------------------------------------------
heading("partition and zip")
-- partition and zip are sort of the opposite of each other

-- partition is a two part filter;
-- those that pass the test are returned in one table,
-- and those that dont are returned in another.

-- zip takes two tables of the same length and combines the
-- elements together into a single table.

-- lets partition the numbers into halves,
-- and then zip them together as a sum of each pair
local bottom, top = functional.partition(numbers, function(v)
	return v <= mean
end)
print_var("bottom", bottom)
print_var("top", top)
print_var("zip", functional.zip(bottom, top, function(a, b)
	return a + b
end))

-------------------------------------------------------------------------------
heading("table data")

-- now we'll do some examples with more complex input data
local seq_pairs = {{1, 2}, {3, 4}, {5, 6}, {7, 8}}
print_var("seq pairs", seq_pairs)

-- find_min and find_max can be used to perform a search on some data
-- this can be very useful for performing things like nearest neighbour
-- searches, or getting the most dangerous enemy out of those visible

-- note that we're passing in functional.sum here as the function argument
-- but any function that returns a numeric result works
local sum = functional.sum

print_var("pair min sum", functional.find_min(seq_pairs, sum))
print_var("pair max sum", functional.find_max(seq_pairs, sum))

-- find_nearest can be useful if you have a specific value in mind
-- but often a find_min or find_max will result in clearer code
print_var("sum nearest 10", functional.find_nearest(seq_pairs, sum, 10))

-- find_match can be used as a single-element filter; it can save
-- creating another table if you only need one result
print_var("second elem 8", functional.find_match(seq_pairs, function(v)
	return v[2] == 8
end))
-- if no matching element exists, you get nil
print_var("both even", functional.find_match(seq_pairs, function(v)
	return (v[1] % 2) == 0
		and (v[2] % 2) == 0
end))

-------------------------------------------------------------------------------
-- heading("a little more complex")
-- todo: a nice more complex "gamey" example that highlights the benefits of
--		not mutating the input and the more self-documenting nature
--		of the query functions

-- that's it for now!
