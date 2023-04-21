#lang racket
(provide folder folder_name folder_inside folder_creation_date folder_last_mod_date folder_empty folder_empty? folder_add_folder_or_file folder_del folder_remove_dir folder_get_folder_or_file)
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

(define folder_get_folder_or_file (lambda (fldr name)
                     (if (folder_empty? fldr) folder_empty
                         (if (equal? (caar fldr) name)
                             (car fldr)
                             (if (list? (cadr (car fldr)))
                                 (if (folder_empty? (folder_inside (car fldr)))
                                     (folder_get_folder_or_file (cdr fldr) name)
                                     (folder_get_folder_or_file (folder_inside (car fldr)) name))
                                 (folder_get_folder_or_file (cdr fldr) name)))
                             )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Pertenencia ----;

(define folder_empty? null?)
; Nombre: folder_empty?
; Dominio: folder
; Recorrido: bool
; Descripcion: Funcion que recibe un folder y retorna #t si se encuentra vacio o #f caso contrario.

;---- Modificadores ----;

(define folder_add_folder_or_file (lambda (fldr new_object path)
                                    (if (folder_empty? (cdr path))
                                        (add_not_duped_value fldr new_object folder_empty? folder_empty)
                                        (if (equal? (caar fldr) (cadr path))
                                            (cons (recreate_folder
                                                   (folder_name (car fldr))
                                                   (folder_add_folder_or_file (folder_inside (car fldr)) new_object (cdr path))
                                                   (folder_creation_date (car fldr))
                                                   "Fecha new mod (placeholder)") (cdr fldr))
                                            (cons (car fldr) (folder_add_folder_or_file (cdr fldr) new_object path))
                                            ))))
; Nombre: folder_add_folder_or_file
; Dominio: fldr(folder) X new_object(folder or file) X path(path)
; Recorrido: folder
; Descripcion: Funcion que recibe un folder, un file o folder, un path y retorna un
;              folder con un file o folder creado dentro de este, en el path indicado.
; Recursion: natural

(define folder_del (lambda (fldr name)
                     (if (folder_empty? fldr) folder_empty
                         (if (equal? (caar fldr) name)
                             (folder_del (cdr fldr) name)
                             (if (list? (cadr (car fldr)))
                                 (cons (recreate_folder
                                      (folder_name (car fldr))
                                      (folder_del (folder_inside (car fldr)) name)
                                      (folder_creation_date (car fldr))
                                      "Fecha new mod (placeholder)") (folder_del (cdr fldr) name))
                                 (cons (car fldr) (folder_del (cdr fldr) name))))
                             )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define folder_remove_dir (lambda (fldr path)
                     (if (folder_empty? fldr) folder_empty
                         (if (equal? (caar fldr) (car path))
                             (if (null? (cdr path))
                                 (if (folder_empty? (folder_inside (car fldr)))
                                     (cdr fldr)
                                     fldr)
                                 (if (list? (cadr (car fldr)))
                                     (cons (recreate_folder
                                            (folder_name (car fldr))
                                            (folder_remove_dir (folder_inside (car fldr)) (cdr path))
                                            (folder_creation_date (car fldr))
                                            "Fecha new mod (placeholder)") (folder_remove_dir (cdr fldr) path))
                                     (cons (car fldr) (folder_remove_dir (cdr fldr) path))))
                             (if (list? (cadr (car fldr)))
                                     (cons (recreate_folder
                                            (folder_name (car fldr))
                                            (folder_remove_dir (folder_inside (car fldr)) path)
                                            (folder_creation_date (car fldr))
                                            "Fecha new mod (placeholder)") (folder_remove_dir (cdr fldr) path))
                                     (cons (car fldr) (folder_remove_dir (cdr fldr) path))))
                             )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Otras Funciones ----;
