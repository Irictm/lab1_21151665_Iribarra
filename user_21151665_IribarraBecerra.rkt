#lang racket
(provide user user_name user_creation_date)
(require "date_21151665_IribarraBecerra.rkt")

; TDA user
; Representacion: Representado por un nombre de usuario(string) y la fecha de registro de este.


;---- Constructores ----;

(define user (lambda (user_name) (list user_name current_date)))
; Nombre: user
; Dominio: user_name(string)
; Recorrido: user (list)
; Descripcion: Funcion constructora de user, recibe un nombre y entrega una
;              lista con el nombre del usuario y su fecha de registro.

;---- Selectores ----;

(define user_name car)
; Nombre: user_name
; Dominio: user
; Recorrido: string
; Descripcion: Funcion que recibe un user y entrega el nombre de este.

(define user_creation_date cadr)
; Nombre: user_creation_date
; Dominio: user
; Recorrido: string
; Descripcion: Funcion que recibe un user y entrega la fecha de registro de este.

;---- Pertenencia ----;

;---- Modificadores ----;

;---- Otras Funciones ----;
