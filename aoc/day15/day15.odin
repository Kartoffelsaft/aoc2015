package day15

import "core:fmt"
import "core:strconv"
import "core:strings"
import "core:math"
import "core:slice"

Ingredient :: struct{
    capacity: int,
    durability: int,
    flavor: int,
    texture: int,
    calories: int,
}

parse_ingredient :: proc(s: string) -> Ingredient {
    rest := s
    stats := [5]int{}

    for i in 0..<5 {
        nextNumEnd := strings.index_rune(rest, ',')
        if nextNumEnd == -1 do nextNumEnd = len(rest)

        nextNumBegin := strings.last_index(rest[:nextNumEnd], " ")
        ok: bool = ---
        stats[i], ok = strconv.parse_int(rest[nextNumBegin+1:nextNumEnd])

        rest = rest[math.min(nextNumEnd+1, len(rest)):]
    }

    return transmute(Ingredient)stats
}

CookieIter :: struct{
    total: int,
    ings: []int,
}
next_cookie :: proc(iter: ^CookieIter) -> (more: bool) {
    for ing, i in iter.ings {
        iter.ings[i] += 1
        if math.sum(iter.ings) > iter.total {
            iter.ings[i] = 0
        } else do return true
    }

    for ing in iter.ings do if ing != 0 do return true
    return false
}
get_cookie_score :: proc(cookie: CookieIter, ings: []Ingredient) -> int {
    get_ingredient_score :: proc(ing: Ingredient, amt: int) -> [4]int {
        return amt * [4]int{ing.capacity, ing.durability, ing.flavor, ing.texture}
    }

    totalScores := [4]int{0, 0, 0, 0}
    for i in 0..<len(cookie.ings) {
        totalScores += get_ingredient_score(ings[i], cookie.ings[i])
    }
    totalScores += get_ingredient_score(ings[len(ings)-1], cookie.total - math.sum(cookie.ings))

    for score in totalScores do if score < 0 do return 0
    return totalScores[0] *totalScores[1] * totalScores[2] * totalScores[3]
}
get_cookie_calories :: proc(cookie: CookieIter, ings: []Ingredient) -> int {
    total := 0
    for i in 0..<len(cookie.ings) do total += cookie.ings[i] * ings[i].calories
    total += (cookie.total - math.sum(cookie.ings)) * ings[len(ings)-1].calories

    return total
}

p1 :: proc(input: []string) {
    ings := slice.mapper(input, parse_ingredient)
    defer delete(ings)
    iter := CookieIter{
        total = 100,
        ings = make([]int, len(ings)-1),
    }
    defer delete(iter.ings)

    best := get_cookie_score(iter, ings)
    for next_cookie(&iter) {
        score := get_cookie_score(iter, ings)
        if score > best {
            best = score
            fmt.printf("new best (%i): %v\n", score, iter.ings)
        }
    }
}

p2 :: proc(input: []string) {
    ings := slice.mapper(input, parse_ingredient)
    defer delete(ings)
    iter := CookieIter{
        total = 100,
        ings = make([]int, len(ings)-1),
    }
    defer delete(iter.ings)

    best := get_cookie_score(iter, ings)
    for next_cookie(&iter) {
        if get_cookie_calories(iter, ings) != 500 do continue
        score := get_cookie_score(iter, ings)
        if score > best {
            best = score
            fmt.printf("new best (%i): %v\n", score, iter.ings)
        }
    }
}
