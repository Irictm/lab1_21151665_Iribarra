#lang racket
(provide drives_empty drives_add_drive drives_empty? drives_exists_drive? drives_drive_add_folder_or_file drives_drive_del drives_drive_rd drives_drive_copy
         drives_drive_move drives_get_folder_in_path drives_drive_rename drives_drive_format)
(require "drive_21151665_IribarraBecerra.rkt" "path_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

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

(define drives_get_folder_or_file (lambda (drives_list name)
                                    (if (drives_empty? drives_list) drives_list
                                        (if (null? (drive_get_folder_or_file (car drives_list) name))
                                            (drives_get_folder_or_file (cdr drives_list) name)
                                            (drive_get_folder_or_file (car drives_list) name)))
                                    ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drives_get_folder_in_path (lambda (drives_list path)
                                    (if (drives_empty? drives_list) drives_list
                                        (if (equal? (drive_letter (car drives_list)) (car path))
                                            (drive_get_folder_in_path (car drives_list) path)
                                            (drives_get_folder_in_path (cdr drives_list) path)))
                                    ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

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

(define drives_drive_add_folder_or_file (lambda (drives_list drv_letter object path)
                                          (if (drives_empty? drives_list)
                                              drives_list
                                              (if (equal? (caar drives_list) drv_letter)
                                                  (cons (drive_add_folder_or_file (car drives_list) object path) (cdr drives_list))
                                                  (cons (car drives_list) (drives_drive_add_folder_or_file (cdr drives_list) drv_letter object path)
                                                        )))))
; Nombre: drives_drive_add_folder
; Dominio: drives_list(drives) X drv_letter(char) X object(folder or file) X path(path)
; Recorrido: drives
; Descripcion: Funcion que recibe una lista de drives, la letra de un drive, un folder o file,
;              un path y retorna la lista de drives con un folder o file agregado al
;              drive representado por la letra indicada, en el path indicado.
; Recursion: natural


(define drives_drive_del (lambda (drives_list name)
                           (if (drives_empty? drives_list)
                                      drives_list
                                      (cons (drive_del (car drives_list) name) (drives_drive_del (cdr drives_list) name))
                                  )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drives_drive_rd (lambda (drives_list name_or_path)
                          (if (drives_empty? drives_list) drives_list
                              (if (char? (car (path_string_to_path name_or_path)))
                                  (if (equal? (car (path_string_to_path name_or_path)) (drive_letter (car drives_list)))
                                      (cons (drive_rd (car drives_list) (cdr (path_string_to_path name_or_path))) (cdr drives_list))
                                      (cons (car drives_list) (drives_drive_rd (cdr drives_list) name_or_path)))
                                  (cons (drive_rd (car drives_list) (path_string_to_path name_or_path)) (drives_drive_rd (cdr drives_list) name_or_path))
                              ))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drives_drive_copy (lambda (drives_list drv_letter name path)
                           (drives_drive_add_folder_or_file drives_list drv_letter (drives_get_folder_or_file drives_list name) path)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drives_drive_move (lambda (drives_list drv_letter name path)
                            (drives_drive_add_folder_or_file (drives_drive_del drives_list name) drv_letter (drives_get_folder_or_file drives_list name) path)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drives_drive_rename (lambda (drives_list name new_name path)
                              (if (drives_empty? drives_list) drives_list
                                  (if (equal? (caar drives_list) (car path))
                                      (cons (drive_rename (car drives_list) name new_name path) (cdr drives_list))
                                      (cons (car drives_list) (drives_drive_rename (cdr drives_list) name new_name path)
                                            )))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drives_drive_format (lambda (drives_list letter new_name)
                              (if (drives_empty? drives_list) drives_list
                                  (if (equal? (caar drives_list) letter)
                                      (cons (drive_format (car drives_list) new_name) (cdr drives_list))
                                      (cons (car drives_list) (drives_drive_format (cdr drives_list) letter new_name)
                                            )))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Otras Funciones ----;
