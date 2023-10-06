package day18

import "core:fmt"

Grid :: [100][100]bool

parse_grid :: proc(s: []string) -> (g: Grid) {
    for i in 0..<100 do for j in 0..<100 do g[i][j] = s[i][j] == '#'

    return g
}

step_grid :: proc(inp: Grid) -> (out: Grid) {
    for i in 0..<100 do for j in 0..<100 {
        neighbors := 0

        if i > 0  && j > 0  && inp[i-1][j-1] do neighbors += 1
        if i > 0  &&           inp[i-1][j  ] do neighbors += 1
        if i > 0  && j < 99 && inp[i-1][j+1] do neighbors += 1
        if           j > 0  && inp[i  ][j-1] do neighbors += 1
        if           j < 99 && inp[i  ][j+1] do neighbors += 1
        if i < 99 && j > 0  && inp[i+1][j-1] do neighbors += 1
        if i < 99 &&           inp[i+1][j  ] do neighbors += 1
        if i < 99 && j < 99 && inp[i+1][j+1] do neighbors += 1

        if inp[i][j] {
            out[i][j] = neighbors == 2 || neighbors == 3
        } else {
            out[i][j] = neighbors == 3
        }
    }

    return out
}

p1 :: proc(input: []string) {
    grid := parse_grid(input)

    for _ in 0..<100 do grid = step_grid(grid)

    total := 0
    for i in 0..<100 do for j in 0..<100 do if grid[i][j] do total += 1

    fmt.println(total)
}

p2 :: proc(input: []string) {
    grid := parse_grid(input)
    grid[ 0][ 0] = true
    grid[99][ 0] = true
    grid[ 0][99] = true
    grid[99][99] = true

    for _ in 0..<100 {
        grid = step_grid(grid)
        grid[ 0][ 0] = true
        grid[99][ 0] = true
        grid[ 0][99] = true
        grid[99][99] = true
    }

    total := 0
    for i in 0..<100 do for j in 0..<100 do if grid[i][j] do total += 1

    fmt.println(total)
}
