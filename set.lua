--
--	set example
--

-- load helpers
require("common")

-------------------------------------------------------------------------------
heading("working sets")
local a = set({1, 2, 3,})
local b = set({3, 4, 5,})
print_var("a", a:values())
print_var("b", b:values())

-------------------------------------------------------------------------------
heading("set ops")

print_var("union", a:union(b):values())
print_var("intersection", a:intersection(b):values())
print_var("complement", a:complement(b):values())
print_var("xor", a:symmetric_difference(b):values())

-------------------------------------------------------------------------------
heading("checking membership")

print_var("a has 1", a:has(1))
print_var("a has 5", a:has(5))
print_var("b has 5", b:has(5))

-------------------------------------------------------------------------------
heading("modifying")

local c = a:copy()
print_var("copy", c:values())

print_var("add", c:add(6):values())
print_var("remove", c:remove(6):values())

print_var("add_set", c:add_set(b):values())
print_var("subtract_set", c:subtract_set(a):values())
