#lang racket
(provide drives_empty drives_add_drive drives_empty? drives_exists_drive? drives_drive_add_folder)
(require "drive_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

; TDA drives
; Representacion:


;---- Constructores ----;

(define drives_empty null)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drives_add_drive (lambda (drives_list letter name capacity)
                    (add_not_duped_value drives_list (drive letter name capacity null) drives_empty? drives_empty)
                    ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

;---- Selectores ----;


;---- Pertenencia ----;

(define drives_empty? null?)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion: 

(define drives_exists_drive? (lambda (drives_list letter)
                             (if (drives_empty? drives_list)
                                 false
                                 (if (equal? (caar drives_list) letter) true
                                 (drives_exists_drive? (cdr drives_list) letter))
                             )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Modificadores ----;

(define drives_drive_add_folder (lambda (drives_list drv_name fldr_name path)
                                  (if (drives_empty? drives_list)
                                      (drives_list)
                                      (if (equal? (caar drives_list) drv_name)
                                          (cons (drive_add_folder (car drives_list) fldr_name path) (cdr drives_list))
                                          (cons (car drives_list) (drives_drive_add_folder (cdr drives_list) drv_name fldr_name path)
                                  )))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Otras Funciones ----;
