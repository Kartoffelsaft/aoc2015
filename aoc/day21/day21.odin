package day21

import "core:fmt"
import "core:math"
import "core:strconv"
import "core:strings"

Equipable :: struct {
    cost: int,
    damage: int,
    defense: int,
}
Loadout :: struct {
    health: int,
    cost: int,
    damage: int,
    defense: int,
}
LoadoutIter :: struct {
    weapon: int,
    armor: int,
    ringL: int,
    ringR: int,
}

weapons := []Equipable{
    { 8, 4, 0},
    {10, 5, 0},
    {25, 6, 0},
    {40, 7, 0},
    {74, 8, 0},
}

armor := []Equipable{
    {  0, 0, 0},
    { 13, 0, 1},
    { 31, 0, 2},
    { 53, 0, 3},
    { 75, 0, 4},
    {102, 0, 5},
}

rings := []Equipable {
    {  0, 0, 0},
    {  0, 0, 0},
    { 25, 1, 0},
    { 50, 2, 0},
    {100, 3, 0},
    { 20, 0, 1},
    { 40, 0, 2},
    { 80, 0, 3},
}

next_loadout :: proc(iter: ^LoadoutIter) -> (lo: Maybe(Loadout)) {
    if iter.weapon >= len(weapons) do return nil

    lo = Loadout{
        100, 
        weapons[iter.weapon].cost    + armor[iter.armor].cost    + rings[iter.ringL].cost    + rings[iter.ringR].cost   , 
        weapons[iter.weapon].damage  + armor[iter.armor].damage  + rings[iter.ringL].damage  + rings[iter.ringR].damage , 
        weapons[iter.weapon].defense + armor[iter.armor].defense + rings[iter.ringL].defense + rings[iter.ringR].defense, 
    }

    iter.ringR += 1
    if iter.ringL == iter.ringR do iter.ringR += 1
    if iter.ringR >= len(rings) {
        iter.ringR = 0
        iter.ringL += 1
    }

    if iter.ringL >= len(rings) {
        iter.ringL = 0
        iter.armor += 1
    }

    if iter.armor >= len(armor) {
        iter.armor = 0
        iter.weapon += 1
    }

    return
}

does_player_win :: proc(player: Loadout, boss: Loadout) -> bool {
    p := player
    b := boss
    
    for {
        b.health -= math.max(1, player.damage - boss.defense)
        if b.health <= 0 do return true
        p.health -= math.max(1, boss.damage - player.defense)
        if p.health <= 0 do return false
    }
}

parse_boss_loadout :: proc(inp: []string) -> Loadout {
    health , healthOk  := strconv.parse_int(inp[0][len("Hit Points: "):])
    damage , damageOk  := strconv.parse_int(inp[1][len("Damage: "):])
    defense, defenseOk := strconv.parse_int(inp[2][len("Armor: "):])

    return {health, {}, damage, defense}
}

p1 :: proc(input: []string) {
    loi := LoadoutIter{0, 0, 0, 1}
    bestCost := 9999999
    bestLoi := loi
    boss := parse_boss_loadout(input)

    for {
        thisLoi := loi
        player, ok := next_loadout(&loi).(Loadout)
        if !ok do break
        if player.cost > bestCost do continue
        if does_player_win(player, boss) {
            bestCost = player.cost
            bestLoi = thisLoi
        }
    }

    fmt.println(bestCost, bestLoi)
}

p2 :: proc(input: []string) {
    loi := LoadoutIter{0, 0, 0, 1}
    worstCost := 0
    worstLoi := loi
    boss := parse_boss_loadout(input)

    for {
        thisLoi := loi
        player, ok := next_loadout(&loi).(Loadout)
        if !ok do break
        if player.cost < worstCost do continue
        if !does_player_win(player, boss) {
            worstCost = player.cost
            worstLoi = thisLoi
        }
    }

    fmt.println(worstCost, worstLoi)
}
