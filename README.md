# Gamecube-to-Nintendo64-Adapter
A FPGA based Gamecube controller adapter for Nintendo 64

First release of the GC to N64 adapter using a Tang Nano 9k FPGA. This current release only supports 2 controllers, but all 4 ports are supported once uncommented.

Features:
1. Low latency ( < 500µs )
2. Rumble support
3. Wide controller compatibility, including Wavebird, Phob, and Boxx.

Future plans:
1. Button remapping
2. Input recording and playback via SD card
3. Controller Pak save support

Code breakdown:
The list of .v modules is: 
GC_PollGen.v - Generates the pulses read by a Gamecube controller to indicate the buttons being pressed.
GCC_Data.v - Analyzes the pulses from the Gamecube controller to indicate the status of all buttons, joysticks, and analog triggers.
Analog.v - The Gamecube analog sticks use a 0 to 255 range, while the N64 uses a 0 to 100 scheme with 2s compliment. This module is a giant case statement to convert between the two ranges.
N64_ID.v - Analyzes the data from the N64 to indicate the controller command requested.
Control.v - This module is the controller response of the N64_ID.v analysis. Responses include controller data, controller pak data, rumble pak data, and calibration commands.
bounce.v - This hardware is old and I don't trust it. I am using a debounce module to remove any noise on the data lines.
Adapter_Top.v - Top module to connect all modules together.

![GC1](https://github.com/SoulCalDan/Gamecube-to-Nintendo64-Adapter/assets/137843786/b2293dd5-62b9-449d-80bc-201ee0d43981)
![GC2](https://github.com/SoulCalDan/Gamecube-to-Nintendo64-Adapter/assets/137843786/e8835256-5276-40a9-a8c2-0373dc9ffe49)
![GC3](https://github.com/SoulCalDan/Gamecube-to-Nintendo64-Adapter/assets/137843786/bdd0dfa4-bef2-4ab6-b6ce-97583d6bcf34)
