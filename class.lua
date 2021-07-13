--
--	classes and basic oop
--

require("common")

-------------------------------------------------------------------------------
heading("basic class")

--the `class` function declares a new class
local pair = class()

--the constructor is called `new`
--it can take whatever arguments you need
--and should be defined as a method using dot syntax
function pair:new(a, b)
	return self:init({
		first = a,
		second = b,
	})
end

--methods can be declared on the class
function pair:sum()
	return self.first + self.second
end

--new instances are constructed using a call to the class
local odd = pair(1, 3)
--(you can call new directly if you really want to)
local even = pair:new(2, 4)

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
local fancy_pair = class(pair)

--constructors work mostly the same,
--except arguments to the super constructor go after the table of properties
--the properties from this class are overlaid onto the fresh instance
function fancy_pair:new(a, b)
	return self:init({
		fancy = true,
	}, a, b)
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

