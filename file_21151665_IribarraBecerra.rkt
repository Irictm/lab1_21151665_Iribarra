#lang racket
(provide file recreate_file file_name file_extension file_content file_creation_date file_last_mod file_occult file_read_only file_occult? file_to_string)

; TDA file
; Representacion:


;---- Constructores ----;

(define file (lambda (name extension content [occult #\nul] [read_only #\nul]) (list name extension content "Fecha creacion (Placeholder)" "Fecha last mod (Placeholder)" occult read_only)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define recreate_file (lambda (name extension content creation_date last_mod_date [occult #\nul] [read_only #\nul]) (list name extension content creation_date last_mod_date occult read_only)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Selectores ----;

(define file_name car)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define file_extension cadr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define file_content caddr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define file_creation_date cadddr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define file_last_mod (lambda (fle) (list-ref fle 4)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define file_occult (lambda (fle) (list-ref fle 5)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define file_read_only (lambda (fle) (list-ref fle 6)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Pertenencia ----;

(define file_occult? (lambda (fle) (equal? #\h (file_occult fle))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Modificadores ----;

;---- Otras Funciones ----;

(define file_to_string (lambda (fle)
                         (string-append "[" (file_creation_date fle) "]" " [File] - " (file_name fle))))

; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:
