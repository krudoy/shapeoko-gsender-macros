; =====================================================
; BitSetter - Change Tool Macro
; For Shapeoko 5 PRO 2x2 with HDZ
; =====================================================
; Run this macro:
;   1. Before starting a job (to set initial tool reference)
;   2. On every tool change (M6)
;
; REQUIRES: Run "00 Machine Config" macro first!
; =====================================================

; === LOAD CONFIG (with fallback defaults) ===
%BITSETTER_X = global.bitsetterX || -10
%BITSETTER_Y = global.bitsetterY || -600
%PROBE_DISTANCE = global.bitsetterProbeMax || 80
%FEED_FAST = global.bitsetterFeedFast || 500
%FEED_SLOW = global.bitsetterFeedSlow || 100
%RETRACT = global.bitsetterRetract || 3
%SAFE_Z = global.safeZ || -5

; === BEGIN MACRO ===
G21                            ; Millimeters
G90                            ; Absolute positioning

; Move Z to safe height first
G53 G0 Z[SAFE_Z]

; Move XY to BitSetter location
G53 G0 X[BITSETTER_X] Y[BITSETTER_Y]

; Move down with clearance
G53 G0 Z[SAFE_Z - 10]

; Fast probe to find approximate position
G38.2 Z-[PROBE_DISTANCE] F[FEED_FAST]

; Store position and retract
%PROBE_Z_FAST = [posmz]
G91
G0 Z[RETRACT]
G90

; Slow probe for accuracy
G38.2 Z[PROBE_Z_FAST - RETRACT - 5] F[FEED_SLOW]

; Store accurate probe position
%CURRENT_TOOL_MZ = [posmz]

; Check for existing reference
%REF_SET = global.toolReferenceSet || 0
%REF_MZ = global.toolReferenceMZ || 0

; Apply offset or set reference
(if REF_SET == 1)
    %Z_OFFSET = [CURRENT_TOOL_MZ - REF_MZ]
    G10 L20 P1 Z[posz - Z_OFFSET]
    (msg, Tool change complete. Z offset: [Z_OFFSET] mm)
(else)
    %global.toolReferenceSet = 1
    %global.toolReferenceMZ = [CURRENT_TOOL_MZ]
    (msg, Initial tool reference set at MZ: [CURRENT_TOOL_MZ] mm)
(endif)

; Retract and return to work zero
G53 G0 Z[SAFE_Z]
G0 X0 Y0

(msg, BitSetter probe complete)
