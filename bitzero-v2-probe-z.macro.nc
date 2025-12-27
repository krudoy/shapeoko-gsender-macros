; =====================================================
; BitZero V2 - Probe Z Only
; For Shapeoko 5 PRO 2x2 with HDZ
; =====================================================
; Position tool ABOVE the BitZero probe surface.
; Sets Z zero at stock surface.
;
; REQUIRES: Run "00 Machine Config" macro first!
; =====================================================

; === LOAD CONFIG (with fallback defaults) ===
%THICKNESS = global.probeThicknessZ || 14.99
%FEED_FAST = global.probeFeedFast || 150
%FEED_SLOW = global.probeFeedSlow || 25
%RETRACT = global.probeRetract || 3
%SAFE_RETRACT = global.safeRetract || 10
%Z_OFFSET = global.probeOffsetZ || 0

; === BEGIN MACRO ===
G21
G90

; Fast probe down
G38.2 Z-25 F[FEED_FAST]

; Retract
%PROBE_Z_FAST = [posz]
G91
G0 Z[RETRACT]

; Slow probe for accuracy
G38.2 Z-[RETRACT + 2] F[FEED_SLOW]

; Set Z zero (probe position + thickness = stock surface)
G90
G10 L20 P1 Z[THICKNESS + Z_OFFSET]

; Retract to safe height
G0 Z[SAFE_RETRACT]

(msg, Z probe complete. Z zero set at stock surface.)
