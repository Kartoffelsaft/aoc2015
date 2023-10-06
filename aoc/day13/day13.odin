package day13

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:math"
import "core:slice"

Preference :: struct {
    whom: string,
    bias: int,
}
parse_prefs :: proc(input: []string) -> (ret: map[string][dynamic]Preference) {
    ret = make_map(map[string][dynamic]Preference)

    for line in input {
        if line == "" do continue

        rest := line

        whoEnd := strings.index_rune(rest, ' ')
        who := rest[:whoEnd]
        rest = rest[whoEnd + len(" would "):]

        invertBias := rest[:4] == "lose"
        rest = rest[len("lose "):]

        biasEnd := strings.index_rune(rest, ' ')
        bias, biasOk := strconv.parse_int(rest[:biasEnd])
        if invertBias do bias *= -1
        rest = rest[biasEnd + len(" happiness units by sitting next to "):]
        
        whom := rest[:len(rest)-len(".")]

        if !(who in ret) do ret[who] = make([dynamic]Preference)
        append(&ret[who], Preference{whom, bias})
    }

    return
}

find_optimal_seating :: proc(prefs: map[string][dynamic]Preference, seated: ^[dynamic]string, who: string) -> (best: int, arrangement: []string) {
    find_specific_pref :: proc(prefs: map[string][dynamic]Preference, who: string, whom: string) -> int {
        for finalPref in prefs[who] {
            if finalPref.whom != whom do continue

            return finalPref.bias
        }
        return -1
    }

    append(seated, who)
    defer pop(seated)

    if len(seated) == len(prefs) {
        return find_specific_pref(prefs, who, seated[0]) + find_specific_pref(prefs, seated[0], who), slice.clone(seated[:])
    }

    best = -9999999999
    arrangement = make([]string, 0)
    whos_prefs: for pref in prefs[who] {
        for seat in seated do if pref.whom == seat do continue whos_prefs
        
        change, nArrangement := find_optimal_seating(prefs, seated, pref.whom)
        change += pref.bias + find_specific_pref(prefs, pref.whom, who)

        if best < change {
            best = change
            delete(arrangement)
            arrangement = nArrangement
        }
    }

    return best, arrangement
}

p1 :: proc(input: []string) {
    prefs := parse_prefs(input)
    defer delete(prefs)
    seats := make([dynamic]string)
    defer delete(seats)

    people: []string: {
        "Alice",
        "Bob",
        "Carol",
        "David",
        "Eric",
        "Frank",
        "George",
        "Mallory",
    }

    best := -9999999999
    for person in people {
        change, arr := find_optimal_seating(prefs, &seats, person)
        best = math.max(best, change)
        fmt.printf("%s:       \t%v\t%i\n", person, arr, change)
    }

    fmt.println(best)
}

p2 :: proc(input: []string) {
    prefs := parse_prefs(input)
    defer delete(prefs)
    seats := make([dynamic]string)
    defer delete(seats)

    people: []string: {
        "Alice",
        "Bob",
        "Carol",
        "David",
        "Eric",
        "Frank",
        "George",
        "Mallory",
    }

    for who, &pref in prefs {
        append(&pref, Preference{"me", 0})
    }
    prefs["me"] = make([dynamic]Preference)
    for person in people do append(&prefs["me"], Preference{person, 0})

    best, arr := find_optimal_seating(prefs, &seats, "me")
    for person in people {
        change, arr := find_optimal_seating(prefs, &seats, person)
        best = math.max(best, change)
        fmt.printf("%s:       \t%v\t%i\n", person, arr, change)
    }

    fmt.println(best)
}
