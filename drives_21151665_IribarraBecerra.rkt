#lang racket
(provide drives_empty drives_add_drive drives_empty? drives_exists_drive? drives_drive_add_folder_or_file drives_drive_del drives_drive_rd drives_drive_copy
         drives_drive_move drives_get_folder_in_path drives_get_folder_or_file_in_path drives_drive_rename drives_drive_format drives_drive_encrypt drives_drive_decrypt)
(require "drive_21151665_IribarraBecerra.rkt" "path_21151665_IribarraBecerra.rkt" "generic-functions_21151665_IribarraBecerra.rkt")

; TDA drives
; Representacion: Representado por una lista vacia o una lista que contiene uno o multiples drive.


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

(define drives_get_folder_or_file_in_path (lambda (drives_list name path)
                                    (if (drives_empty? drives_list) drives_list
                                        (if (char? (car path))
                                            (if (equal? (drive_letter (car drives_list)) (car path))
                                                (drive_get_folder_or_file_in_path (car drives_list) (path_add_location (cdr path) (path_string_to_path name)))
                                                (drives_get_folder_or_file_in_path (cdr drives_list) name path))
                                            (if (null? (drive_get_folder_or_file_in_path (car drives_list) (path_add_location (cdr path) (path_string_to_path name))))
                                                (drives_get_folder_or_file_in_path (cdr drives_list) name path)
                                                (drive_get_folder_or_file_in_path (car drives_list) (path_add_location path (path_string_to_path name))))))
                                    ))
; Nombre: drives_get_folder_or_file_in_path
; Dominio: drives_list(drives) X name(string) X path 
; Recorrido: folder or file
; Descripcion: Funcion que recibe una lista de drives y retorna el folder o file representado por ese nombre
;              al final del path, que se encuentra en algun drive en la lista de drives.
; Recursion: De cola

(define drives_get_folder_in_path (lambda (drives_list path)
                                    (if (drives_empty? drives_list) drives_list
                                        (if (char? (car path))
                                            (if (equal? (drive_letter (car drives_list)) (car path))
                                                (drive_get_folder_in_path (car drives_list) (cdr path))
                                                (drives_get_folder_in_path (cdr drives_list) path))
                                            (if (null? (drive_get_folder_in_path (car drives_list) path))
                                                (drives_get_folder_in_path (cdr drives_list) path)
                                                (drive_get_folder_in_path (car drives_list) path))))
                                    ))
; Nombre: drives_get_folder_in_path
; Dominio: drives_list(drives) X path 
; Recorrido: folder
; Descripcion: Funcion que recibe una lista de drives y retorna el folder al final del path entregado
;              que se encuentra en algun drive en la lista de drives.
; Recursion: De cola

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
; Recursion: De cola

;---- Modificadores ----;

(define drives_drive_add_folder_or_file (lambda (drives_list drv_letter object path)
                                          (if (drives_empty? drives_list) drives_list
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


(define drives_drive_del (lambda (drives_list name path)
                           (if (drives_empty? drives_list) drives_list
                               (if (equal? (caar drives_list) (car path))
                                   (cons (drive_del (car drives_list) name path) (cdr drives_list))
                                   (cons (car drives_list) (drives_drive_del (cdr drives_list) name path)))
                                  )))
; Nombre: drives_drive_del
; Dominio: drives_list(drives) X name(string) X path
; Recorrido: drive
; Descripcion: Funcion que recibe una lista de drives, un nombre y retorna la lista de drives con un folder
;              representado por el nombre indicado eliminado de el drive en la lista de drives en el cual se encontraba
;              y de el path encontrado.
; Recursion: natural

(define drives_drive_rd (lambda (drives_list path)
                          (if (drives_empty? drives_list) drives_list
                              (if (equal? (car path) (drive_letter (car drives_list)))
                                      (cons (drive_rd (car drives_list) (cdr path)) (cdr drives_list))
                                      (cons (car drives_list) (drives_drive_rd (cdr drives_list) path)))
                              )))
; Nombre: drives_drive_rd
; Dominio: drives_list(drives) X path
; Recorrido: drive
; Descripcion: Funcion que recibe una lista de drives, un path y retorna la lista de drives con el folder
;              representado por el nombre indicado al final del path indicado eliminado si este se encuentra vacio.
; Recursion: natural

(define drives_drive_copy (lambda (drives_list drv_letter name path sys_path)
                           (drives_drive_add_folder_or_file drives_list drv_letter (drives_get_folder_or_file_in_path drives_list name sys_path) path)))
; Nombre: drives_drive_copy
; Dominio: drives_list(drives) X drv_letter(char) X name(string) X path X sys_path(path)
; Recorrido: drive
; Descripcion: Funcion que recibe una lista de drives, una letra, un nombre, un path, el path del systema y retorna una lista de drives con
;              el folder representado por el nombre indicado en el path del sistema, duplicado y agregado al final del path indicado dentro del
;              drive representado por la letra indicada.

(define drives_drive_move (lambda (drives_list drv_letter name path sys_path)
                            (drives_drive_add_folder_or_file (drives_drive_del drives_list name sys_path) drv_letter (drives_get_folder_or_file_in_path drives_list name sys_path) path)))
; Nombre: drives_drive_move
; Dominio: drives_list(drives) X drv_letter(char) X name(string) X path X sys_path(path)
; Recorrido: drive
; Descripcion: Funcion que recibe una lista de drives, una letra, un nombra, un path, el path del systema y retorna una lista de drives con
;              el folder representado por el nombre indicado eliminado del path del sistema y una copia de este agregada al path indicado
;              dentro del drive representado por la letra indicada.

(define drives_drive_rename (lambda (drives_list name new_name path)
                              (if (drives_empty? drives_list) drives_list
                                  (if (equal? (drive_letter (car drives_list)) (car path))
                                      (cons (drive_rename (car drives_list) name new_name path) (cdr drives_list))
                                      (cons (car drives_list) (drives_drive_rename (cdr drives_list) name new_name path))
                                            ))))
; Nombre: drives_drive_rename
; Dominio: drives_list(drives) X name(string) X new_name(string) X path
; Recorrido: drive
; Descripcion: Funcion que recibe una lista de drives, un nombre, un nuevo nombre, un path y retorna una lista de drives con
;              el folder o file representado por el nombre indicado, al final del path indicado, recreado con el nuevo nombre
;              indicado, ocurriendo lo anterior en alguno del los drives dentro de la lista de drives indicada.
; Recursion: natural

(define drives_drive_format (lambda (drives_list letter new_name)
                              (if (drives_empty? drives_list) drives_list
                                  (if (equal? (caar drives_list) letter)
                                      (cons (drive_format (car drives_list) new_name) (cdr drives_list))
                                      (cons (car drives_list) (drives_drive_format (cdr drives_list) letter new_name)
                                            )))))
; Nombre: drives_drive_format
; Dominio: drives_list(drives) X letter(char) X new_name(string)
; Recorrido: drive
; Descripcion: Funcion que recibe una lista de drives, una letra, un nuevo nombre y retorna la lista de drives con
;              el drive representado por la letra indicada formateado, es decir, con su contenido borrado y con su nombre cambiado
;              por el nuevo nombre indicado
; Recursion: natural

(define drives_drive_encrypt (lambda (drives_list encryptFn decryptFn pass path)
                               (if (drives_empty? drives_list) drives_list
                                   (if (equal? (car path) (drive_letter (car drives_list)))
                                       (cons (drive_encrypt (car drives_list) encryptFn decryptFn pass (cdr path)) (cdr drives_list))
                                       (cons (car drives_list) (drives_drive_encrypt (cdr drives_list) encryptFn decryptFn pass path)))
                                   )))
; Nombre: drives_drive_encrypt
; Dominio: drives_list(drives) X encryptFn(procedure) X decryptFn(procedure) X pass(string) X path
; Recorrido: drive
; Descripcion: Funcion que recibe una lista de drives, una funcion de encriptacion, una funcion de desencriptacion,
;              una contraseña, un path y retorna una lista de drives con un folder o file representado por el nombre indicado o
;              al final del path indicado encriptado por la funcion de encriptacion indicada y con la funcion de desencriptacion y contraseña indicadas
;              guardados dentro de la metadata del esta, dentro de algun drive dentro de la lista de drives.
; Recursion: natural

(define drives_drive_decrypt (lambda (drives_list pass path)
                               (if (drives_empty? drives_list) drives_list
                                   (if (equal? (car path) (drive_letter (car drives_list)))
                                       (cons (drive_decrypt (car drives_list) pass (cdr path)) (cdr drives_list))
                                       (cons (car drives_list) (drives_drive_decrypt (cdr drives_list) pass path)))
                                   )))
; Nombre: drives_drive_decrypt
; Dominio: drives_list(drives) X pass(string) X path
; Recorrido: drive
; Descripcion: Funcion que recibe una lista de drives, una contraseña, un path y retorna una lista de drives con
;              el folder o file representado por el nombre al final del path indicado desencriptado solo si la contraseña
;              indicada coincide con la contraseña con la que fue encriptado, dentro de algun drive en la lista de drives.
; Recursion: natural

;---- Otras Funciones ----;
