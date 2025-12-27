(Bounding Box for: bitzero-v2-probe-xy.macro.nc)
(Units: Millimeters)
(Min X: -20.000, Min Y: -20.000)
(Max X: 0.000, Max Y: 0.000)

(Initialize)
G21 (Millimeters)
G90 (Absolute positioning)
G17 (XY plane)

(--- SAFETY & SETUP ---)
M5 (STOP SPINDLE - Safety First)
(MSG, ACTION REQUIRED: Insert Laser into collet. Press Cycle Start to resume.)
M1 (Optional Stop: Wait for user to insert laser)

(Raise to safe height)
G0 Z30.000

G0 X-20.000 Y-20.000

(Lower to drawing height)
G1 Z25.000 F3000

(Trace bounding box clockwise)
G1 X0.000 Y-20.000 F1000.0
G1 X0.000 Y0.000
G1 X-20.000 Y0.000
G1 X-20.000 Y-20.000

(Raise and return)
G0 Z30.000
G0 X0 Y0
M2