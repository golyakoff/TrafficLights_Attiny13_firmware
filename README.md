*[Читать по-русски](README.ru.md)*

# TrafficLight13 — ATtiny13A firmware

Firmware for a desktop traffic-light model (two directions: north-south / east-west,
red-yellow-green plus a flashing-yellow "caution" mode) built around an ATtiny13A.
Controlled by a single button: a short press toggles between the normal cycle and
flashing-yellow, a long press puts the device to sleep / wakes it up (power-down sleep,
woken by an external interrupt).

## Source and credit

The firmware itself (`TrafficLight13.cpp`) is taken from a Habr article:
**["Blinking traffic light" on ATtiny13](https://habr.com/ru/post/443188/)** (in Russian).

All of the design — the traffic-light state table, the button/power-mode state machine,
the byte-shaving needed to fit the ATtiny13A's 1024-byte flash — is the article author's
work. This repository doesn't claim authorship of the original firmware: it's only
polish, adapting it to a specific build, and an attempt to track down and fix a hang that
shows up after long continuous runs (see below).

## Build and flash

You'll need avr-gcc — download and extract it from
https://github.com/ZakKemble/avr-gcc-build/releases — and a usbasp programmer. The
toolchain path is set via the `AVRBINPATH` variable at the top of both scripts — adjust
it to your own install location.

- `build.bat` — compiles, links, and produces `out/TrafficLight13.hex`, printing the firmware size.
- `flash.bat` — burns the fuses (internal 9.6MHz oscillator) and writes `out/TrafficLight13.hex` to the chip.

Target MCU is `attiny13a` — 1024 bytes flash / 64 bytes RAM — so after any change it's
worth checking the size report `build.bat` prints.

## Known issue

After a long continuous run (on the order of 10 hours), the normal traffic-light cycle
freezes in its current state, even though the button and mode switching keep working
(toggling to flashing-yellow and back "revives" the cycle). This looks like the timer
value colliding with the sentinel used for "timer disabled" (zero) during the periodic
rebase of `globalTimer` — a fix is in the works.
