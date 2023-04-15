#lang racket
(provide drive drive_letter drive_name drive_capacity drive_root drive_add_folder)
(require "folder_21151665_IribarraBecerra.rkt")

; TDA drive
; Representacion:


;---- Constructores ----;

(define drive (lambda (letter name capacity root)(list letter name capacity root)))
; Nombre: drive
; Dominio: letter(char) X name(string) X capacity(int)
; Recorrido: drive (list)
; Descripcion: Funcion constructora de drive, recibe tres strings y entrega
;              una lista construida a traves de pares que contiene la letra que
;              representa el drive, el nombre de este, su capacidad y un folder base vacio.


;---- Selectores ----;

(define drive_letter car)
; Nombre: drive_letter
; Dominio: drive
; Recorrido: char
; Descripcion: Funcion que recibe un drive y entrega la letra que lo representa.

(define drive_name cadr)
; Nombre: drive_name
; Dominio: drive
; Recorrido: string
; Descripcion: Funcion que recibe un drive y entrega su nombre.

(define drive_capacity caddr)
; Nombre: drive_capacity
; Dominio: drive
; Recorrido: int
; Descripcion: Funcion que recibe un drive y entrega su capacidad.

(define drive_root cadddr)
; Nombre: drive_root
; Dominio: drive
; Recorrido: list
; Descripcion: Funcion que recibe un drive y entrega su folder base (root).


;---- Pertenencia ----;


;---- Modificadores ----;

(define drive_add_folder (lambda (drv name path)
                           (drive
                            (drive_letter drv)
                            (drive_name drv)
                            (drive_capacity drv)
                            (folder_add_folder (drive_root drv) name path)
                           )))
; Nombre: drive_add_folder
; Dominio: drv(drive) X name(string) X path(path)
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un nombre y un path, y retorna el drive
;              con un folder (con el nombre indicado) agregado en la posicion indicada por el path.

;---- Otras Funciones ----;