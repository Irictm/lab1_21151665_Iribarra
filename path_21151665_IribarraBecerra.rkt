#lang racket
(provide path_empty path_empty? path_add_location path_string_to_path path_first_location_listed path_previous_location path_del_location path_remove_directory)
(require "folder_21151665_IribarraBecerra.rkt")

; TDA path
; Representacion: Una lista que contiene locaciones(strings) que representan folders. La primera locacion de un path puede
;                 ser una letra(char) que represente la raiz de un drive. Un path vacio se representara por una lista vacia.


;---- Constructores ----;

(define path_empty null)
; Nombre: path_empty
; Dominio: none
; Recorrido: null (empty list)
; Descripcion: Funcion constructora de path, retorna un path vacio (lista vacia)

(define path_add_location (lambda (path_original location) (append path_original location)))
; Nombre: path_add_location
; Dominio: path_original(list) X location(string or char)
; Recorrido: path (list)
; Descripcion: Funcion que recibe un path y una ubicacion, y retorna el path con la nueva ubicacion agragada

(define path_string_to_path (lambda (path_as_string)
                              (if (equal? (string(string-ref path_as_string 0)) (string-trim (car(string-split path_as_string "/")) ":"))
                                  (cons (char-upcase (string-ref path_as_string 0)) (map string-downcase (cdr (string-split path_as_string "/"))))
                                  (map string-downcase (string-split path_as_string "/")))
                              ))
; Nombre: path_string_to_path
; Dominio:  path_as_string (string)
; Recorrido: path (list)
; Descripcion: Funcion que recibe un string formateado (nombres separados por /) y lo convierte a un path.

;---- Selectores ----;

(define path_first_location_listed (lambda (path) (list (car path))))
; Nombre: path_first_location
; Dominio: path
; Recorrido: string or char
; Descripcion: Funcion que recibe un path y entrega la primera ubicacion de este dentro de una lista.

(define path_last_location (lambda (path)
                             (if (path_empty? (cdr path))
                                 (car path)
                                 (path_last_location (cdr path)))
                             ))
; Nombre: path_last_location
; Dominio: path
; Recorrido: string or char
; Descripcion: Funcion que recibe un path y entrega la ultima ubicacion de este.
; Recursion: De cola

;---- Pertenencia ----;

(define path_empty? null?)
; Nombre: path_empty?
; Dominio: path
; Recorrido: bool
; Descripcion: Funcion que entrega #t si el path esta vacio y #f en caso contrario.

;---- Modificadores ----;

(define path_previous_location (lambda (path)
                                 (if (and (char? (car path)) (path_empty? (cdr path))) path
                                     (if (path_empty? (cdr path)) null
                                         (cons (car path) (path_previous_location (cdr path))))
                                 )))
; Nombre: path_previous_location
; Dominio: path
; Recorrido: path
; Descripcion: Funcion que recibe un path y retorna el path sin su ultima locacion.
;              Si el path solo tenia el char de un drive como locacion retorna el mismo path.
; Recursion: natural

(define path_del_location (lambda (path name_location)
                            (if (path_empty? path) null
                                (if (equal? (car path) name_location) null
                                    (cons (car path) (path_del_location (cdr path) name_location))
                            ))))
; Nombre: path_del_location
; Dominio: path X name_location(string)
; Recorrido: path
; Descripcion: Funcion que recibe un path y entrega el path con las locaciones hasta
;              la locacion anterior a la cual tiene el nombre indicado.
; Recursion: natural

(define path_remove_directory (lambda (path folder_location)
                                (if (folder_empty? folder_location) path
                                    (if (folder_empty? (folder_inside folder_location))
                                        (if (equal? (path_last_location path) (folder_name folder_location))
                                            (path_previous_location path)
                                            path)
                                        path))
                                ))
; Nombre: path_remove_directory
; Dominio: path X folder_location(folder)
; Recorrido: path
; Descripcion: Funcion que recibe un path y una locacion y remueve la ultima locacion de este si el folder entregado (folder_location)
;              tiene su nombre guardado en el path y si este se encuentra vacio.

;---- Otras Funciones ----;
