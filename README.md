# TrafficLight13 — ATtiny13A firmware

Firmware for a traffic light with two modes — "standby" flashing yellow, and
"operating", cycling through 7 stages as right-of-way switches from one direction
to another. Logic runs on an ATtiny13A.

## Part of the TrafficLights project:
- 3D model: [TrafficLights_3D_Model](https://github.com/golyakoff/TrafficLights_3D_Model)
- PCB: [TrafficLights_PCB](https://github.com/golyakoff/TrafficLights_PCB)

*[Читать по-русски](README.ru.md)*

## Source and credit

The firmware (`TrafficLight13.cpp`) is taken from a Habr article:
**["Three eyes hang on a pole, or a tale of how ATtiny13's five legs are plenty"](https://habr.com/ru/post/443188/)** (in Russian).

All of the design — the traffic-light state table, the button/power-mode state machine,
the byte-shaving needed to fit the ATtiny13A's 1024-byte flash — is the article author's
work. This repository doesn't claim authorship of the original firmware: it's only
polish, adapting the build scripts, and fixing a bug causing a hang after long
(10+ hour) continuous runs (see the
[fix commit](https://github.com/golyakoff/TrafficLights_Attiny13_firmware/commit/abe003fad5b31764ce638df506a21c669ca1039e)).

Thanks, [**Archy_Kld**](https://habr.com/ru/users/Archy_Kld/)!

## Build and flash

You'll need [avr-gcc](https://github.com/ZakKemble/avr-gcc-build/releases) and a usbasp programmer.
The toolchain path is set via the `AVRBINPATH` variable at the top of both scripts — adjust it to your own install location.

- `build.bat` — compiles, links, and produces `out/TrafficLight13.hex`, printing the firmware size.
- `flash.bat` — burns the fuses (internal 9.6MHz oscillator) and writes `out/TrafficLight13.hex` to the chip.

Target MCU is `attiny13a` — 1024 bytes flash / 64 bytes RAM — so after any change it's
worth checking the size report `build.bat` prints.

## Controls

A short press of the mode button toggles between the normal cycle and flashing mode.

There's also a not-recommended "sleep" feature, triggered by a long press of the mode
button. It's recommended to use a separate power switch instead, which fully cuts power
to the device.
