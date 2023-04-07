#lang racket
(provide drives_empty add_drive drives_empty?)
(require "drive_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

; TDA drives
; Representacion:


;---- Constructores ----;

(define drives_empty null)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define add_drive (lambda (drives_list letter name capacity)
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

;---- Modificadores ----;


;---- Otras Funciones ----;
