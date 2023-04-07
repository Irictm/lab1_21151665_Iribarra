#lang racket
(provide drive drive_letter drive_name drive_capacity)

; TDA drive
; Representacion:


;---- Constructores ----;

(define drive (lambda (letter name capacity)(cons letter (cons name (cons capacity null)))))
; Nombre: drive
; Dominio: letter(char) X name(string) X capacity(int)
; Recorrido: system (par)
; Descripcion: Funcion constructora de drive, recibe tres strings y entrega
;              una lista construida a traves de pares que contiene la letra que
;              representa el drive, el nombre de este y su capacidad.


;---- Selectores ----;

(define drive_letter car)
(define drive_name cadr)
(define drive_capacity caddr)

;---- Pertenencia ----;


;---- Modificadores ----;


;---- Otras Funciones ----;

