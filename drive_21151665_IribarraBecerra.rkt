#lang racket
(provide drive drive_letter drive_name drive_capacity drive_root drive_add_folder)
(require "folder_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

; TDA drive
; Representacion:


;---- Constructores ----;

(define drive (lambda (letter name capacity root)(list letter name capacity root)))
; Nombre: drive
; Dominio: letter(char) X name(string) X capacity(int)
; Recorrido: system (par)
; Descripcion: Funcion constructora de drive, recibe tres strings y entrega
;              una lista construida a traves de pares que contiene la letra que
;              representa el drive, el nombre de este, su capacidad y un folder base vacio.


;---- Selectores ----;

(define drive_letter car)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drive_name cadr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drive_capacity caddr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drive_root cadddr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:


;---- Pertenencia ----;


;---- Modificadores ----;

(define drive_add_folder (lambda (drv name path)
                           (drive
                            (drive_letter drv)
                            (drive_name drv)
                            (drive_capacity drv)
                            (folder_add_folder (drive_root drv) name path)
                           )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Otras Funciones ----;

; crd for null, cadr for name checking