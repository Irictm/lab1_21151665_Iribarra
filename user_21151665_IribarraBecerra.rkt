#lang racket
(provide user)

; TDA drive
; Constructores: user
; Selectores: 
; Pertenencia: 
; Modificadores:
; Otras Funciones:

(define user (lambda (nombre_usuario) (cons nombre_usuario (cons "Estado: logged-out" null))))
; Nombre: user
; Dominio: nombre_usuario(string)
; Recorrido: system (par)
; Descripcion: Funcion constructora de user, recibe un strings y entrega
;              una lista construida a traves de pares que el nombre del
;              usuario y un string que informa del estado del usuario (logged-in o logged-out).