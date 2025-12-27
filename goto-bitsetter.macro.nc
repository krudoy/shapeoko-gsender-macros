; =====================================================
; Go to BitSetter Position
; For Shapeoko 5 PRO 2x2 with HDZ
; =====================================================
; Safely moves to BitSetter for manual inspection.
;
; REQUIRES: Run "00 Machine Config" macro first!
; =====================================================

; === LOAD CONFIG ===
%BITSETTER_X = global.bitsetterX || -10
%BITSETTER_Y = global.bitsetterY || -600
%SAFE_Z = global.safeZ || -5

; === BEGIN MACRO ===
G21
G90

; Raise Z first
G53 G0 Z[SAFE_Z]

; Move to BitSetter XY
G53 G0 X[BITSETTER_X] Y[BITSETTER_Y]

; Lower to viewing height
G53 G0 Z-30

(msg, At BitSetter position. Ready for tool change.)
