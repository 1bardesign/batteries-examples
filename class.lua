--
--	classes and basic oop
--

require("common")

-------------------------------------------------------------------------------
heading("basic class")

--the `class` function declares a new class
local pair = class({
	name = "pair",
})

--the constructor is called `new`
--it can take whatever arguments you need
--and should be defined as a method using dot syntax
function pair:new(a, b)
	self.first = a
	self.second = b
end

--methods can be declared on the class
function pair:sum()
	return self.first + self.second
end

--new instances are constructed using a call to the class
local odd = pair(1, 3)
local even = pair(2, 4)

--instances store their own properties
print_var("odd", odd)
print_var("even", even)

--methods of the class can be called on instances
print_var("odd sum", odd:sum())
print_var("even sum", even:sum())

-------------------------------------------------------------------------------
heading("inheritance")

--a class that inherits from another is defined
--by passing the superclass to the `class` function
local fancy_pair = class({
	name = "fancy pair",
	extends = pair
})

--constructors work mostly the same,
--except you need to call the super constructor somehow
function fancy_pair:new(a, b)
	self:super(a, b)
	self.fancy = true
end

--new methods can be declared on the class
--and they can use properties from the superclass
function fancy_pair:product()
	return self.first * self.second
end

--instances are constructed the same way
local fancy = fancy_pair(3, 5)
print_var("fancy pair", fancy)
--methods from the super class can be used
print_var("fancy sum", fancy:sum())
--as well as the freshly extended methods
print_var("fancy product", fancy:product())

-------------------------------------------------------------------------------
heading("mixins or interfaces")

--whatever you know them by, classes can implement as many of them as needed
--they are overlaid onto the class in the order provided
--(ie the first interface takes precedence)

--they can be proper classes
local pair_add = class({
	name = "pair_add",
})
function pair_add:add(v)
	self.first = self.first + v
	self.second = self.second + v
end

--or just plain tables with function keys
local pair_sub = {}
function pair_sub:sub(v)
	self.first = self.first - v
	self.second = self.second - v
end

--a new class that extends pair and implements both interfaces
local addsub_pair = class({
	name = "addsub_pair",
	extends = pair,
	implements = {pair_add, pair_sub},
})

--(by default the constructor is just the super constructor,
--so we don't need anything new)

local p = addsub_pair(2, 5)
print_var("p as constructed", p)
p:add(2)
print_var("p after add 2", p)
p:sub(4)
print_var("p after sub 4", p)

-------------------------------------------------------------------------------
heading("dynamic typing stuff")

--generally recommended against leveraging this too hard, but can be
--a useful escape hatch sometimes

--various membership cases:
--base class is true
print_var("p is pair", p:is(pair))
--concrete class is true
print_var("p is pair_add", p:is(pair_add))
--sibling class is false
print_var("p is fancy_pair", p:is(fancy_pair))
--implemented interfaces are true
print_var("p is addsub_pair", p:is(addsub_pair))

