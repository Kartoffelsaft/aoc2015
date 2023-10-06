package day1

import "core:fmt"

p1 :: proc(input: []string) {
    total := 0
    for c in input[0] do switch c {
        case '(': total += 1
        case ')': total -= 1
    }

    fmt.println(total)
}

p2 :: proc(input: []string) {
    steps := 1
    total := 0
    for c in input[0] {
        switch c {
            case '(': total += 1
            case ')': total -= 1
        }

        if total <= -1 {
            fmt.println(steps)
            return
        }

        steps += 1
    }

}
