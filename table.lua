--
--	table extension routines
--

require("common")

-- (temp storage)
local v

-------------------------------------------------------------------------------
heading("stack and queue")

local t = {1, 2, 3, 4, 5}
print_var("t", t)

-- front and back can be slightly clearer than directly indexing
-- (moreso for back than front, for variables with long names)
print("front", table.front(t))
print("back", table.back(t))

-- push/pop and shift/unshift are like in many other languages (eg js),
-- allowing queue and stack operation

-- push and pop can be used for stack operation, adding and removing values
-- at the back of the table in a "last-in, first-out" order
v = table.pop(t)
print("popped", v)
print_var("after pop", t)
table.push(t, v)
print_var("after push", t)

-- push and shift can be used for queue operation; "first-in, first-out"

v = table.shift(t)
print("shifted", v)
print_var("after shift", t)
table.push(t, v)
print_var("after push", t)

-- unshift is a push at the front of the table, allowing fully
-- double-ended interaction
table.unshift(t, table.pop(t, v))
print_var("replace at front", t)

-------------------------------------------------------------------------------
heading("collection management")

-- index_of can be used to find the index of a value
print("4 at", table.index_of(t, 4))
-- or nil if the value is not present
print("'monkey' at", tostring(table.index_of(t, "monkey")))
-- key_of does the same for non-sequential tables
print("key search", table.key_of({
	a = 1,
	b = 2,
}, 1))

-- add_value and remove_value avoid doubling up values in sequential tables
-- and allow removing by a value rather than index (including references,
-- such as to an ai target or inventory item)
-- they return whether anything was actually added or removed
print_var("state before", t)
print("add 5?", table.add_value(t, 5))
print_var("failed add", t)
print("remove 5?", table.remove_value(t, 5))
print_var("after remove", t)
print("remove 5 again?", table.remove_value(t, 5))
print_var("failed remove", t)
print("add 5 again?", table.add_value(t, 5))
print_var("after re-add", t)

-- careful; they perform a scan (ipairs) over the whole table though so
-- should not be used too heavily with big tables!

-------------------------------------------------------------------------------
heading("randomisation")

t = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
-- pick_random can choose a random variable from a table
-- prefers love.math.random over math.random but works with both
-- (results here will change with each run)
print_var("random pick", table.pick_random(t))
print_var("random pick", table.pick_random(t))
print_var("random pick", table.pick_random(t))
print_var("random pick", table.pick_random(t))

-- you may like to pass in a random generator to get deterministic results
-- for example in a world generator or for network sync or whatever
-- just pass it into the call and it'll be used
-- (anything that supports gen:random(min, max) will work)
local seed = 1234
local gen = love.math.newRandomGenerator(seed)
print_var("deterministic", table.pick_random(t, gen))

-- shuffle does what it says on the tin
-- it also takes an optional random generator with the same requirements
-- as pick_random; a call is made for each element of the table in both cases
print_var("shuffle order", table.shuffle(t))

-- todo:
-- table.reverse(t)
-- table.keys(t)
-- table.values(t)
-- table.append_inplace(t1, t2)
-- table.append(t1, t2)
-- table.dedupe(t)
-- table.clear(t) + explain luajit differences but why it's supported
-- table.copy(t, deep_or_into) + explain dissatisfaction
-- table.overlay(to, from)
-- table.unpack2(t) and friends + explain why
