--work with standalone luajit
--which doesn't search the local path for init.lua style modules by default...
if not love then
	package.path = "./?/init.lua;" .. package.path
end

--load batteries globally
require("batteries"):export()

--print a named variable, prettified
function print_var(name, t)
	print(name, string.pretty(t))
end

--print a heading with a fixed-width line surrounding it
function heading(s)
	print(("-- %s %s"):format(s, ("-"):rep(50 - s:len())))
end
