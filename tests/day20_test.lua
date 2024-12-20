local lu = require('luaunit')
local Day20 = require('src.day20')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part20a()
    local content = readFile("data/day20a.txt")
    lu.assertEquals(Day20.part1(content), 84)
end

os.exit(lu.LuaUnit.run())


