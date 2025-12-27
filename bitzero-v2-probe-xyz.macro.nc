; =====================================================
; BitZero V2 - Probe XYZ (Full Corner Probe)
; For Shapeoko 5 PRO 2x2 with HDZ
; =====================================================
; Position tool INSIDE probing bore, above probe surface.
; Probes FRONT-LEFT corner and sets X, Y, Z zeros.
;
; REQUIRES: Run "00 Machine Config" macro first!
; =====================================================

; === LOAD CONFIG (with fallback defaults) ===
%THICKNESS_Z = global.probeThicknessZ || 14.99
%THICKNESS_XY = global.probeThicknessXY || 12.70
%FEED_FAST = global.probeFeedFast || 150
%FEED_SLOW = global.probeFeedSlow || 25
%RETRACT = global.probeRetract || 3
%SAFE_RETRACT = global.safeRetract || 10
%X_OFFSET = global.probeOffsetX || 0
%Y_OFFSET = global.probeOffsetY || 0
%Z_OFFSET = global.probeOffsetZ || 0

; === BEGIN MACRO ===
G21
G90

%START_X = [posx]
%START_Y = [posy]

; === STEP 1: PROBE Z ===
G38.2 Z-25 F[FEED_FAST]
%PROBE_Z_FAST = [posz]
G91
G0 Z[RETRACT]
G38.2 Z-[RETRACT + 2] F[FEED_SLOW]
%PROBE_Z = [posz]
G90

; === STEP 2: DROP INTO BORE FOR XY ===
G0 Z[PROBE_Z - 10]

; === STEP 3: PROBE X ===
G38.2 X-20 F[FEED_FAST]
G91
G0 X[RETRACT]
G38.2 X-[RETRACT + 2] F[FEED_SLOW]
%PROBE_X = [posx]
G90
G0 X[START_X]

; === STEP 4: PROBE Y ===
G38.2 Y-20 F[FEED_FAST]
G91
G0 Y[RETRACT]
G38.2 Y-[RETRACT + 2] F[FEED_SLOW]
%PROBE_Y = [posy]
G90
G0 X[START_X] Y[START_Y]

; === STEP 5: RETRACT AND SET ZEROS ===
G0 Z[PROBE_Z + SAFE_RETRACT]

; Set X zero
G10 L20 P1 X[posx - PROBE_X + THICKNESS_XY + X_OFFSET]

; Set Y zero
G10 L20 P1 Y[posy - PROBE_Y + THICKNESS_XY + Y_OFFSET]

; Set Z zero
G10 L20 P1 Z[posz - PROBE_Z + THICKNESS_Z + Z_OFFSET]

; Move to new origin
G0 X0 Y0

(msg, XYZ probe complete. Front-left corner set as origin.)
