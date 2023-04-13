#lang racket
(provide path_empty path_add_location)

; TDA path
; Representacion:


;---- Constructores ----;

(define path_empty null)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

(define path_add_location (lambda (path_original location) (append path_original (cons location null))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

;---- Selectores ----;

;---- Pertenencia ----;

;---- Modificadores ----;

;---- Otras Funciones ----;
