(External Contour for: goto-x0y0-safe-z.macro.nc)
(Units: Millimeters)

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

G0 X0.000 Y0.000

(Lower to drawing height)
G1 Z25.000 F3000

(Trace contour)

(Raise and return)
G0 Z30.000
G0 X0 Y0
M2