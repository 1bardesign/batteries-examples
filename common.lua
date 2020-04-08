--work with standalone luajit
--which doesn't search the local path for init.lua style modules by default...
if not love then
	package.path = "./?/init.lua;" .. package.path
end

--load batteries globally
require("batteries"):export()

--print a named table, stringified
function print_table(name, t)
	print(name, table.stringify(t))
end

function heading(s)
	print(("-- %s %s"):format(s, ("-"):rep(50 - s:len())))
end
