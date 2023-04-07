#lang racket
(provide users_empty add_user users_empty?)
(require "user_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

; TDA users
; Representacion:


;---- Constructores ----;

(define users_empty null)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

(define add_user (lambda (users_list user_name)
                   (add_not_duped_value users_list (user user_name) users_empty? users_empty)
                   ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

;---- Selectores ----;

;---- Pertenencia ----;

(define users_empty? null?)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

;---- Modificadores ----;

;---- Otras Funciones ----;
