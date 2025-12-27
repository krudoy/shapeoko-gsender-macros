; =====================================================
; Go to Machine Home (Parking Position)
; For Shapeoko 5 PRO 2x2 with HDZ
; =====================================================
; Safely moves to machine home position (back-right).
;
; REQUIRES: Run "00 Machine Config" macro first!
; =====================================================

; === LOAD CONFIG ===
%SAFE_Z = global.safeZ || -5

; === BEGIN MACRO ===
G21
G90

; Raise Z first
G53 G0 Z[SAFE_Z]

; Move to near home
G53 G0 X-5 Y-5

; Move Z all the way up
G53 G0 Z-1

(msg, Machine parked at home position)
