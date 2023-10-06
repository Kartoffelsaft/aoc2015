package day14

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:math"
import "core:slice"

Reindeer :: struct {
    name: string,
    speed: int,
    flyTime: int,
    restTime: int,
}

parse_reindeer :: proc(s: string) -> Reindeer {
    rest := s

    nameEnd := strings.index_rune(rest, ' ')
    name := rest[:nameEnd]
    rest = rest[nameEnd + len(" can fly "):]

    speedEnd := strings.index_rune(rest, ' ')
    speed, speedOk := strconv.parse_int(rest[:speedEnd])
    rest = rest[speedEnd + len(" km/s for "):]

    flyTimeEnd := strings.index_rune(rest, ' ')
    flyTime, flyTimeOk := strconv.parse_int(rest[:flyTimeEnd])
    rest = rest[flyTimeEnd + len(" seconds, but then must rest for "):]

    restTimeEnd := strings.index_rune(rest, ' ')
    restTime, restTimeOk := strconv.parse_int(rest[:restTimeEnd])

    return Reindeer{name, speed, flyTime, restTime}
}

p1 :: proc(input: []string) {
    time := 2503

    for line in input {
        if line == "" do continue
        
        rd := parse_reindeer(line)

        cycles := time / (rd.flyTime + rd.restTime) 
        thisCycle := time % (rd.flyTime + rd.restTime)

        totalPrevCycles := rd.flyTime * cycles * rd.speed
        totalThisCycle := rd.speed * math.min(thisCycle, rd.flyTime)

        fmt.printf("%s: %i\n", rd.name, totalPrevCycles + totalThisCycle)
    }
}

p2 :: proc(input: []string) {
    Racer :: struct {
        rd: Reindeer,
        distance: int,
        lastTransitionTimer: int,
        points: int,
        running: bool,
    }

    reindeers := slice.mapper(input, proc(s: string) -> Racer {return Racer{
        parse_reindeer(s),
        0, 0, 0, true,
    }})

    for _ in 0..<2503 {
        furthest := &reindeers[0]

        for _, i in reindeers {
            rc := &reindeers[i]

            rc.lastTransitionTimer += 1

            if rc.running {
                rc.distance += rc.rd.speed
                if rc.lastTransitionTimer >= rc.rd.flyTime {
                    rc.running = false
                    rc.lastTransitionTimer = 0
                }
            } else {
                if rc.lastTransitionTimer >= rc.rd.restTime {
                    rc.running = true
                    rc.lastTransitionTimer = 0
                }
            }

            if rc.distance > furthest.distance do furthest = rc
        }

        furthest.points += 1
    }

    for rc in reindeers do fmt.printf("%s: %i\n", rc.rd.name, rc.points)
}
