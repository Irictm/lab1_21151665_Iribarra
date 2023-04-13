#lang racket
(provide folder folder_name folder_inside folder_creation_date folder_last_mod_date folder_inside_empty? folder_add_folder)
(require "generic-functions_21151665_IribarraBecerra.rkt")

; TDA folder
; Representacion:


;---- Constructores ----;

(define folder (lambda (name [occult ""] [read_only ""]) (list name null "Fecha (placeholder)" "Fecha mod (placehorlder)" occult read_only)))
; Nombre:
; Dominio: 
; Recorrido: 
; Descripcion: 

(define recreate_folder (lambda (name insides creation_date last_mod_date [occult ""] [read_only ""])
                          (list name insides creation_date last_mod_date occult read_only)
                          ))

;---- Selectores ----;

(define folder_name car)
; Nombre:
; Dominio: 
; Recorrido: 
; Descripcion:

(define folder_inside cadr)
; Nombre:
; Dominio: 
; Recorrido: 
; Descripcion:

(define folder_creation_date caddr)
; Nombre:
; Dominio: 
; Recorrido: 
; Descripcion:

(define folder_last_mod_date cadddr)
; Nombre:
; Dominio: 
; Recorrido: 
; Descripcion: 


;---- Pertenencia ----;

(define folder_inside_empty? null?)
; Nombre:
; Dominio: 
; Recorrido: 
; Descripcion: 


;---- Modificadores ----;

(define folder_add_folder (lambda (fldr name path)
                           (if (null? (cdr path))
                               (add_not_duped_value fldr (folder name) null? null)
                               (if (equal? (caar fldr) (cadr path))
                                   (cons (recreate_folder
                                          (folder_name (car fldr))
                                          (folder_add_folder (folder_inside (car fldr)) name (cdr path))
                                          (folder_creation_date (car fldr))
                                          "Fecha new mod (placeholder)") (cdr fldr))
                                   (cons (car fldr) (folder_add_folder (cdr fldr) name path))
                           ))))
; Nombre:
; Dominio: 
; Recorrido: 
; Descripcion: 

;---- Otras Funciones ----;
