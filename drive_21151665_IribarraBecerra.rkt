#lang racket
(provide drive)

; TDA drive
; Constructores: drive
; Selectores: 
; Pertenencia: 
; Modificadores:
; Otras Funciones:

(define drive (lambda (letra nombre capacidad)(cons letra (cons nombre (cons capacidad null)))))
; Nombre: drive
; Dominio: letra(char) X nombre(string) X capacidad(int)
; Recorrido: system (par)
; Descripcion: Funcion constructora de drive, recibe tres strings y entrega
;              una lista construida a traves de pares que contiene la letra que
;              representa el drive, el nombre de este y su capacidad.