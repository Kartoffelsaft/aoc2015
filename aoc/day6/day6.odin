package day6

import "core:fmt"
import "core:math"
import "core:strings"
import "core:strconv"

Instr :: struct {
    what: enum {ON, OFF, TOGGLE},
    from: [2]int,
    to:   [2]int,
}

parse_line :: proc(s: string) -> (ret: Instr) {
    numsData := ""
    if s[:len("turn on ")] == "turn on " {
        ret.what = .ON
        numsData = s[len("turn on "):]
    }
    if s[:len("turn off ")] == "turn off " {
        ret.what = .OFF
        numsData = s[len("turn off "):]
    }
    if s[:len("toggle ")] == "toggle " {
        ret.what = .TOGGLE
        numsData = s[len("toggle "):]
    }

    coordA := numsData[:strings.index(numsData, " ")]
    coordB := numsData[strings.last_index(numsData, " ")+1:]

    parse_coord :: proc(s: string) -> [2]int {
        x, xOk := strconv.parse_int(s[:strings.index(s, ",")])
        y, yOk := strconv.parse_int(s[strings.index(s, ",")+1:])
        return {x, y}
    }

    ret.from = parse_coord(coordA)
    ret.to = parse_coord(coordB)

    return
}

p1 :: proc(input: []string) {
    lights := [1000][1000]bool{}

    for line in input {
        if line == "" do continue

        instr := parse_line(line)

        for i in instr.from.x..=instr.to.x do for j in instr.from.y..=instr.to.y {
            switch instr.what {
                case .ON: lights[i][j] = true
                case .OFF: lights[i][j] = false
                case .TOGGLE: lights[i][j] = !lights[i][j]
            }
        }
    }

    sum := 0
    for row in lights do for light in row {
        if light do sum += 1
    }
    fmt.println(sum)
}

p2 :: proc(input: []string) {
    lights := [1000][1000]int{}

    for line in input {
        if line == "" do continue

        instr := parse_line(line)

        for i in instr.from.x..=instr.to.x do for j in instr.from.y..=instr.to.y {
            switch instr.what {
                case .ON: lights[i][j] += 1
                case .OFF: lights[i][j] = math.max(0, lights[i][j]-1)
                case .TOGGLE: lights[i][j] += 2
            }
        }
    }

    sum := 0
    for row in lights do for light in row {
        sum += light
    }
    fmt.println(sum)
}
