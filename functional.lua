--[[
	functional programming example for batteries
]]

--load helpers
require("common")

-------------------------------------------------------------------------------
heading("numeric data")
--we'll set up some example numeric data to demo the basics
local numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
print_table("numbers", numbers)

-------------------------------------------------------------------------------
heading("map and filter")
--map and filter are the "go to" functional programming primitives
--map creates a new table with each member replaced with the result
--of a function call.

--lets map each value to its square
print_table("squares", functional.map(numbers, function(v)
	return v * v
end))

--filter creates a new table containing only the elements for
--which the passed function returns true

--filter only the even elements
print_table("even", functional.filter(numbers, function(v)
	return (v % 2) == 0
end))

-------------------------------------------------------------------------------
heading("aggregate")
--these functions work on the passed table as an aggregate, returning
--some information about the collection as a whole

--sum adds up all the elements
local sum = functional.sum(numbers)
print("sum", sum)

--mean gets the average of all the elements
local mean = functional.mean(numbers)
print("mean", mean)

--minmax gets the minimum and maximum in a single pass
--there are separate min and max functions if you just need one :)
local min, max = functional.minmax(numbers)
print("min", min, "max", max)

--all checks that all members pass a certain test
print("all numbers", functional.all(numbers, function(v)
	return type(v) == "number"
end))
--any checks if any member passes the test
print("any functions", functional.any(numbers, function(v)
	return type(v) == "function"
end))
--none checks that no member passes
print("no strings", functional.none(numbers, function(v)
	return type(v) == "string"
end))
--count tallies up the number of matches;
--in this case, we count the multiples of 3
print("count 3 * n", functional.count(numbers, function(v)
	return (v % 3) == 0
end))
--contains checks if a specific element is present
print("contains 7", functional.contains(numbers, 7))

-------------------------------------------------------------------------------
heading("partition and zip")
--partition and zip are sort of the opposite of each other

--partition is a two part filter;
--those that pass the test are returned in one table,
--and those that dont are returned in another.

--zip takes two tables of the same length and combines the
--elements together into a single table.

--lets partition the numbers into halves,
--and then zip them together as a sum of each pair
local bottom, top = functional.partition(numbers, function(v)
	return v <= mean
end)
print_table("bottom", bottom)
print_table("top", top)
print_table("zip", functional.zip(bottom, top, function(a, b)
	return a + b
end))

-------------------------------------------------------------------------------
heading("table data")
--now we'll do some examples with more complex input data
local seq_pairs = {{1, 2}, {3, 4}, {5, 6}, {7, 8}}
print_table("seq pairs", seq_pairs)

--find_min and find_max can be used to perform a search on some data
--this can be very useful for performing things like nearest neighbour
--searches, or getting the most dangerous enemy out of those visible

--note that we're passing in functional.sum here as the function argument
--but any function that returns a numeric result works
print_table("pair min sum", functional.find_min(seq_pairs, functional.sum))
print_table("pair max sum", functional.find_max(seq_pairs, functional.sum))

--find_nearest can be useful if you have a specific value in mind
--but often a find_min or find_max will result in clearer code
print_table("sum nearest 10", functional.find_nearest(seq_pairs, functional.sum, 10))

--find_match can be used as a single-element filter; it can save
--creating another table if you only need one result
print_table("second elem 8", functional.find_match(seq_pairs, function(v)
	return v[2] == 8
end))
--if no matching element exists, you get nil
print_table("both even", functional.find_match(seq_pairs, function(v)
	return (v[1] % 2) == 0
		and (v[2] % 2) == 0
end))

-------------------------------------------------------------------------------
--heading("a little more complex")
--todo: a nice more complex "gamey" example that highlights the benefits of
--		not mutating the input and the more self-documenting nature
--		of the query functions

--that's it for now!
