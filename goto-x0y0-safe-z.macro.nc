; =====================================================
; Go to X0 Y0 at Safe Z Height
; For Shapeoko 5 PRO 2x2 with HDZ
; =====================================================
; Safely moves to work coordinate origin (X0 Y0).
;
; REQUIRES: Run "00 Machine Config" macro first!
; =====================================================

; === LOAD CONFIG ===
%SAFE_Z = global.safeZ || -5
%SAFE_RETRACT = global.safeRetract || 10

; === BEGIN MACRO ===
G21
G90

; Raise Z to safe height (machine coordinates)
G53 G0 Z[SAFE_Z]

; Move to work X0 Y0
G0 X0 Y0

; Lower to safe working height
G0 Z[SAFE_RETRACT]

(msg, At work origin X0 Y0 Z[SAFE_RETRACT])
