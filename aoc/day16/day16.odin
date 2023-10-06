package day16

import "core:fmt"
import "core:strings"
import "core:strconv"

does_sue_match_p1 :: proc(hay: string, needle: map[string]string) -> bool {
    rest := hay[strings.index_rune(hay, ' ')+1:]
    rest = rest[strings.index_rune(rest, ' ')+1:]
    
    thingAKey := rest[:strings.index_rune(rest, ':')]
    rest = rest[strings.index_rune(rest, ' ')+1:]
    thingAValue := rest[:strings.index_rune(rest, ',')]
    rest = rest[strings.index_rune(rest, ' ')+1:]

    if thingAValue != needle[thingAKey] do return false

    thingBKey := rest[:strings.index_rune(rest, ':')]
    rest = rest[strings.index_rune(rest, ' ')+1:]
    thingBValue := rest[:strings.index_rune(rest, ',')]
    rest = rest[strings.index_rune(rest, ' ')+1:]

    if thingBValue != needle[thingBKey] do return false

    thingCKey := rest[:strings.index_rune(rest, ':')]
    rest = rest[strings.index_rune(rest, ' ')+1:]
    thingCValue := rest[:]

    if thingCValue != needle[thingCKey] do return false

    return true
}

p1 :: proc(input: []string) {
    ourSue := map[string]string {
        "children"    = "3",
        "cats"        = "7",
        "samoyeds"    = "2",
        "pomeranians" = "3",
        "akitas"      = "0",
        "vizslas"     = "0",
        "goldfish"    = "5",
        "trees"       = "3",
        "cars"        = "2",
        "perfumes"    = "1",
    }

    for line in input do if does_sue_match_p1(line, ourSue) do fmt.println(line)
}

does_sue_match_p2 :: proc(hay: string, needle: map[string]string) -> bool {
    does_val_match :: proc(key, val, tar: string) -> bool {
        if key == "cats" || key == "trees" {
            nVal, nValOk := strconv.parse_int(val)
            nTar, nTarOk := strconv.parse_int(tar)
            return nTar < nVal
        }
        if key == "pomeranians" || key == "goldfish" {
            nVal, nValOk := strconv.parse_int(val)
            nTar, nTarOk := strconv.parse_int(tar)
            return nTar > nVal
        }

        return val == tar
    }

    rest := hay[strings.index_rune(hay, ' ')+1:]
    rest = rest[strings.index_rune(rest, ' ')+1:]
    
    thingAKey := rest[:strings.index_rune(rest, ':')]
    rest = rest[strings.index_rune(rest, ' ')+1:]
    thingAValue := rest[:strings.index_rune(rest, ',')]
    rest = rest[strings.index_rune(rest, ' ')+1:]

    if !does_val_match(thingAKey, thingAValue, needle[thingAKey]) do return false

    thingBKey := rest[:strings.index_rune(rest, ':')]
    rest = rest[strings.index_rune(rest, ' ')+1:]
    thingBValue := rest[:strings.index_rune(rest, ',')]
    rest = rest[strings.index_rune(rest, ' ')+1:]

    if !does_val_match(thingBKey, thingBValue, needle[thingBKey]) do return false

    thingCKey := rest[:strings.index_rune(rest, ':')]
    rest = rest[strings.index_rune(rest, ' ')+1:]
    thingCValue := rest[:]

    if !does_val_match(thingCKey, thingCValue, needle[thingCKey]) do return false

    return true
}

p2 :: proc(input: []string) {
    ourSue := map[string]string {
        "children"    = "3",
        "cats"        = "7",
        "samoyeds"    = "2",
        "pomeranians" = "3",
        "akitas"      = "0",
        "vizslas"     = "0",
        "goldfish"    = "5",
        "trees"       = "3",
        "cars"        = "2",
        "perfumes"    = "1",
    }

    for line in input do if does_sue_match_p2(line, ourSue) do fmt.println(line)
}
