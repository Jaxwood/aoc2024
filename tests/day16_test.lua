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

function TestLibrary.test_part16a_part1()
    local content = readFile("data/day16a.txt")
    lu.assertEquals(Day16.part1(content), 7036)
end

function TestLibrary.test_part16b_part1()
    local content = readFile("data/day16b.txt")
    lu.assertEquals(Day16.part1(content), 11048)
end

function TestLibrary.test_part16a_part2()
    local content = readFile("data/day16a.txt")
    lu.assertEquals(Day16.part2(content), 45)
end

function TestLibrary.test_part16b_part2()
    local content = readFile("data/day16b.txt")
    lu.assertEquals(Day16.part2(content), 64)
end

function TestLibrary.test_part16_1()
    lu.skip("slow")
    local content = readFile("data/day16.txt")
    lu.assertEquals(Day16.part1(content), 85420)
end

function TestLibrary.test_part16_2()
    lu.skip("slow")
    local content = readFile("data/day16.txt")
    lu.assertEquals(Day16.part2(content), 492)
end

os.exit(lu.LuaUnit.run())
