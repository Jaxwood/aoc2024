local lu = require('luaunit')
local Day21 = require('src.day21')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part21a()
    local content = readFile("data/day21a.txt")
    lu.assertEquals(Day21.part1(content), 126384)
end

os.exit(lu.LuaUnit.run())

