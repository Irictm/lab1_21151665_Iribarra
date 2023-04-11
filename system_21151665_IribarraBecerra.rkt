#lang racket
(require "drive_21151665_IribarraBecerra.rkt" "drives_21151665_IribarraBecerra.rkt"
         "user_21151665_IribarraBecerra.rkt" "users_21151665_IribarraBecerra.rkt"
         "path_21151665_IribarraBecerra.rkt")

; TDA system
; Representacion:


;---- Constructores ----;

(define system (lambda (sys_name)
                 (list sys_name drives_empty users_empty path_empty "" "Fecha (placeholder)")))
; Nombre: system
; Dominio: sys_name(string)
; Recorrido: system (list)
; Descripcion: Funcion constructora del systema, recibe un string y entrega
;              una lista construida a traves de pares que contiene el nombre del systema,
;              una lista de drives vacia, una lista de usuarios vacia, el path actual
;              representado por una lista vacia, un string indicando que no existe
;              usuario actual y la fecha de creacion.
; FALTA DEJAR REGISTRO DE FECHA;

(define system_recreate (lambda (sys_name sys_drive sys_users sys_path sys_act_user sys_date)
                          (list sys_name sys_drive sys_users sys_path sys_act_user sys_date)
                          ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:


;---- Selectores ----;

(define system_name car)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_drives cadr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_users caddr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_path cadddr)
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_active_user (lambda (sys) (list-ref sys 4)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define system_creation_date (lambda (sys) (list-ref sys 5)))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:


;---- Pertenencia ----;

(define system_user_logged? (lambda (sys)
                              (if (equal? (system_active_user sys) "") false true)
                              ))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

;---- Modificadores ----;

(define run (lambda (systema comando) (comando systema)))
; Nombre: run
; Dominio: system X comando(funcion)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema y una funcion para
;              retornar el systema con la funcion aplicada a traves del uso de "compose")
; FALTA DEJAR REGISTRO DE FECHA;

(define add-drive (lambda (sys) (lambda (letter name capacity)
                                    (system_recreate
                                     (system_name sys)
                                     (drives_add_drive (system_drives sys) letter name capacity)
                                     (system_users sys)
                                     (system_path sys)
                                     (system_active_user sys)
                                     (system_creation_date sys))
                                    )))
; Nombre: add-drive
; Dominio: system X letra (char) X nombre (String) X capacidad (int)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema, una letra, un nombre
;              y una capacidad para crear un drive con estas especificaciones y lo agrega
;              al sistema (el cual retorna).

(define register (lambda (sys) (lambda (name)
                                   (system_recreate
                                     (system_name sys)
                                     (system_drives sys)
                                     (add_user (system_users sys) name)
                                     (system_path sys)
                                     (system_active_user sys)
                                     (system_creation_date sys))
                                   )))
; Nombre: register
; Dominio: nombre_usuario(string)
; Recorrido: system
; Descripcion: Funcion modificadora de system, recibe un systema y un nombre de usuario
;              para crear un usuario con estas especificaciones y lo agrega al sistema (el cual retorna).

(define login (lambda (sys) (lambda (u_name)
                              (if (users_exists_user? (system_users sys) u_name)
                                  (system_recreate
                                     (system_name sys)
                                     (system_drives sys)
                                     (system_users sys)
                                     (system_path sys)
                                     u_name
                                     (system_creation_date sys))
                                  sys
                              ))))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define logout (lambda (sys) (system_recreate
                                     (system_name sys)
                                     (system_drives sys)
                                     (system_users sys)
                                     (system_path sys)
                                     ""
                                     (system_creation_date sys)    
                              )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:

(define switch-drive (lambda (sys) (lambda (letter)
                                     (if (and (system_user_logged? sys) (drives_exists_drive? (system_drives sys) letter))
                                          (system_recreate
                                          (system_name sys)
                                          (system_drives sys)
                                          (system_users sys)
                                          (path_add_location letter (system_path sys))
                                          (system_active_user sys)
                                          (system_creation_date sys))
                                         sys
                                     ))))

;---- Otras Funciones ----;

(define S0 ((run ((run ((run ((run ((run (system "System01") add-drive) "c" "Drive01" 123456789) add-drive) "d" "DriveFunky" 987654321) add-drive) "e" "Drove" 999999) register) "Fernando Iribarra") register) "Andrew Asprey"))