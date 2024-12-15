local lu = require('luaunit')
local Day15 = require('src.day15')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part15a()
    local content = readFile("data/day15a.txt")
    lu.assertEquals(Day15.part1(content), 2028)
end

os.exit(lu.LuaUnit.run())

