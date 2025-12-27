; =====================================================
; BitZero V2 - Probe XY Only
; For Shapeoko 5 PRO 2x2 with HDZ
; =====================================================
; Position tool INSIDE the probing bore.
; Probes FRONT-LEFT corner of stock.
;
; REQUIRES: Run "00 Machine Config" macro first!
; =====================================================

; === LOAD CONFIG (with fallback defaults) ===
%THICKNESS_XY = global.probeThicknessXY || 12.70
%FEED_FAST = global.probeFeedFast || 150
%FEED_SLOW = global.probeFeedSlow || 25
%RETRACT = global.probeRetract || 3
%X_OFFSET = global.probeOffsetX || 0
%Y_OFFSET = global.probeOffsetY || 0

; === BEGIN MACRO ===
G21
G90

; Store starting position
%START_X = [posx]
%START_Y = [posy]

; === PROBE X (toward -X for left wall) ===
G38.2 X-20 F[FEED_FAST]
G91
G0 X[RETRACT]
G38.2 X-[RETRACT + 2] F[FEED_SLOW]
%PROBE_X = [posx]
G90
G0 X[START_X]

; === PROBE Y (toward -Y for front wall) ===
G38.2 Y-20 F[FEED_FAST]
G91
G0 Y[RETRACT]
G38.2 Y-[RETRACT + 2] F[FEED_SLOW]
%PROBE_Y = [posy]
G90
G0 X[START_X] Y[START_Y]

; === SET XY ZERO ===
; Front-left corner: add thickness to probe position
G10 L20 P1 X[posx - PROBE_X + THICKNESS_XY + X_OFFSET]
G10 L20 P1 Y[posy - PROBE_Y + THICKNESS_XY + Y_OFFSET]

; Move to new zero
G0 X0 Y0

(msg, XY probe complete. Front-left corner set as X0 Y0.)
