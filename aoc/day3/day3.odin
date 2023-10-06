package day3

import "core:fmt"

p1 :: proc(input: []string) {
    presents: map[[2]int]int = {}
    defer delete(presents)

    pos: [2]int = {0, 0}

    for c in input[0] {
        switch c {
            case '^': pos += { 0,  1}
            case 'v': pos += { 0, -1}
            case '>': pos += { 1,  0}
            case '<': pos += {-1,  0}
        }

        if pos in presents do presents[pos] += 1
        else do presents[pos] = 1
    }

    fmt.println(len(presents))
}

p2 :: proc(input: []string) {
    presents: map[[2]int]int = {}
    defer delete(presents)

    pos: [2][2]int = {{0, 0}, {0, 0}}

    for c, i in input[0] {
        switch c {
            case '^': pos[i%2] += { 0,  1}
            case 'v': pos[i%2] += { 0, -1}
            case '>': pos[i%2] += { 1,  0}
            case '<': pos[i%2] += {-1,  0}
        }

        if pos[i%2] in presents do presents[pos[i%2]] += 1
        else do presents[pos[i%2]] = 1
    }

    fmt.println(len(presents))
}
