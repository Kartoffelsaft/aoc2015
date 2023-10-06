package day17

import "core:fmt"
import "core:strconv"
import "core:slice"

store_combos_p1 :: proc(containers: []int, amt: int) -> int {
    if amt == 0 do return 1
    if amt < 0 do return 0
    if len(containers) == 0 do return 0

    return store_combos_p1(containers[1:], amt) + store_combos_p1(containers[1:], amt - containers[0])
}

p1 :: proc(input: []string) {
    parse_int_discard :: proc(s: string) -> int {i, ok := strconv.parse_int(s); return i}
    containers := slice.mapper(input, parse_int_discard)
    defer delete(containers)

    fmt.println(store_combos_p1(containers, 150))
}

store_combos_p2 :: proc(containers: []int, amt: int, containersUsed: int) -> (combos: int, used: int) {
    if amt == 0 do return 1, containersUsed
    if amt < 0 do return 0, 9999999
    if len(containers) == 0 do return 0, 9999999

    skipping, skipUsage := store_combos_p2(containers[1:], amt, containersUsed)
    use, useUsage := store_combos_p2(containers[1:], amt - containers[0], containersUsed + 1)

    if skipUsage == useUsage do return skipping + use, skipUsage
    else if skipUsage < useUsage do return skipping, skipUsage
    else do return use, useUsage
}

p2 :: proc(input: []string) {
    parse_int_discard :: proc(s: string) -> int {i, ok := strconv.parse_int(s); return i}
    containers := slice.mapper(input, parse_int_discard)
    defer delete(containers)

    fmt.println(store_combos_p2(containers, 150, 0))
}
