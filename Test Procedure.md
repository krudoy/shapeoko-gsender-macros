## Available Macros

| Macro | Purpose |
|-------|---------|
| **Machine Config ⚙️** | Sets all global variables (RUN FIRST!) |
| **BitSetter Change Tool** | Probes BitSetter, sets/applies Z offset |
| **BitSetter Clear Reference** | Resets tool reference to start fresh |
| **BitZero V2 Probe Z** | Z-only probe (place probe on stock surface) |
| **BitZero V2 Probe XY** | XY corner probe (bit inside probe bore) |
| **BitZero V2 Probe XYZ** | Full corner probe - X, Y, and Z in one go |
| **Go To X0 Y0 Safe Z** | Safely return to work origin |
| **Go To Machine Home** | Park at back-right home position |
| **Go To BitSetter** | Navigate to BitSetter location |

---

## Setup (One Time)

1. **Import into gSender**: Macros → Import → `shapeoko5-macros.json`
2. **Edit Machine Config** macro with your values:
   - BitSetter position: `X=-10, Y=-600` (verify these!)
   - Probe dimensions (default BitZero V2 values should be fine)

---

## Testing Procedure

### ⚠️ Safety First - Test in Air!

1. **Home the machine**
2. **Run "Machine Config ⚙️"** — loads your settings
3. **Test navigation macros first** (no probing):
   - Run **Go To Machine Home** — should park at back-right
   - Run **Go To BitSetter** — should move to front-right where BitSetter is
   - Set a dummy X0/Y0, then run **Go To X0 Y0 Safe Z**

4. **Test BitSetter** (with probe connected):
   - Load a tool
   - Run **Go To BitSetter** — position above BitSetter
   - Run **BitSetter Change Tool** — should probe and set reference
   - Change tool manually
   - Run **BitSetter Change Tool** again — should apply Z offset

5. **Test BitZero probing** (with probe connected):
   - Place BitZero V2 on stock, front-left corner
   - Position bit above/inside probe bore
   - Run **BitZero V2 Probe Z** (or XY, or XYZ)
   - Verify zero is set correctly

---

## Typical Job Workflow

```
1. Connect & Home
2. Run "Machine Config ⚙️"
3. Load first tool
4. Run "BitSetter Change Tool" (sets reference)
5. Place BitZero on stock
6. Run "BitZero V2 Probe XYZ"
7. Run job
8. On tool change → Run "BitSetter Change Tool"
9. Resume job
```

---

## If Something Goes Wrong

- **Wrong position?** Check `global.bitsetterX` and `global.bitsetterY` in Machine Config
- **Probe not triggering?** Check wiring, increase probe distance
- **Z offset wrong?** Run "BitSetter Clear Reference" and start over