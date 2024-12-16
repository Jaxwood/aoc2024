local lu = require('luaunit')
local Day16 = require('src.day16')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part16a()
    local content = readFile("data/day16a.txt")
    lu.assertEquals(Day16.part1(content), 7036)
end

os.exit(lu.LuaUnit.run())

