#lang racket
(provide folder folder_name folder_inside folder_creation_date folder_last_mod_date folder_empty folder_empty? folder_add_folder)
(require "generic-functions_21151665_IribarraBecerra.rkt")

; TDA folder
; Representacion:


;---- Constructores ----;

(define folder (lambda (name [occult ""] [read_only ""]) (list name null "Fecha (placeholder)" "Fecha mod (placehorlder)" occult read_only)))
; Nombre: folder
; Dominio: name(string) X occult(char)[OPCIONAL] X read_only(char)[OPCIONAL]
; Recorrido: folder(list)
; Descripcion: Funcion constructora de folder, recibe un nombre y entrega un
;              folder con el nombre indicado, ademas de la fecha de creacion y fecha de ultima
;              modificacion guardados en este. Cabe destacar que se pueden agregar los argumentos occult
;              y read_only, los cuales de ser indicados se guardaran. Si estos ultimos no son indicados
;              se guardaran char vacios en su lugar.

(define recreate_folder (lambda (name insides creation_date last_mod_date [occult ""] [read_only ""])
                          (list name insides creation_date last_mod_date occult read_only)
                          ))
; Nombre: recreate_folder
; Dominio: name(string) X insides(list) X creation_date(date) X last_mod_date(date) X occult(char)[OPCIONAL] X read_only(char)[OPCIONAL]
; Recorrido: folder(list)
; Descripcion: Funcion constructora de folder, recibe todos los atributos de un folder y crea este con los atributos indicados.

(define folder_empty null)
; Nombre: folder_empty
; Dominio: none
; Recorrido: null (empty list)
; Descripcion: Funcion constructora de folder, entrega un folder vacio.

;---- Selectores ----;

(define folder_name car)
; Nombre: folder_name
; Dominio: folder
; Recorrido: string
; Descripcion: Funcion que recibe un folder y retorna su nombre.

(define folder_inside cadr)
; Nombre: folder_inside
; Dominio: folder
; Recorrido: list
; Descripcion: Funcion que recibe un folder y retorna el interior de este.

(define folder_creation_date caddr)
; Nombre: folder_creation_date
; Dominio: folder
; Recorrido: date
; Descripcion: Funcion que recibe un folder y retorna su fecha de creacion.

(define folder_last_mod_date cadddr)
; Nombre: folder_last_mod_date
; Dominio: folder
; Recorrido: date
; Descripcion: Funcion que recibe un folder y retorna su fecha de ultima modificacion.


;---- Pertenencia ----;

(define folder_empty? null?)
; Nombre: folder_empty?
; Dominio: folder
; Recorrido: bool
; Descripcion: Funcion que recibe un folder y retorna #t si se encuentra vacio o #f caso contrario.

;---- Modificadores ----;

(define folder_add_folder (lambda (fldr name path)
                           (if (null? (cdr path))
                               (add_not_duped_value fldr (folder name) folder_empty? folder_empty)
                               (if (equal? (caar fldr) (cadr path))
                                   (cons (recreate_folder
                                          (folder_name (car fldr))
                                          (folder_add_folder (folder_inside (car fldr)) name (cdr path))
                                          (folder_creation_date (car fldr))
                                          "Fecha new mod (placeholder)") (cdr fldr))
                                   (cons (car fldr) (folder_add_folder (cdr fldr) name path))
                           ))))
; Nombre: folder_add_folder
; Dominio: fldr(folder) X name(string) X path(path)
; Recorrido: folder
; Descripcion: Funcion que recibe un folder, un nombre, un path y retorna un
;              folder con un folder creado dentro de este con el nombre indicado, en el path indicado.
; Recursion: natural

;---- Otras Funciones ----;
