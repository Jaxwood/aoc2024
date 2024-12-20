local lu = require('luaunit')
local Day19 = require('src.day19')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part19a()
    local content = readFile("data/day19a.txt")
    lu.assertEquals(Day19.part1(content), 6)
end

os.exit(lu.LuaUnit.run())


