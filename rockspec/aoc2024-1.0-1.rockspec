package = "aoc2024"
version = "1.0-1"

source = {
    url = "git://github.com/jaxwood/aoc2024.git",
    tag = "v1.0"
}

description = {
    summary = "Advent of Code 2024",
    license = "MIT"
}

dependencies = {
    "lua >= 5.4",
    "luaunit >= 3.4"
}

build = {
   type = "builtin",
   modules = {
       ["aoc2024.Day01"] = "src/day01.lua",
       ["aoc2024.Day02"] = "src/day02.lua",
       ["aoc2024.Day03"] = "src/day03.lua",
       ["aoc2024.Day04"] = "src/day04.lua",
       ["aoc2024.Day05"] = "src/day05.lua",
       ["aoc2024.Day06"] = "src/day06.lua",
       ["aoc2024.Day07"] = "src/day07.lua",
       ["aoc2024.Day08"] = "src/day08.lua",
       ["aoc2024.Day09"] = "src/day09.lua",
       ["aoc2024.Day10"] = "src/day10.lua",
       ["aoc2024.Day11"] = "src/day11.lua",
   }
}
