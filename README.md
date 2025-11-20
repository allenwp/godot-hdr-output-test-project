# Godot HDR Output Test Project

https://github.com/user-attachments/assets/297c2686-d939-4571-9bd0-e5808906d5ee

## Overview

This sample project was made with a few goals in mind:

1) Demonstrate a player-facing in-game settings menu that could be shipped with any game that supports HDR output.
2) Provide demonstration of Godot's Extended Dynamic Range (EDR) and High Dynamic Range (HDR) functionality.
3) Provide debug tooling to help implementation of HDR output on new platforms.
4) Provide tooling to understand your display's max luminance and its tonemapping behaviour.
5) Be a first draft of a demo for [godot-demo-projects](https://github.com/godotengine/godot-demo-projects)

### Player-facing in-game settings

This packed scene and its related scripts are intended to be a "drop-in" package for games that implement HDR output. Some reworking by the game developer would be needed to make this fit nicely alongside existing game settings.

### Colour sweep

The colour sweep shows all fully saturated sRGB colours and all fully desaturated (greyscale) values.
- Clip to max luminance
  - With HDR output, this simulates a display that hard-clips values in the BT.2020 colour space.
  - Without HDR output, this simulates a dsiplay that hard-clips values in the sRGB colour space.
- Min
  - Minimum value to be shown on the colour sweep.
- Max
  - Maximum value to be shown on the colour sweep.

Markings:
- Log scale markings (bottom of greyscale bar)
  - For example: 1.0, 2.0, 3.0, ..., 9.0, 10.0, 20.0, 30.0, ..., 90.0, 100.0, 200.0, ..., etc.
  - The tall marking indicates 0.001, 0.1, 1.0, 10.0, 100.0, etc.
- Max luminance marking (top of greyscale bar)

### Black White Max
- Show linear 0.0, 1.0, and the maximum value based on current Max Luminance

### Max Luminance & Relative Stops
![image](https://github.com/user-attachments/assets/c7812105-1c7b-4888-8b9d-124dec8235ed)
- Middle vertical rctangle is max luminance
- Left and right sides display different stops (log base 2) relative to the max luminance

### Negative Values Test
The bottom-right red, green, and blue rectangles will show negative sRGB values if they are being sent to the display:
![image](https://github.com/user-attachments/assets/d952d845-b252-4e80-98f4-67717d206a18)

# SDR/HDR Stability Test
The `sdr_hdr_stability_test.tscn` scene can be used to verify that output is stable between SDR and HDR. In this scene, all colours should be identical regardless of HDR or SDR output except for the "max green" rectangle:

https://github.com/user-attachments/assets/f64b6910-29d5-458a-8afd-8dea71a90650
