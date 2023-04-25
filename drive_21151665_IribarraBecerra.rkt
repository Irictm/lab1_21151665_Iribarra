#lang racket
(provide drive drive_letter drive_name drive_capacity drive_root drive_add_folder_or_file drive_del drive_rd drive_get_folder_or_file drive_copy
         drive_get_folder_in_path drive_rename drive_format)
(require "folder_21151665_IribarraBecerra.rkt" "path_21151665_IribarraBecerra.rkt")

; TDA drive
; Representacion:


;---- Constructores ----;

(define drive (lambda (letter name capacity root)(list letter name capacity root)))
; Nombre: drive
; Dominio: letter(char) X name(string) X capacity(int)
; Recorrido: drive (list)
; Descripcion: Funcion constructora de drive, recibe tres strings y entrega
;              una lista construida a traves de pares que contiene la letra que
;              representa el drive, el nombre de este, su capacidad y un folder base vacio.


;---- Selectores ----;

(define drive_letter car)
; Nombre: drive_letter
; Dominio: drive
; Recorrido: char
; Descripcion: Funcion que recibe un drive y entrega la letra que lo representa.

(define drive_name cadr)
; Nombre: drive_name
; Dominio: drive
; Recorrido: string
; Descripcion: Funcion que recibe un drive y entrega su nombre.

(define drive_capacity caddr)
; Nombre: drive_capacity
; Dominio: drive
; Recorrido: int
; Descripcion: Funcion que recibe un drive y entrega su capacidad.

(define drive_root cadddr)
; Nombre: drive_root
; Dominio: drive
; Recorrido: list
; Descripcion: Funcion que recibe un drive y entrega su folder base (root).

(define drive_get_folder_or_file (lambda (drv name)
                                  (folder_get_folder_or_file (drive_root drv) name)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drive_get_folder_in_path (lambda (drv path)
                                    (folder_get_folder_in_path (drive_root drv) (cdr path))
                                    ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:


;---- Pertenencia ----;


;---- Modificadores ----;

(define drive_add_folder_or_file (lambda (drv object path)
                                   (drive
                                    (drive_letter drv)
                                    (drive_name drv)
                                    (drive_capacity drv)
                                    (folder_add_folder_or_file (drive_root drv) object path)
                                    )))
; Nombre: drive_add_folder
; Dominio: drv(drive) X object(folder or file) X path(path)
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un folder o file y un path, y retorna el drive
;              con un folder o file agregado en la posicion indicada por el path.


(define drive_del (lambda (drv name)
                           (drive
                            (drive_letter drv)
                            (drive_name drv)
                            (drive_capacity drv)
                            (folder_del (drive_root drv) name)
                           )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drive_rd (lambda (drv path)
                           (drive
                            (drive_letter drv)
                            (drive_name drv)
                            (drive_capacity drv)
                            (folder_remove_dir (drive_root drv) path)
                           )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drive_copy (lambda (drv object path)
                           (drive
                            (drive_letter drv)
                            (drive_name drv)
                            (drive_capacity drv)
                            (folder_add_folder_or_file (drive_root drv) object path)
                           )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drive_rename (lambda (drv name new_name path)
                       (drive
                        (drive_letter drv)
                        (drive_name drv)
                        (drive_capacity drv)
                        (folder_rename (drive_root drv) name new_name path)
                        )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define drive_format (lambda (drv new_name)
                       (drive
                        (drive_letter drv)
                        new_name
                        (drive_capacity drv)
                        null
                        )))

;---- Otras Funciones ----;