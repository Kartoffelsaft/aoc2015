package day2

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:math"

p1 :: proc(input: []string) {
    total := 0

    for line in input {
        if strings.trim_space(line) == "" do continue

        x1 := strings.index(line, "x")
        x2 := x1+1 + strings.index(line[x1+1:], "x")

        l, lOk := strconv.parse_int(line[:x1])
        w, wOk := strconv.parse_int(line[x1+1:x2])
        h, hOk := strconv.parse_int(line[x2+1:])

        total += 2 * (l*w + w*h + h*l)
        total += math.min(math.min(l*w, w*h), h*l)
    }

    fmt.println(total)
}

p2 :: proc(input: []string) {
    total := 0

    for line in input {
        if strings.trim_space(line) == "" do continue

        x1 := strings.index(line, "x")
        x2 := x1+1 + strings.index(line[x1+1:], "x")

        l, lOk := strconv.parse_int(line[:x1])
        w, wOk := strconv.parse_int(line[x1+1:x2])
        h, hOk := strconv.parse_int(line[x2+1:])

        l, w = math.min(l, w), math.max(l, w)
        w, h = math.min(w, h), math.max(w, h)
        l, w = math.min(l, w), math.max(l, w)

        total += 2 * (l + w)
        total += l * w * h
    }

    fmt.println(total)
}
