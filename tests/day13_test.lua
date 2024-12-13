local lu = require('luaunit')
local Day13 = require('src.day13')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part13a()
    local content = readFile("data/day13a.txt")
    lu.assertEquals(Day13.part1(content, 0), 480)
end

function TestLibrary.test_part13_1()
    local content = readFile("data/day13.txt")
    lu.assertEquals(Day13.part1(content, 0), 34787)
end

function TestLibrary.test_part13_2()
    lu.skip("Skip part 2")
    local content = readFile("data/day13.txt")
    lu.assertEquals(Day13.part1(content, 10000000000000), 85644161121698)
end

os.exit(lu.LuaUnit.run())

