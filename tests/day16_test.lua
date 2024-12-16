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

function TestLibrary.test_part16b()
    local content = readFile("data/day16b.txt")
    lu.assertEquals(Day16.part1(content), 11048)
end

function TestLibrary.test_part16_1()
    lu.skip("Skip test")
    local content = readFile("data/day16.txt")
    lu.assertEquals(Day16.part1(content), 11048)
end

os.exit(lu.LuaUnit.run())

