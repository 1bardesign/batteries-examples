--
--	pathfinding example
--

-- load helpers
require("common")

-------------------------------------------------------------------------------
--generate some nodes
local nodes = {}
for x = 1, 5 do
	for y = 1, 5 do
		table.insert(nodes, vec2(x, y))
	end
end

-------------------------------------------------------------------------------
--lets find from the top left corner to the bottom right corner
local a = table.front(nodes)
local b = table.back(nodes)
print_var("a", a)
print_var("b", b)

local path = pathfind {
	start = a,
	is_goal = function(v) return v == b end,
	neighbours = function(n)
		--find all the neighbour nodes within a distance of 2 units
		--note: for real code you should definitely cache this or do it some faster way :)
		return functional.filter(nodes, function(v)
			return v:distance(n) < 2
		end)
	end,
	distance = vec2.distance,
	heuristic = function(v) return v:distance(b) end,
}

print_var("path", path)

--todo: interactive example
