local lu = require('luaunit')
local Day22 = require('src.day22')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part22a()
    local content = readFile("data/day22a.txt")
    lu.assertEquals(Day22.part1(content), 37327623)
end

function TestLibrary.test_part22b()
    local content = readFile("data/day22b.txt")
    lu.assertEquals(Day22.part2(content), 23)
end

function TestLibrary.test_part22_1()
    local content = readFile("data/day22.txt")
    lu.assertEquals(Day22.part1(content), 14622549304)
end

function TestLibrary.test_part22_2()
    local content = readFile("data/day22.txt")
    lu.assertEquals(Day22.part2(content), 1735)
end

os.exit(lu.LuaUnit.run())
