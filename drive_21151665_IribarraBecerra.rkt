#lang racket
(provide drive drive_letter drive_name drive_capacity drive_root drive_add_folder_or_file drive_del drive_rd drive_get_folder_or_file_in_path drive_copy
         drive_get_folder_in_path drive_rename drive_format drive_encrypt drive_decrypt)
(require "folder_21151665_IribarraBecerra.rkt")

; TDA drive
; Representacion: Representado por una lista que contiene una letra(char), un nombre(string), una
;                 capacidad(int) y una raiz(list) donde se guardaran los folder y files que este contiene.


;---- Constructores ----;

(define drive (lambda (letter name capacity root)(list letter name capacity root)))
; Nombre: drive
; Dominio: letter(char) X name(string) X capacity(int)
; Recorrido: drive (list)
; Descripcion: Funcion constructora de drive, recibe tres strings y entrega
;              una lista construida a traves de pares que contiene la letra que
;              representa el drive, el nombre de este, su capacidad y una raiz base vacia.


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
; Descripcion: Funcion que recibe un drive y entrega su raiz.

(define drive_get_folder_or_file_in_path (lambda (drv path)
                                            (folder_get_folder_or_file_in_path (drive_root drv) path)))
; Nombre: drive_get_folder_or_file
; Dominio: drv(drive) X path
; Recorrido: folder or file
; Descripcion: Funcion que recibe un drive, un path y entrega el folder o file representado por el nombre
;              que se encuentra al final del path entregado dentro del drive entregado.

(define drive_get_folder_in_path (lambda (drv path)
                                    (folder_get_folder_in_path (drive_root drv) path)
                                    ))
; Nombre: drive_get_folder_in_path
; Dominio: drv(drive) X path
; Recorrido: folder
; Descripcion: Funcion que recibe un drive, un path y entrega el folder que se encuentra al final del path
;              que se encuentra en el drive.


;---- Pertenencia ----;


;---- Modificadores ----;

(define drive_change_root (lambda (drv root)
                            (drive
                             (drive_letter drv)
                             (drive_name drv)
                             (drive_capacity drv)
                             root)))
; Nombre: drive_change_root
; Dominio: drv(drive) X root(folder)
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un folder base (root) y entrega el drive con su folder base
;              reemplazado por el entregado.

(define drive_add_folder_or_file (lambda (drv object path)
                                   (drive_change_root drv (folder_add_folder_or_file (drive_root drv) object path)
                                   )))
; Nombre: drive_add_folder
; Dominio: drv(drive) X object(folder or file) X path(path)
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un folder o file y un path, y retorna el drive
;              con un folder o file agregado en la posicion indicada por el path.

(define drive_del (lambda (drv name path)
                           (drive_change_root drv (folder_del (drive_root drv) name path)
                           )))
; Nombre: drive_del
; Dominio: drv(drive) X name(string) X path
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un nombre, un path y retorna el drive
;              con el folder representado por el nombre indicado borrado de este en el path indicado.

(define drive_rd (lambda (drv path)
                           (drive_change_root drv (folder_remove_dir (drive_root drv) path)
                           )))
; Nombre: drive_rd
; Dominio: drv(drive) X path
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un path y retorna el drive con
;              el folder al final del path recibido eliminado si este se encuentra vacio.

(define drive_copy (lambda (drv object path)
                           (drive_change_root drv (folder_add_folder_or_file (drive_root drv) object path)
                           )))
; Nombre: drive_copy
; Dominio: drv(drive) X object(folder or file) X path
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un folder o file, un path y retorna un drive con
;              el folder o file recibido agregado al folder al final del path indicado.

(define drive_rename (lambda (drv name new_name path)
                       (drive_change_root drv (folder_rename (drive_root drv) name new_name path)
                        )))
; Nombre: drive_rename
; Dominio: drv(drive) X name(string) X new_name(string) X path
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un nombre, un nuevo nombre, un path y retorna un drive con
;              el folder representado por el nombre indicado, en el path indicado, cambiado por el folder
;              con el nuevo nombre indicado

(define drive_format (lambda (drv new_name)
                       (drive
                        (drive_letter drv)
                        new_name
                        (drive_capacity drv)
                        null
                        )))
; Nombre: drive_format
; Dominio: drv(drive) X new_name(string)
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, un nuevo nombre y retorna el drive recibido
;              con el nombre cambiado por el nuevo nombre indicado.

(define drive_encrypt (lambda (drv encryptFn decryptFn pass path)
                        (drive_change_root drv (folder_encrypt (drive_root drv) encryptFn decryptFn pass path)
                         )))
; Nombre: drive_encrypt
; Dominio: drv(drive) X encryptFn(procedure) X decryptFn(procedure) X pass(string) X path
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, una funcion de encriptacion, una funcion de desencriptacion,
;              una contraseña, un path y retorna el drive recibido con el folder o file al final del path indicado
;              encriptado por la funcion de encriptacion indicada y con la funcion de desencriptacion y contraseña indicadas
;              guardados dentro de la metadata del esta.

(define drive_decrypt (lambda (drv pass path)
                        (drive_change_root drv (folder_decrypt (drive_root drv) pass path)
                         )))
; Nombre: drive_decrypt
; Dominio: drv(drive) X pass(string) X path
; Recorrido: drive
; Descripcion: Funcion que recibe un drive, una contraseña, un path y retorna el drive recibido con el folder o file al final del path indicado
;              desencryptado solo si la contraseña indicada coincide con la contraseña de encriptacion del folder o file.

;---- Otras Funciones ----;