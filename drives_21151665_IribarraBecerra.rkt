#lang racket
(provide drives_empty drives_add_drive drives_empty? drives_exists_drive?)
(require "drive_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

; TDA drives
; Representacion:


;---- Constructores ----;

(define drives_empty null)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drives_add_drive (lambda (drives_list letter name capacity)
                    (add_not_duped_value drives_list (drive letter name capacity) drives_empty? drives_empty)
                    ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

;---- Selectores ----;


;---- Pertenencia ----;

(define drives_empty? null?)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

(define drives_exists_drive? (lambda (drives_list letter)
                             (if (drives_empty? drives_list)
                                 false
                                 (if (equal? (caar drives_list) letter) true
                                 (drives_exists_drive? (cdr drives_list) letter))
                             )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Modificadores ----;


;---- Otras Funciones ----;
