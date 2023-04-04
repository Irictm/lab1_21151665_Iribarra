#lang racket
(require "drive_21151665_IribarraBecerra.rkt" "user_21151665_IribarraBecerra.rkt")

; TDA system
; Constructores: system
; Selectores: 
; Pertenencia: 
; Modificadores: run
; Otras Funciones: 


(define system (lambda (nombre_sys) (cons nombre_sys (cons "Fecha (placeholder)" null))))
; Nombre: system
; Dominio: nombre_sys(string)
; Recorrido: system (par)
; Descripcion: Funcion constructora del systema, recibe un string y entrega
;              una lista construida a traves de pares que contiene el nombre del systema y la fecha de creacion.

; FALTA DEJAR REGISTRO DE FECHA;

(define run (lambda (systema comando) (comando systema)))
; Nombre: run
; Dominio: system X comando(funcion)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema y una funcion para
;              retornar el systema con la funcion aplicada a traves del uso de "compose")

; FALTA DEJAR REGISTRO DE FECHA;

(define add-drive (lambda (systema) (lambda (letra nombre capacidad)
                                    (cons systema (drive letra nombre capacidad))
                                    )))
; Nombre: add-drive
; Dominio: system X letra (char) X nombre (String) X capacidad (int)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema, una letra, un nombre
;              y una capacidad para crear un drive con estas especificaciones y agregarlo
;              al sistema (el cual retorna).

(define register (lambda (systema) (lambda (nombre_usuario)
                                   (cons systema (user nombre_usuario))
                                   )))
; Nombre: register
; Dominio: nombre_usuario(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema y un nombre de usuario
;              para crear un usuario con estas especificaciones y agregarlo al sistema (el cual retorna).