#lang racket
(provide file recreate_file file_name file_extension file_content file_creation_date file_last_mod file_occult file_read_only file_occult? file_read_only?
         file_to_string file_encryption_data file_encryption_data_func file_encryption_data_pass file_encrypted?)
(require "date_21151665_IribarraBecerra.rkt")

; TDA file
; Representacion: Representado por una lista que contiene un nombre(string), una extension(string), un contenido(string),
;                 la fecha de creacion(string), la fecha de ultima modificacion(string), atributo
;                 de seguridad "oculto"(char, #\h si se encuentra oculto, #\nul si no), atributo de seguridad
;                 "solo lectura"(char, #\r si se encuentra en modo solo lectura, #\nul si no), una lista vacia donde se guardaran
;                 datos de encriptacion(list, la funcion de desencriptacion en la primera posicion, la contraseña en la segunda).


;---- Constructores ----;

(define file (lambda (name extension content [occult #\nul] [read_only #\nul]) (list (string-downcase name) extension content current_date current_date occult read_only null)))
; Nombre: file
; Dominio: name(string) X extension(string) X content(string) X occult(char)[OPCIONAL] X read_only(char)[OPCIONAL]
; Recorrido: file(list)
; Descripcion: Funcion constructora de file, recibe un nombre, extension, contenido y retorna una lista que contiene
;              el nombre indicado, la extension indicada, el contenido indicado, la fecha de creacion, la fecha de
;              ultima modificacion, atributos de oculto, solo lectura y una lista vacia donde se guardaran los datos de encriptacion.

(define recreate_file (lambda (name extension content creation_date last_mod_date [occult #\nul] [read_only #\nul] [encryption_data null])
                        (list name extension content creation_date last_mod_date occult read_only encryption_data)))
; Nombre: recreate_file
; Dominio: name(string) X extension(string) X content(string) X creation_date(string) X last_mod_date(string) X occult(char) X read_only(char) X encryption_data(null)
; Recorrido: file(list)
; Descripcion: Funcion constructora de file que recibe los valores mencionadas anteriormente y
;              retorna una lista que contiene estos.

;---- Selectores ----;

(define file_name car)
; Nombre: file_name
; Dominio: file
; Recorrido: string
; Descripcion: Funcion que recibe un file y retorna su nombre.

(define file_extension cadr)
; Nombre: file_extension
; Dominio: file
; Recorrido: string 
; Descripcion: Funcion que recibe un file y retorna su extension.

(define file_content caddr)
; Nombre: file_content
; Dominio: file
; Recorrido: string
; Descripcion: Funcion que recibe un file y retorna su contenido.

(define file_creation_date cadddr)
; Nombre: file_creation_date
; Dominio: file
; Recorrido: string
; Descripcion: Funcion que recibe un file y retorna su fecha de creacion.

(define file_last_mod (lambda (fle) (list-ref fle 4)))
; Nombre: file_last_mod
; Dominio: file
; Recorrido: string 
; Descripcion: Funcion que recibe un file y retorna su fecha de ultima modificacion.

(define file_occult (lambda (fle) (list-ref fle 5)))
; Nombre: file_occult
; Dominio: file
; Recorrido: char
; Descripcion: Funcion que recibe un file y retorna su atributo de "oculto".

(define file_read_only (lambda (fle) (list-ref fle 6)))
; Nombre: file_read_only
; Dominio: file
; Recorrido: char
; Descripcion: Funcion que recibe un file y retorna su atributo de "solo lectura".

(define file_encryption_data (lambda (fle) (list-ref fle 7)))
; Nombre: file_encryption_data
; Dominio: file
; Recorrido: list
; Descripcion: Funcion que recibe un file y retorna sus datos de encripcion.

(define file_encryption_data_func (lambda (fle) (if (null? (list-ref fle 7)) null
                                                       (car (list-ref fle 7)))))
; Nombre: file_encryption_data_func
; Dominio: file
; Recorrido: procedure
; Descripcion: Funcion que recibe un file y retorna su funcion de desencriptacion.

(define file_encryption_data_pass (lambda (fle) (if (null? (list-ref fle 7)) null
                                                       (cadr (list-ref fle 7)))))
; Nombre: file_encryption_data_pass
; Dominio: file
; Recorrido: int
; Descripcion: Funcion que recibe un file y retorna su contraseña de desencriptacion.

;---- Pertenencia ----;

(define file_occult? (lambda (fle) (equal? #\h (file_occult fle))))
; Nombre: file_occult?
; Dominio: fle(file)
; Recorrido: bool
; Descripcion: Funcion que recibe un file y retorna #t si este se encuentra oculto o #f en caso contrario.

(define file_read_only? (lambda (fle) (equal? #\r (file_read_only fle))))
; Nombre: file_read_only?
; Dominio: fle(file)
; Recorrido: bool
; Descripcion: Funcion que recibe un file y retorna #t si este se encuentra en modo solo lectura o #f en caso contrario.

(define file_encrypted? (lambda (fle) (not (null? (file_encryption_data fle)))))
; Nombre: file_encrypted?
; Dominio: fle(file)
; Recorrido: bool
; Descripcion: Funcion que recibe un file y retorna #t si este se encuentra encriptado o #f en caso contrario.

;---- Modificadores ----;

;---- Otras Funciones ----;

(define file_to_string (lambda (fle)
                         (string-append "[" (file_creation_date fle) "]" " [File] - " (file_name fle) "\n")))

; Nombre: file_to_string
; Dominio: fle(file)
; Recorrido: string
; Descripcion: Funcion que recibe un file y retorna un string que representa el file, indicando su fecha de creacion
;              y su nombre.
