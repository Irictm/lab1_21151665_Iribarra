#lang racket
(provide users_empty users_add_user users_empty? users_exists_user?)
(require "user_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

; TDA users
; Representacion: Representado por una lista vacia o una lista que contiene uno o multiples user.


;---- Constructores ----;

(define users_empty null)
; Nombre: users_empty
; Dominio: none
; Recorrido: null(empty list)
; Descripcion: Funcion constructora de users, retorna una lista de usuarios vacia.

(define users_add_user (lambda (users_list user_name)
                   (add_not_duped_value users_list (user user_name) users_empty? users_empty)
                   ))
; Nombre: add_user
; Dominio: users_list(list) X user_name(string)
; Recorrido: users(list)
; Descripcion: Funcion constructora de users, recibe una lista de usuarios, un nombre de usuario y
;              retorna la lista de usuarios con un user agregado con el nombre indicado.

;---- Selectores ----;

;---- Pertenencia ----;

(define users_empty? null?)
; Nombre: users_empty?
; Dominio: users
; Recorrido: bool
; Descripcion: Funcion que recibe una lista de usuarios y retorna #t si esta esta vacia
;              o #f en caso contrario.

(define users_exists_user? (lambda (users_list name)
                             (if (users_empty? users_list) false
                                 (if (equal? (caar users_list) name) true
                                     (users_exists_user? (cdr users_list) name))
                             )))
; Nombre: users_exists_user?
; Dominio: users_list(users) X name(string)
; Recorrido: bool
; Descripcion: Funcion que recibe una lista de usuario, un nombre de usuario y
;              retorna #t si el usuario representado por ese nombre se encuentra en la lista
;              de usuarios o #f en caso contrario.
; Recursion: De cola

;---- Modificadores ----;

;---- Otras Funciones ----;
