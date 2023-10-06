package day9

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"
import "core:math"

DistPair :: struct {
    locations: [2]string,
    distance: int,
}
parse_dist_pair :: proc(s: string) -> DistPair {
    t, splitOk := strings.split(s, " ")
    defer delete(t)
    d, dOk := strconv.parse_int(t[4])

    return {{t[0], t[2]}, d}
}

visit_locations_p1 :: proc(dists: []DistPair, visited: ^map[string]struct{}, at: string) -> int {
    visited[at] = {}
    defer delete_key(visited, at)

    shortest := 0

    for pair in dists {
        if pair.locations[0] == at && !(pair.locations[1] in visited) {
            d := pair.distance + visit_locations_p1(dists, visited, pair.locations[1])
            if shortest == 0 do shortest = d
            else do shortest = math.min(d, shortest)
        }
        if pair.locations[1] == at && !(pair.locations[0] in visited) {
            d := pair.distance + visit_locations_p1(dists, visited, pair.locations[0])
            if shortest == 0 do shortest = d
            else do shortest = math.min(d, shortest)
        }
    }

    return shortest
}

p1 :: proc(input: []string) {
    dists := slice.mapper(input[:len(input)-1], parse_dist_pair)
    defer delete(dists)
    visits := make(map[string]struct{})
    defer delete(visits)

    locations: []string: {
        "Faerun",
        "Norrath",
        "Tristram",
        "AlphaCentauri",
        "Arbre",
        "Snowdin",
        "Tambi",
        "Straylight",
    }

    for loc in locations {
        fmt.println(visit_locations_p1(dists, &visits, loc))
    }
}

visit_locations_p2 :: proc(dists: []DistPair, visited: ^map[string]struct{}, at: string) -> int {
    visited[at] = {}
    defer delete_key(visited, at)

    longest := 0

    for pair in dists {
        if pair.locations[0] == at && !(pair.locations[1] in visited) {
            d := pair.distance + visit_locations_p2(dists, visited, pair.locations[1])
            longest = math.max(longest, d)
        }
        if pair.locations[1] == at && !(pair.locations[0] in visited) {
            d := pair.distance + visit_locations_p2(dists, visited, pair.locations[0])
            longest = math.max(longest, d)
        }
    }

    return longest
}
p2 :: proc(input: []string) {
    dists := slice.mapper(input[:len(input)-1], parse_dist_pair)
    defer delete(dists)
    visits := make(map[string]struct{})
    defer delete(visits)

    locations: []string: {
        "Faerun",
        "Norrath",
        "Tristram",
        "AlphaCentauri",
        "Arbre",
        "Snowdin",
        "Tambi",
        "Straylight",
    }

    for loc in locations {
        fmt.println(visit_locations_p2(dists, &visits, loc))
    }
}
