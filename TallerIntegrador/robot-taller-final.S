; Comandos del auto

#define __SFR_OFFSET 0
#include "avr/io.h"

;Las funciones que se llaman desde el .ino se deben declarar como globales
.global config
.global entradas
.global control
.global retardo

config:

  CBI PORTC, 4
  CBI PORTC, 5

  ret

entradas:

  IN R16, PINC
; Analizar el bit 4 del registro R16
  SBRS R16, 4
  RJMP NOSENSO_IZQUIERDO  ; Si el bit 4 de R16 está en 0, saltar a NOSENSO_IZQUIERDO
  RJMP SENSO_IZQUIERDO    ; Si el bit 4 de R16 está en 1, saltar a SENSO_IZQUIERDO

NOSENSO_IZQUIERDO:
  LDI R18, 0               ; Cargar 0 en R18 cuando el sensor izquierdo no está activo
  RJMP LEE_SENSOR_DERECHO  ; Saltar a la lectura del sensor derecho

SENSO_IZQUIERDO:
  LDI R18, 1               ; Cargar 1 en R18 cuando el sensor izquierdo está activo
  RJMP LEE_SENSOR_DERECHO  ; Saltar a la lectura del sensor derecho

; Leer el valor del puerto C en el registro R17
LEE_SENSOR_DERECHO:

  IN R17, PINC
; Analizar el bit 5 del registro R17
  SBRS R17, 5
  RJMP NOSENSO_DERECHO  ; Si el bit 5 de R17 está en 0, saltar a NOSENSO_DERECHO
  RJMP SENSO_DERECHO    ; Si el bit 5 de R17 está en 1, saltar a SENSO_DERECHO

NOSENSO_DERECHO:
  LDI R19, 0            ; Cargar 0 en R19 cuando el sensor derecho no está activo
  RJMP SENSOS_FIN

SENSO_DERECHO:
  LDI R19, 1            ; Cargar 1 en R19 cuando el sensor derecho está activo

SENSOS_FIN:
  RET


control:
; Verificar si ambos sensores están activos
  CPI R18, 1             ; Compara el sensor izquierdo con 1 (activo)
  BREQ NO_CORRECCION     ; Si el sensor izquierdo está activo, no se requiere corrección
  CPI R19, 1             ; Compara el sensor derecho con 1 (activo)
  BREQ NO_CORRECCION     ; Si el sensor derecho está activo, no se requiere corrección

; Si ambos sensores están inactivos, avanzar recto
  LDI R20, 115     ; Velocidad máxima motor izquerdo
  LDI R21, 150     ; Velocidad máxima Motor derecho
  MOV R10, R20     ; Movemos la Velocidad del motor izquierdo
  MOV R11, R21     ; Movemos la Velocidad del motor derecho
  ;CALL retardo    ; Llamada al retardo COMENTADA
  RJMP FIN_CONTROL ; Saltar al final de la función

NO_CORRECCION:
; Corregir el rumbo del robot si pierde la línea
  CPI R18, 0            ; Compara el sensor izquierdo con 0 (inactivo)
  BRNE GIRO_DERECHA     ; Si el sensor izquierdo está activo, girar hacia la derecha
  CPI R19, 0            ; Compara el sensor derecho con 0 (inactivo)
  BRNE GIRO_IZQUIERDA   ; Si el sensor derecho está activo, girar hacia la izquierda
  RJMP FIN_CONTROL      ; Si no se requiere corrección, saltar al final de la función

GIRO_DERECHA:
; Girar hacia la derecha para corregir el rumbo
  LDI R20, 150      ; Velocidad del motor izquierdo
  LDI R21, 75      ; Velocidad del motor derecho
  MOV R10, R20      ; Movemos la Velocidad del motor izquierdo
  MOV R11, R21      ; Movemos la Velocidad al motor derecho
  ;CALL retardo     ; Llamada al retardo COMENTADA
  RJMP FIN_CONTROL  ; Saltar al final de la función

GIRO_IZQUIERDA:
; Girar hacia la izquierda para corregir el rumbo
  LDI R20, 50     ; Velocidad del motor izquierdo
  LDI R21, 200     ; Velocidad del motor derecho
  MOV R10, R20     ; Movemos la Velocidad al  motor izquierdo
  MOV R11, R21     ; Movemos la Velocidad Velocidad del motor derecho
  ;CALL retardo    ; Llamada al retardo COMENTADA

FIN_CONTROL:
  RET



retardo:
  ldi r23, 8  ;  retardo aprox 100 ms
loopTres:
  ldi r22, 250
loopDos:
  ldi r24, 255
loopUno:
  dec r24
  brne loopUno
  dec r22
  brne loopDos
  dec r23
  brne loopTres

  ret