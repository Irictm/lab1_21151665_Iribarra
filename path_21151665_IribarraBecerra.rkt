#lang racket
(provide path_empty path_add_location)

; TDA path
; Representacion:


;---- Constructores ----;

(define path_empty null)
; Nombre: path_empty
; Dominio: none
; Recorrido: null (empty list)
; Descripcion: Funcion constructora de path, retorna un path vacio (lista vacia)

(define path_add_location (lambda (path_original location) (append path_original (cons location null))))
; Nombre: path_add_location
; Dominio: path_original(list) X location(string or char)
; Recorrido: path (list)
; Descripcion: Funcion que recibe un path y una ubicacion, y retorna el path con la nueva ubicacion agragada

;---- Selectores ----;

;---- Pertenencia ----;

;---- Modificadores ----;

;---- Otras Funciones ----;
