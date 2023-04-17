#lang racket
(provide path_empty path_empty? path_add_location path_string_to_path path_drive path_previous_location)
(require "folder_21151665_IribarraBecerra.rkt")

; TDA path
; Representacion:


;---- Constructores ----;

(define path_empty null)
; Nombre: path_empty
; Dominio: none
; Recorrido: null (empty list)
; Descripcion: Funcion constructora de path, retorna un path vacio (lista vacia)

(define path_add_location (lambda (path_original location) (append path_original location)))
; Nombre: path_add_location
; Dominio: path_original(list) X location(string or char)
; Recorrido: path (list)
; Descripcion: Funcion que recibe un path y una ubicacion, y retorna el path con la nueva ubicacion agragada

(define path_string_to_path (lambda (path_as_string)
                              (if (equal? (string(string-ref path_as_string 0)) (car(string-split path_as_string "/")))
                                  (cons (string-ref path_as_string 0) (cdr (string-split path_as_string "/")))
                                  (string-split path_as_string "/"))
                              ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Selectores ----;

(define path_drive (lambda (path) (list (car path))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Pertenencia ----;

(define path_empty? null?)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define path_exists? (lambda (fldr path)
                       (if (path_empty? path) true
                           (if (folder_empty? fldr) false 
                               (if (equal? (folder_name (car fldr))(car path))
                                    (path_exists? (folder_inside (car fldr)) (cdr path))
                                    (path_exists? (cdr fldr) path))
                           ))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:
; NOT IMPLEMENTED IN SYSTEM

;---- Modificadores ----;

(define path_previous_location (lambda (path)
                                 (if (null? (cdr path)) null
                                     (cons (car path) (path_previous_location (cdr path)))
                                 )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Otras Funciones ----;
