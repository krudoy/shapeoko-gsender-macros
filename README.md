# Shapeoko 5 PRO gSender Macros (v2)

Macros for BitSetter and BitZero V2 with gSender on Shapeoko 5 PRO 2x2 with HDZ.

## Key Improvement: Centralized Configuration

All settings are in **ONE macro** (`Machine Config`). Edit once, all other macros use those values via global variables.

**⚠️ RUN "Machine Config ⚙️" MACRO FIRST AFTER IMPORTING!**

## Quick Start

1. **Import**: gSender → Macros → Import → `shapeoko5-macros.json`
2. **Configure**: Click `⚙️ Machine Config` macro, edit values for your setup
3. **Run Config**: Click the macro button to load your settings
4. **Ready**: All other macros now use your configuration

## Your Configuration (edit in Machine Config macro)

```gcode
; === BITSETTER LOCATION ===
%global.bitsetterX = -10       ; Your BitSetter X (mm from home)
%global.bitsetterY = -600      ; Your BitSetter Y (mm from home)

; === MACHINE SIZE ===
%global.machineX = 623         ; Match your GRBL $130
%global.machineY = 623         ; Match your GRBL $131
%global.machineZ = 120         ; Match your GRBL $132

; === BITZERO V2 DIMENSIONS ===
%global.probeThicknessZ = 14.99   ; Z probe thickness
%global.probeThicknessXY = 12.70  ; XY probe thickness
```

## How It Works

1. **Machine Config** sets `global.` variables (persist until gSender closes)
2. Other macros read these: `%BITSETTER_X = global.bitsetterX || -10`
3. The `|| -10` provides a fallback if config wasn't run

## Macros Included

| Macro | Purpose |
|-------|---------|
| **⚙️ Machine Config** | Set all configuration (RUN FIRST!) |
| **🔧 BitSetter Change Tool** | Probe tool, apply Z offset |
| **🔧 BitSetter Clear Reference** | Reset tool reference |
| **📐 BitZero V2 Probe Z** | Z-only probing |
| **📐 BitZero V2 Probe XY** | XY corner probe |
| **📐 BitZero V2 Probe XYZ** | Full corner probe |
| **🏠 Go To X0 Y0 Safe Z** | Return to work origin |
| **🏠 Go To Machine Home** | Park at home |
| **🏠 Go To BitSetter** | Navigate to BitSetter |

## Workflow

### Initial Setup (once per gSender session)
1. Connect to machine
2. Home the machine
3. Run **⚙️ Machine Config**

### Before Each Job
1. Load first tool
2. Run **🔧 BitSetter Change Tool** (sets reference)
3. Position BitZero V2 on stock
4. Run **📐 BitZero V2 Probe XYZ**
5. Start job

### On Tool Change (M6)
1. Change to new tool
2. Run **🔧 BitSetter Change Tool** (applies offset)
3. Resume job

## Calibration

If probed positions are consistently off, edit the offset values in Machine Config:

```gcode
%global.probeOffsetX = 0.1    ; Positive = shift right
%global.probeOffsetY = -0.05  ; Negative = shift forward
%global.probeOffsetZ = 0      ; Adjust Z if needed
```

## Notes

- Global variables reset when gSender closes - run Config again next session
- BitSetter position is in MACHINE coordinates (negative from home)
- Home is back-right on Shapeoko 5
- BitZero probes FRONT-LEFT corner

## Files

| File | Description |
|------|-------------|
| `shapeoko5-macros.json` | Import this into gSender |
| `00-machine-config.macro.nc` | Master configuration |
| `bitsetter-*.macro.nc` | BitSetter macros |
| `bitzero-*.macro.nc` | BitZero macros |
| `goto-*.macro.nc` | Movement macros |

## License

MIT - Use at your own risk. Test in air first!
