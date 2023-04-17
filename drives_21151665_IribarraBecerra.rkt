#lang racket
(provide drives_empty drives_add_drive drives_empty? drives_exists_drive? drives_drive_add_folder drives_drive_add_file)
(require "drive_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

; TDA drives
; Representacion:


;---- Constructores ----;

(define drives_empty null)
; Nombre: drives_empty
; Dominio: none
; Recorrido: null (empty list)
; Descripcion: Funcion constructora de drives, retorna una lista de drives vacia.

(define drives_add_drive (lambda (drives_list letter name capacity)
                    (add_not_duped_value drives_list (drive letter name capacity null) drives_empty? drives_empty)
                    ))
; Nombre: drives_add_drive
; Dominio: drives_list(drives) X letter(char) X name(string) X capacity(int)
; Recorrido: drives (list)
; Descripcion: Funcion constructora de drives, recibe una lista de drives, una letra, un nombre ,una capacidad
;              y entrega la lista de drives con un drive agregado con la letra, nombre y capacidad entregadas.

;---- Selectores ----;


;---- Pertenencia ----;

(define drives_empty? null?)
; Nombre: drives_empty?
; Dominio: drives
; Recorrido: bool
; Descripcion: Funcion que recibe una lista de drives y retorna #t si esta se encuentra vacia
;              o #f si no lo esta.

(define drives_exists_drive? (lambda (drives_list letter)
                             (if (drives_empty? drives_list)
                                 false
                                 (if (equal? (caar drives_list) letter) true
                                 (drives_exists_drive? (cdr drives_list) letter))
                             )))
; Nombre: drives_exists_drive?
; Dominio: drives_list(drives) X letter(char)
; Recorrido: bool
; Descripcion: Funcion que recibe una lista de drives, una letra y retorna #t si existe un drive
;              representado por esa letra en la lista de drives o #f si este no es el caso.
; Recursion: de cola

;---- Modificadores ----;

(define drives_drive_add_folder (lambda (drives_list drv_letter fldr_name path)
                                  (if (drives_empty? drives_list)
                                      (drives_list)
                                      (if (equal? (caar drives_list) drv_letter)
                                          (cons (drive_add_folder (car drives_list) fldr_name path) (cdr drives_list))
                                          (cons (car drives_list) (drives_drive_add_folder (cdr drives_list) drv_letter fldr_name path)
                                  )))))
; Nombre: drives_drive_add_folder
; Dominio: drives_list(drives) X drv_letter(char) X fldr_name(string) X path(path)
; Recorrido: drives
; Descripcion: Funcion que recibe una lista de drives, la letra de un drive, un nombre de un folder,
;              un path y retorna la lista de drives con un folder creado con el nombre indicado
;              agregado al drive representado por la letra indicada, en el path indicado.
; Recursion: natural

(define drives_drive_add_file (lambda (drives_list drv_letter new_file path)
                                  (if (drives_empty? drives_list)
                                      (drives_list)
                                      (if (equal? (caar drives_list) drv_letter)
                                          (cons (drive_add_file (car drives_list) new_file path) (cdr drives_list))
                                          (cons (car drives_list) (drives_drive_add_file (cdr drives_list) drv_letter new_file path)
                                  )))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Otras Funciones ----;
