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
    "luaunit >= 3.4",
    "binaryheap >= 0.4.1"
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
       ["aoc2024.Day12"] = "src/day12.lua",
       ["aoc2024.Day13"] = "src/day13.lua",
       ["aoc2024.Day14"] = "src/day14.lua",
       ["aoc2024.Day15"] = "src/day15.lua",
       ["aoc2024.Day16"] = "src/day16.lua",
       ["aoc2024.Day17"] = "src/day17.lua",
       ["aoc2024.Day18"] = "src/day18.lua",
       ["aoc2024.Day19"] = "src/day19.lua",
       ["aoc2024.Day20"] = "src/day20.lua",
   }
}
