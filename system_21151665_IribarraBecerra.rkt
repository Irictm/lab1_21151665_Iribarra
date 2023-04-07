#lang racket
(require "drive_21151665_IribarraBecerra.rkt" "drives_21151665_IribarraBecerra.rkt"
         "user_21151665_IribarraBecerra.rkt" "users_21151665_IribarraBecerra.rkt")

; TDA system
; Representacion:


;---- Constructores ----;

(define system (lambda (sys_name)
                 (list sys_name drives_empty users_empty "path_empty" "NO ACTIVE USER" "Fecha (placeholder)")))
; Nombre: system
; Dominio: sys_name(string)
; Recorrido: system (list)
; Descripcion: Funcion constructora del systema, recibe un string y entrega
;              una lista construida a traves de pares que contiene el nombre del systema,
;              una lista de drives vacia, una lista de usuarios vacia, el path actual vacio,
;              un string indicando que no existe usuario actual y la fecha de creacion.
; FALTA DEJAR REGISTRO DE FECHA;


;---- Selectores ----;

(define system_name car)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_drives cadr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_users caddr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_path cadddr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_active_user (lambda (sys) (list-ref sys 4)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_creation_date (lambda (sys) (list-ref sys 5)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:


;---- Pertenencia ----;


;---- Modificadores ----;

(define run (lambda (systema comando) (comando systema)))
; Nombre: run
; Dominio: system X comando(funcion)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema y una funcion para
;              retornar el systema con la funcion aplicada a traves del uso de "compose")
; FALTA DEJAR REGISTRO DE FECHA;

(define add-drive (lambda (systema) (lambda (letra nombre capacidad)
                                    (null)
                                    )))
; Nombre: add-drive
; Dominio: system X letra (char) X nombre (String) X capacidad (int)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema, una letra, un nombre
;              y una capacidad para crear un drive con estas especificaciones y lo agrega
;              al sistema (el cual retorna).

(define register (lambda (systema) (lambda (nombre_usuario)
                                   (null)
                                   )))
; Nombre: register
; Dominio: nombre_usuario(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema y un nombre de usuario
;              para crear un usuario con estas especificaciones y lo agrega al sistema (el cual retorna).


;---- Otras Funciones ----;