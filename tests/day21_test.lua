local lu = require("luaunit")
local Day21 = require("src.day21")

TestLibrary = {}

local function readFile(path)
	local content = {}
	for line in io.lines(path) do
		table.insert(content, line)
	end

	return content
end

function TestLibrary.test_part21a_part1()
	local content = readFile("data/day21a.txt")
	lu.assertEquals(Day21.part1(content), 126384)
end

function TestLibrary.test_part21a_1()
	local content = readFile("data/day21.txt")
	lu.assertEquals(Day21.part1(content), 188398)
end

function TestLibrary.test_part21a_part2()
	lu.skip("part 2 not requested yet")
	local content = readFile("data/day21a.txt")
	lu.assertEquals(Day21.part2(content), 154115708116294)
end

os.exit(lu.LuaUnit.run())
