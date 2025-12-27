; =====================================================
; MACHINE CONFIGURATION - Run This First!
; For Shapeoko 5 PRO 2x2 with HDZ
; =====================================================
; Run this macro ONCE after connecting to your machine.
; It sets global variables that all other macros will use.
;
; EDIT THESE VALUES TO MATCH YOUR SETUP, then run the macro.
; =====================================================

; === MACHINE DIMENSIONS ===
; These should match your GRBL $130, $131, $132 settings
; Query with $$ in console if unsure

%global.machineX = 623         ; $130 - X max travel (mm)
%global.machineY = 623         ; $131 - Y max travel (mm)
%global.machineZ = 120         ; $132 - Z max travel (mm)

; === BITSETTER CONFIGURATION ===
; Location in MACHINE coordinates (relative to home)
; Home is back-right, so values are typically negative

%global.bitsetterX = -10       ; BitSetter X position (mm)
%global.bitsetterY = -600      ; BitSetter Y position (mm)
%global.bitsetterProbeMax = 80 ; Max probe distance down (mm)
%global.bitsetterFeedFast = 500  ; Fast seek rate (mm/min)
%global.bitsetterFeedSlow = 100  ; Slow probe rate (mm/min)
%global.bitsetterRetract = 3   ; Retract between probes (mm)

; === BITZERO V2 CONFIGURATION ===
; Standard BitZero V2 dimensions (measure yours if different)

%global.probeThicknessZ = 14.99   ; Probe Z thickness (mm)
%global.probeThicknessXY = 12.70  ; Probe XY thickness (mm)
%global.probeBoreDiameter = 12.0  ; Probing bore diameter (mm)
%global.probeFeedFast = 150       ; Fast probe rate (mm/min)
%global.probeFeedSlow = 25        ; Slow probe rate (mm/min)
%global.probeRetract = 3          ; Retract between probes (mm)

; === SAFE HEIGHTS ===
%global.safeZ = -5             ; Safe Z in machine coords (mm)
%global.safeRetract = 10       ; Retract height above work (mm)

; === CALIBRATION OFFSETS ===
; Adjust these if probed positions are consistently off
%global.probeOffsetX = 0       ; X calibration offset (mm)
%global.probeOffsetY = 0       ; Y calibration offset (mm)
%global.probeOffsetZ = 0       ; Z calibration offset (mm)

; === CLEAR TOOL REFERENCE ===
; Start fresh each time config is run
%global.toolReferenceSet = 0
%global.toolReferenceMZ = 0

; === CONFIRMATION ===
(msg, Configuration loaded!)
(msg, Machine: [global.machineX] x [global.machineY] x [global.machineZ] mm)
(msg, BitSetter at X:[global.bitsetterX] Y:[global.bitsetterY])
(msg, Ready to use other macros.)
