#lang racket

; TDA system
; Constructores: system
; Selectores: 
; Pertenencia: 
; Modificadores: run
; Otras Funciones: 


(define system (lambda (nombre_sys) (cons nombre_sys (cons "Fecha (placeholder)" null))))
; Nombre: system
; Dominio: nombre_sys(string)
; Recorrido: system (par)
; Descripcion: Funcion constructora del systema, recibe un string y entrega
;              una lista construida a traves de pares que contiene el nombre del systema y la fecha de creacion.

; FALTA DEJAR REGISTRO DE FECHA;

(define run (lambda (systema comando) (compose comando systema)))
; Nombre: run
; Dominio: system X comando(funcion)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema y una funcion para
;              retornar el systema con la funcion aplicada a traves del uso de "compose")

; FALTA DEJAR REGISTRO DE FECHA;