package aoc

import "core:os"
import "core:fmt"
import "core:strings"
import "core:io"

import "day1"
import "day2"
import "day3"
import "day4"
import "day5"
import "day6"
import "day7"
import "day8"
import "day9"
import "day10"
import "day11"
import "day12"
import "day13"
import "day14"
import "day15"
import "day16"
import "day17"
import "day18"
import "day19"
import "day20"
import "day21"
import "day22"
import "day23"
import "day24"
import "day25"

dayMap: map[string]proc([]string) = {
    "1p1"  = day1 .p1,
    "1p2"  = day1 .p2,
    "2p1"  = day2 .p1,
    "2p2"  = day2 .p2,
    "3p1"  = day3 .p1,
    "3p2"  = day3 .p2,
    "4p1"  = day4 .p1,
    "4p2"  = day4 .p2,
    "5p1"  = day5 .p1,
    "5p2"  = day5 .p2,
    "6p1"  = day6 .p1,
    "6p2"  = day6 .p2,
    "7p1"  = day7 .p1,
    "7p2"  = day7 .p2,
    "8p1"  = day8 .p1,
    "8p2"  = day8 .p2,
    "9p1"  = day9 .p1,
    "9p2"  = day9 .p2,
    "10p1" = day10.p1,
    "10p2" = day10.p2,
    "11p1" = day11.p1,
    "11p2" = day11.p2,
    "12p1" = day12.p1,
    "12p2" = day12.p2,
    "13p1" = day13.p1,
    "13p2" = day13.p2,
    "14p1" = day14.p1,
    "14p2" = day14.p2,
    "15p1" = day15.p1,
    "15p2" = day15.p2,
    "16p1" = day16.p1,
    "16p2" = day16.p2,
    "17p1" = day17.p1,
    "17p2" = day17.p2,
    "18p1" = day18.p1,
    "18p2" = day18.p2,
    "19p1" = day19.p1,
    "19p2" = day19.p2,
    "20p1" = day20.p1,
    "20p2" = day20.p2,
    "21p1" = day21.p1,
    "21p2" = day21.p2,
    "22p1" = day22.p1,
    "22p2" = day22.p2,
    "23p1" = day23.p1,
    "23p2" = day23.p2,
    "24p1" = day24.p1,
    "24p2" = day24.p2,
    "25p1" = day25.p1,
    "25p2" = day25.p2,
}

main :: proc() {
    if len(os.args) < 2 {
        fmt.println("need day and part")
        return
    }

    if !(os.args[1] in dayMap) {
        fmt.println("invalid day/part")
        return
    }

    dayFileName, dayFileNameErr := strings.concatenate({"input/", os.args[1][:strings.index(os.args[1], "p")]})
    defer delete(dayFileName)
    dayFileContents, dayFileContentsErr := os.read_entire_file(dayFileName)
    defer delete(dayFileContents)
    dayFileTrimmed := strings.trim_space(string(dayFileContents))
    dayFileLines, dayFileLinesErr := strings.split_lines(dayFileTrimmed)
    defer delete(dayFileLines)

    dayMap[os.args[1]](dayFileLines)
}
