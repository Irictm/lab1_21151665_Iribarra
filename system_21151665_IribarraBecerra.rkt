#lang racket
(require "drives_21151665_IribarraBecerra.rkt" "users_21151665_IribarraBecerra.rkt"
         "path_21151665_IribarraBecerra.rkt" "file_21151665_IribarraBecerra.rkt"
         "folder_21151665_IribarraBecerra.rkt" "date_21151665_IribarraBecerra.rkt")
(provide system run add-drive register login logout switch-drive md cd add-file del rd
         copy move ren dir format encrypt decrypt plus-one minus-one)

; TDA system
; Representacion: Representado por una lista que contiene el nombre del sistema(string),
;                 una lista de drives(drives), una lista de usuarios(users), un path actual(path),
;                 el usuario activo actual(string), fecha de creacion(string) y fecha de ultima modificacion(string).


;---- Constructores ----;

(define system (lambda (sys_name)
                 (list sys_name drives_empty users_empty path_empty "" current_date current_date)
                 ))
; Nombre: system
; Dominio: sys_name(string)
; Recorrido: system (list)
; Descripcion: Funcion constructora del systema, recibe un nombre y entrega
;              una lista que contiene el nombre del systema, una lista
;              de drives vacia, una lista de usuarios vacia, el path actual
;              representado por una lista vacia, un string indicando que no existe
;              usuario actual, la fecha de creacion y la fecha de ultima modificacion.

(define system_recreate (lambda (sys_name sys_drive sys_users sys_path sys_act_user sys_create_date sys_last_mod_date)
                          (list sys_name sys_drive sys_users sys_path sys_act_user sys_create_date sys_last_mod_date)
                          ))
; Nombre: system_recreate
; Dominio: sys_name(string) X sys_drive(list) X sys_users(list) X sys_path(list) X sys_act_user X sys_create_date(string) X sys_last_mod_date(srting)
; Recorrido: system(list)
; Descripcion: Funcion constructora de system, recibe los atributos anteriormente mencionados y retorna un sistema con estos.

;---- Selectores ----;

(define system_name car)
; Nombre: system_name
; Dominio: system
; Recorrido: string
; Descripcion: Funcion selectora de system, recibe un sistema y retorna su nombre.

(define system_drives cadr)
; Nombre: system_drives
; Dominio: system
; Recorrido: drives
; Descripcion: Funcion selectora de system, recibe un sistema y retorna su lista de drives.

(define system_users caddr)
; Nombre: system_users
; Dominio: system
; Recorrido: users
; Descripcion: Funcion selectora de system, recibe un sistema y retorna su lista de usuarios.

(define system_path cadddr)
; Nombre: system_path
; Dominio: system
; Recorrido: path
; Descripcion: Funcion selectora de system, recibe un sistema y retorna su path.

(define system_active_user (lambda (sys) (list-ref sys 4)))
; Nombre: system_active_user
; Dominio: system
; Recorrido: string
; Descripcion: Funcion selectora de system, recibe un sistema y retorna su usuario activo (logeado).

(define system_creation_date (lambda (sys) (list-ref sys 5)))
; Nombre: system_creation_date
; Dominio: system
; Recorrido: string
; Descripcion: Funcion selectora de system, recibe un sistema y retorna su fecha de creacion.

(define system_last_mod_date (lambda (sys) (list-ref sys 6)))
; Nombre: system_last_mod_date
; Dominio: system
; Recorrido: string
; Descripcion: Funcion selectora de system, recibe un sistema y retorna su fecha de ultima modificacion.


;---- Pertenencia ----;

(define system_user_logged? (lambda (sys)
                              (if (equal? (system_active_user sys) "") false true)
                              ))
; Nombre: system_user_logged?
; Dominio: system
; Recorrido: bool
; Descripcion: Funcion de pertenencia de sistem que retorna #t si el sistema
;              entregado tiene un usuario logeado o #f caso contrario.

;---- Modificadores ----;

(define system_change_path (lambda (sys path_list)
                             (system_recreate
                                     (system_name sys)
                                     (system_drives sys)
                                     (system_users sys)
                                      path_list
                                     (system_active_user sys)
                                     (system_creation_date sys)
                                     current_date
                                     )))
; Nombre: system_change_path
; Dominio: sys(system) X path_list(path)
; Recorrido: system
; Descripcion: Funcion modificadora de system que recibe un sistema, un path
;              y retorna el sistema con su path cambiado por el entregado.

(define run (lambda (sys comando) (comando sys)))
; Nombre: run
; Dominio: sys(system) X comando(procedure)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un comando y
;              retorna el resultado de evaluar el systema en el comando.

(define add-drive (lambda (sys) (lambda (letter name capacity)
                                    (system_recreate
                                     (system_name sys)
                                     (drives_add_drive (system_drives sys) (char-upcase letter) (string-downcase name) capacity)
                                     (system_users sys)
                                     (system_path sys)
                                     (system_active_user sys)
                                     (system_creation_date sys)
                                     current_date)
                                    )))
; Nombre: add-drive
; Dominio: sys(system) X letra (char) X nombre (String) X capacidad (int)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, una letra, un nombre
;              y una capacidad para crear un drive con estas especificaciones y lo agrega
;              al sistema (el cual retorna).

(define register (lambda (sys) (lambda (name)
                                   (system_recreate
                                     (system_name sys)
                                     (system_drives sys)
                                     (users_add_user (system_users sys) (string-downcase name))
                                     (system_path sys)
                                     (system_active_user sys)
                                     (system_creation_date sys)
                                     current_date)
                                   )))
; Nombre: register
; Dominio: sys(system) X name(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema y un nombre de usuario
;              para crear un usuario con estas especificaciones y lo agrega al sistema (el cual retorna).

(define login (lambda (sys) (lambda (u_name)
                              (if (and (not (system_user_logged? sys)) (users_exists_user? (system_users sys) (string-downcase u_name)))
                                  (system_recreate
                                     (system_name sys)
                                     (system_drives sys)
                                     (system_users sys)
                                     (system_path sys)
                                     (string-downcase u_name)
                                     (system_creation_date sys)
                                     current_date)
                                  sys
                              ))))
; Nombre: login
; Dominio: sys(system) X u_name(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un nombre de usuario y
;              retorna el systema con el usuario logeado como usuario activo (solo si este esta registrado).

(define logout (lambda (sys) (system_recreate
                                     (system_name sys)
                                     (system_drives sys)
                                     (system_users sys)
                                     (system_path sys)
                                     ""
                                     (system_creation_date sys)
                                     current_date
                              )))
; Nombre: logout
; Dominio: sys(system)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema y retorna el sistema sin usuario activo.

(define switch-drive (lambda (sys) (lambda (letter)
                                     (if (and (system_user_logged? sys) (drives_exists_drive? (system_drives sys) (char-upcase letter)))
                                         (system_change_path sys (cons letter path_empty))
                                         sys
                                     ))))
; Nombre: switch-drive
; Dominio: sys(system) X letter(char)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, una letra que representa un drive y retorna el sistema con
;              la letra agregada al path de este (solo si existe un user logeado y el drive existe en el sistema).

(define md (lambda (sys) (lambda (name)
                           (system_recreate
                                          (system_name sys)
                                          (drives_drive_add_folder_or_file (system_drives sys) (car (system_path sys)) (folder (string-downcase name) (system_active_user sys)) (system_path sys))
                                          (system_users sys)
                                          (system_path sys)
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                           )))
; Nombre: md
; Dominio: sys(system) X name(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un nombre, y retorna el sistema con
;              un folder creado en el path actual de este.

(define cd (lambda (sys) (lambda (new_location)
                           (if (equal? new_location "/")
                               (system_change_path sys (path_first_location_listed (system_path sys)))
                               (if (equal? new_location "..")
                                   (system_change_path sys (path_previous_location (system_path sys)))
                                   (if (char? (car (path_string_to_path new_location)))
                                       (if (not (folder_empty? (drives_get_folder_in_path (system_drives sys) (path_string_to_path new_location))))
                                           (system_change_path sys (path_string_to_path new_location))
                                           (system_change_path sys (system_path sys)))
                                       (if (not (folder_empty? (drives_get_folder_in_path (system_drives sys) (path_add_location (system_path sys) (path_string_to_path new_location)))))
                                           (system_change_path sys (path_add_location (system_path sys) (path_string_to_path new_location)))
                                           (system_change_path sys (system_path sys)))
                            ))))))
; Nombre: cd
; Dominio: sys(system) X new_location(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, una nueva locacion (string formateado) y retorna
;              el sistema con el path modificado acorde a la nueva locacion entregada. El path volvera a su raiz si
;              la nueva locacion es "/", volvera a la locacion anterior si la nueva locacion es ".." o cambiara a la
;              locacion indicada por el string si este esta formateado como un path (locaciones separadas por /).

(define add-file (lambda (sys) (lambda (new_file)
                                    (system_recreate
                                          (system_name sys)
                                          (drives_drive_add_folder_or_file (system_drives sys) (car (system_path sys)) new_file (system_path sys))
                                          (system_users sys)
                                          (system_path sys)
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                                    )))
; Nombre: add-file
; Dominio: sys(system)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un file y retorna el sistema con
;              este file agregado al folder indicado por el path actual del sistema.

(define del (lambda (sys) (lambda (name)
                           (system_recreate
                                          (system_name sys)
                                          (drives_drive_del (system_drives sys) (string-downcase name) (system_path sys))
                                          (system_users sys)
                                          (path_del_location (system_path sys) (string-downcase name))
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                           )))
; Nombre: del
; Dominio: sys(system)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un nombre y retorna el sistema
;              con el folder o file representado por el nombre entregado borrado de la locacion al final del path del sistema.

(define rd (lambda (sys) (lambda (name_or_path)
                           (system_recreate
                                          (system_name sys)
                                          (if (char? (path_string_to_path name_or_path))
                                              (drives_drive_rd (system_drives sys) (path_string_to_path name_or_path))
                                              (drives_drive_rd (system_drives sys) (path_add_location (system_path sys) (path_string_to_path name_or_path))))
                                          (system_users sys)
                                          (path_remove_directory (system_path sys) (drives_get_folder_in_path (system_drives sys) (path_string_to_path name_or_path)))
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                           )))
; Nombre: rd
; Dominio: sys(system) X name_or_path(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un nombre o path(syting formateado) y retorna el sistema
;              con el folder representado por el nombre o al final del path entregado borrado del sistema.


(define copy (lambda (sys) (lambda (name path)
                             (system_recreate
                                          (system_name sys)
                                          (drives_drive_copy (system_drives sys) (car (path_string_to_path path)) (string-downcase name) (path_string_to_path path) (system_path sys))
                                          (system_users sys)
                                          (system_path sys)
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                             )))
; Nombre: copy
; Dominio: sys(system) X name(string) X path(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un path (string formateado) y retorna
;              el sistema con el folder o archivo representado por el nombre entregado copiado y esta
;              copia agregada al path indicado.

(define move (lambda (sys) (lambda (name path)
                             (system_recreate
                                          (system_name sys)
                                          (if (folder_empty? (drives_get_folder_or_file_in_path (system_drives sys) (string-downcase name) (path_string_to_path path)))
                                           (drives_drive_move (system_drives sys) (car (path_string_to_path path)) (string-downcase name) (path_string_to_path path) (system_path sys))
                                           (system_drives sys))
                                          (system_users sys)
                                          (system_path sys)
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                             )))
; Nombre: move
; Dominio: sys(system) X name(string) X path(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un nombre, un path(string formateado) y
;              retorna el sistema con el folder o file representado por el nombre indicado reposicionado al path entregado.

(define ren (lambda (sys) (lambda (name new_name)
                               (system_recreate
                                          (system_name sys)
                                          (if (null? (drives_get_folder_or_file_in_path (system_drives sys) (string-downcase new_name) (system_path sys)))
                                              (drives_drive_rename (system_drives sys) (string-downcase name) (string-downcase new_name) (system_path sys))
                                              (system_drives sys))
                                          (system_users sys)
                                          (system_path sys)
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                               )))
; Nombre: ren
; Dominio: sys(system) X name(string) X new_name(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, un nombre, un nuevo nombre y retorna
;              el sistema con el folder o archivo representado por el nombre entregado renombrado con el nuevo nombre entregado.

(define dir (lambda (sys) (lambda ([param1 ""] [param2 ""])
                            (if (equal? param1 "/s")
                                (if (equal? param2 "/a")
                                    (dir_subdir_and_occult (if (folder_inside? (drives_get_folder_in_path (system_drives sys) (system_path sys)))
                                                               (drives_get_folder_in_path (system_drives sys) (system_path sys))
                                                               (folder_inside (drives_get_folder_in_path (system_drives sys) (system_path sys)))) "")
                                    (dir_subdir (if (folder_inside? (drives_get_folder_in_path (system_drives sys) (system_path sys)))
                                                               (drives_get_folder_in_path (system_drives sys) (system_path sys))
                                                               (folder_inside (drives_get_folder_in_path (system_drives sys) (system_path sys)))) ""))
                                (if (equal? param1 "/a")
                                    (if (equal? param2 "/s")
                                        (dir_subdir_and_occult (if (folder_inside? (drives_get_folder_in_path (system_drives sys) (system_path sys)))
                                                               (drives_get_folder_in_path (system_drives sys) (system_path sys))
                                                               (folder_inside (drives_get_folder_in_path (system_drives sys) (system_path sys)))) "")
                                        (dir_base_and_occult (if (folder_inside? (drives_get_folder_in_path (system_drives sys) (system_path sys)))
                                                               (drives_get_folder_in_path (system_drives sys) (system_path sys))
                                                               (folder_inside (drives_get_folder_in_path (system_drives sys) (system_path sys))))))
                                    (dir_base (if (folder_inside? (drives_get_folder_in_path (system_drives sys) (system_path sys)))
                                                               (drives_get_folder_in_path (system_drives sys) (system_path sys))
                                                               (folder_inside (drives_get_folder_in_path (system_drives sys) (system_path sys))))))
                                ))))
; Nombre: dir
; Dominio: sys(system) X param1(string)[OPCIONAL] X param2(string)[OPCIONAL]
; Recorrido: string
; Descripcion: Funcion modificadora de system, recibe un sistema un parametro 1. un parametro 2 y retorna
;              un string formateado que indica el contenido del folder al final del path actual. Si uno de los parametros
;              es "/s" se mostraran los subfolder dentro de este. Si uno de los paramteros es "/a" se mostraran los folders
;              o files ocultos. Se pueden entregar ambos para combinar los efectos.

(define format (lambda (sys) (lambda (letter new_name)
                               (system_recreate
                                          (system_name sys)
                                          (drives_drive_format (system_drives sys) (char-upcase letter) new_name)
                                          (system_users sys)
                                          (system_path sys)
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                               )))
; Nombre: format
; Dominio: sys(system) X letter(char) X new_name
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, una letra, un nuevo nombre y retorna el sistema
;              con el drive representado por la letra entregada formateado (su contenido eliminado y su nombre cambiado por el nuevo entregado).

(define encrypt (lambda (sys) (lambda (encryptFn decryptFn pass name_or_path)
                                (system_recreate
                                          (system_name sys)
                                          (if (char? (path_string_to_path name_or_path))
                                              (drives_drive_encrypt (system_drives sys) encryptFn decryptFn pass (path_string_to_path name_or_path))
                                              (drives_drive_encrypt (system_drives sys) encryptFn decryptFn pass (path_add_location (system_path sys) (path_string_to_path name_or_path))))
                                          (system_users sys)
                                          (path_remove_directory (system_path sys) (drives_get_folder_in_path (system_drives sys) (path_string_to_path name_or_path)))
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                                )))
; Nombre: encrypt
; Dominio: sys(system) X encryptFn(procedure) X decryptFn(procedure) X pass(string) X name_or_path(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, una funcion de encriptacion, una funcion
;              de desencriptacion, una contraseña, un nombre o path(string formateado) y retorna el sistema
;              con el folder o file representado por el nombre o el folder al final del path entregado encriptado
;              por la funcion de encriptacion entregada, ademas guardando la funcion de desencipracion y la contraseña
;              dentro del metadata del folder o file.

(define decrypt (lambda (sys) (lambda (pass name_or_path)
                                (system_recreate
                                          (system_name sys)
                                          (if (char? (path_string_to_path name_or_path))
                                              (drives_drive_decrypt (system_drives sys) pass (path_string_to_path name_or_path))
                                              (drives_drive_decrypt (system_drives sys) pass (path_add_location (system_path sys) (path_string_to_path name_or_path))))
                                          (system_users sys)
                                          (path_remove_directory (system_path sys) (drives_get_folder_in_path (system_drives sys) (path_string_to_path name_or_path)))
                                          (system_active_user sys)
                                          (system_creation_date sys)
                                          current_date)
                                )))
; Nombre: decrypt
; Dominio: sys(system) X pass(string) X name_or_path(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un sistema, una contraseña, un nombre o path y retorna el sistema
;              con el folder o file representado por el nombre o el folder al final del path entregado desencriptado solo
;              si la contaseña entregada coincide con la contraseña entrega al encriptar la funcion.

(define plus-one (lambda (strng)
               (bytes->string/utf-8 (list->bytes (map (lambda (i) (+ i 1)) (bytes->list (string->bytes/utf-8 strng)))))))
; Nombre: plus-one
; Dominio: strng(string)
; Recorrido: string
; Descripcion: Funcion que recibe un string y retorna el string con cada uno de sus char cambiados por el char
;              que viene despues numericamente en el codigo ASCII (se le suma 1 a su codigo ASCII).

(define minus-one (lambda (strng)
               (bytes->string/utf-8 (list->bytes (map (lambda (i) (- i 1)) (bytes->list (string->bytes/utf-8 strng)))))))
; Nombre: minus-one
; Dominio: strng(string)
; Recorrido: string
; Descripcion: Funcion que recibe un string y retorna el string con cada uno de sus char cambiados por el char
;              que anterior numericamente en el codigo ASCII (se le resta 1 a su codigo ASCII).

;---- Otras Funciones ----;

; FALTA SCRIPT DE PRUEBAS (AGREGAR LAS NUEVAS) ;