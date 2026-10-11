local lu = require('luaunit')
local Day23 = require('src.day23')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part23a_1()
    local content = readFile("data/day23a.txt")
    lu.assertEquals(Day23.part1(content), 7)
end

function TestLibrary.test_part23a_2()
    local content = readFile("data/day23a.txt")
    lu.assertEquals(Day23.part2(content), "co,de,ka,ta")
end

function TestLibrary.test_part23_1()
    local content = readFile("data/day23.txt")
    lu.assertEquals(Day23.part1(content), 1253)
end

function TestLibrary.test_part23_2()
    local content = readFile("data/day23.txt")
    lu.assertEquals(Day23.part2(content), "ag,bt,cq,da,hp,hs,mi,pa,qd,qe,qi,ri,uq")
end

os.exit(lu.LuaUnit.run())
