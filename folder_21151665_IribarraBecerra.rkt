#lang racket
(provide folder folder_name folder_inside folder_creation_date folder_last_mod_date folder_empty folder_empty? folder_add_folder_or_file folder_del
         folder_remove_dir folder_get_folder_or_file_in_path folder_get_folder_in_path dir_base dir_base_and_occult dir_subdir dir_subdir_and_occult
         folder_rename folder_encrypt folder_decrypt folder_inside?)
(require "generic-functions_21151665_IribarraBecerra.rkt" "file_21151665_IribarraBecerra.rkt" "date_21151665_IribarraBecerra.rkt")

; TDA folder
; Representacion: Representado por una lista que contiene un nombre(string), un interior(list) que contiene los folder y 
;                 files que contiene en su interior, el nombre del usuario creador(string), la fecha de creacion(string),
;                 la fecha de ultima modificacion(string), atributo de seguridad "oculto"(char, #\h si se encuentra oculto, #\nul si no),
;                 atributo de seguridad "solo lectura"(char, #\r si se encuentra en modo solo lectura, #\nul si no), una lista vacia donde se guardaran
;                 datos de encriptacion(list, la funcion de desencriptacion en la primera posicion, la contraseña en la segunda).


;---- Constructores ----;

(define folder (lambda (name user_name [occult #\nul] [read_only #\nul]) (list name null user_name current_date current_date occult read_only null)))
; Nombre: folder
; Dominio: name(string) X user_name(string) X occult(char)[OPCIONAL] X read_only(char)[OPCIONAL]
; Recorrido: folder(list)
; Descripcion: Funcion constructora de folder, recibe un nombre, el nombre del usuario creador, atributos de seguridad y
;              entrega un folder con el nombre indicado, una lista vacia donde se guardaran los files o folders que se encuentran
;              dentro de este, el nombre del usuario creador, ademas de la fecha de creacion y fecha de ultima
;              modificacion guardados en este. Cabe destacar que se pueden agregar los argumentos occult
;              y read_only, los cuales de ser indicados se guardaran. Si estos ultimos no son indicados
;              se guardaran char vacios en su lugar. Ademas, se guarda una lista vacia en la ultima posicion
;              en la cual se guardaran datos correspondientes a la encripcion del folder.

(define recreate_folder (lambda (name insides user_name creation_date last_mod_date [occult #\nul] [read_only #\nul] [encryption_data null])
                          (list name insides user_name creation_date last_mod_date occult read_only encryption_data)
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

(define folder_owner caddr)
; Nombre: folder_owner
; Dominio: folder
; Recorrido: string
; Descripcion: Funcion que recibe un folder y retorna su usuario creador.

(define folder_creation_date cadddr)
; Nombre: folder_creation_date
; Dominio: folder
; Recorrido: date
; Descripcion: Funcion que recibe un folder y retorna su fecha de creacion.

(define folder_last_mod_date (lambda (fldr) (list-ref fldr 4)))
; Nombre: folder_last_mod_date
; Dominio: folder
; Recorrido: date
; Descripcion: Funcion que recibe un folder y retorna su fecha de ultima modificacion.

(define folder_occult (lambda (fldr) (list-ref fldr 5)))
; Nombre: folder_occult
; Dominio: folder
; Recorrido: char
; Descripcion: Funcion que recibe un folder y retorna su atributo de "oculto".

(define folder_read_only (lambda (fldr) (list-ref fldr 6)))
; Nombre: folder_read_only
; Dominio: folder
; Recorrido: char
; Descripcion: Funcion que recibe un folder y retorna su atributo de "solo lectura".

(define folder_encryption_data (lambda (fldr) (list-ref fldr 7)))
; Nombre: folder_encryption_data
; Dominio: folder
; Recorrido: list
; Descripcion: Funcion que recibe un folder y retorna sus datos de encripcion.

(define folder_encryption_data_func (lambda (fldr) (if (null? (list-ref fldr 7)) null
                                                       (car (list-ref fldr 7)))))
; Nombre: folder_encryption_data_func
; Dominio: folder
; Recorrido: procedure
; Descripcion: Funcion que recibe un folder y retorna su funcion de desenciptacion.

(define folder_encryption_data_pass (lambda (fldr) (if (null? (list-ref fldr 7)) null
                                                       (cadr (list-ref fldr 7)))))
; Nombre: folder_encryption_data_pass
; Dominio: folder
; Recorrido: int
; Descripcion: Funcion que recibe un folder y retorna su contraseña de desenciptacion.


(define folder_get_folder_or_file_in_path (lambda (fldr path)
                                    (if (folder_empty? fldr) folder_empty
                                        (if (null? path) fldr
                                            (if (equal? (folder_name (car fldr)) (car path))
                                                (if (null? (cdr path))
                                                    (car fldr)
                                                    (if (folder? (car fldr))
                                                        (folder_get_folder_or_file_in_path (folder_inside (car fldr)) (cdr path))
                                                        (folder_get_folder_or_file_in_path (cdr fldr) path)))
                                                (folder_get_folder_or_file_in_path (cdr fldr) path))
                                            ))))
; Nombre: folder_get_folder_or_file_in_path
; Dominio: fldr(folder) X path
; Recorrido: folder or file
; Descripcion: Funcion que recibe el interior de un folder, un path y retorna el folder o file representado por
;              el nombre indicado al final del path, dentro del folder indicado.
; Recursion: De cola


(define folder_get_folder_in_path (lambda (fldr path)
                                    (if (folder_empty? fldr) folder_empty
                                        (if (null? path) fldr
                                            (if (folder? (car fldr))
                                                (if (equal? (folder_name (car fldr)) (car path))
                                                    (if (null? (cdr path))
                                                        (car fldr)
                                                        (folder_get_folder_in_path (folder_inside (car fldr)) (cdr path)))
                                                    (folder_get_folder_in_path (cdr fldr) path))
                                                (folder_get_folder_in_path (cdr fldr) path))
                                            ))))
; Nombre: folder_get_folder_in_path
; Dominio: fldr(folder) X path
; Recorrido: folder
; Descripcion: Funcion que recibe el interior de un folder, un path y retorna el folder al final del path recibido
;              dentro del folder indicado.
; Recursion: De cola

;---- Pertenencia ----;

(define folder_empty? null?)
; Nombre: folder_empty?
; Dominio: folder
; Recorrido: bool
; Descripcion: Funcion que recibe un folder y retorna #t si se encuentra vacio o #f caso contrario.

(define folder? (lambda (fldr_or_fle) (list? (cadr fldr_or_fle))))
; Nombre: folder?
; Dominio: fldr_or_fle(folder or file) 
; Recorrido: bool
; Descripcion: Funcion que recibe un folder o file y retorna #t si este es un folder o #f si es un file.

(define folder_inside? (lambda (fldr_or_inside) (if (folder_empty? fldr_or_inside) true
                                                    (if (list? (car fldr_or_inside)) true false)
                                                    )))
; Nombre: folder_inside?
; Dominio: fldr_or_inside(folder or list) 
; Recorrido: bool
; Descripcion: Funcion que recibe un folder o el interior de uno y retorna #t si este es el interior de un folder o #f si es un folder.

(define folder_occult? (lambda (fldr) (equal? #\h (folder_occult fldr))))
; Nombre: folder_occult?
; Dominio: fldr(folder) 
; Recorrido: bool
; Descripcion: Funcion que reciber un folder y retorna #t si este se encuentra oculto o #f caso contrario.

(define folder_read_only? (lambda (fldr) (equal? #\r (folder_read_only fldr))))
; Nombre: folder_read_only?
; Dominio: fldr(folder) 
; Recorrido: bool
; Descripcion: Funcion que reciber un folder y retorna #t si este se encuentra en modo solo lectura o #f caso contrario.

(define folder_encrypted? (lambda (fldr) (not (null? (folder_encryption_data fldr)))))
; Nombre: folder_encrypted?
; Dominio: fldr(folder) 
; Recorrido: bool
; Descripcion: Funcion que reciber un folder y retorna #t si este se encuentra encriptado o #f caso contrario.

;---- Modificadores ----;

(define folder_add_folder_or_file (lambda (fldr new_object path)
                                    (if (null? (cdr path))
                                        (add_not_duped_value fldr new_object folder_empty? folder_empty)
                                        (if (equal? (folder_name (car fldr)) (cadr path))
                                            (cons (recreate_folder
                                                   (folder_name (car fldr))
                                                   (if (not (folder_read_only? (car fldr)))
                                                       (folder_add_folder_or_file (folder_inside (car fldr)) new_object (cdr path))
                                                       (folder_inside (car fldr)))
                                                   (folder_owner (car fldr))
                                                   (folder_creation_date (car fldr))
                                                   current_date
                                                   (folder_occult (car fldr))
                                                   (folder_read_only (car fldr))
                                                   (folder_encryption_data (car fldr))) (cdr fldr))
                                            (cons (car fldr) (folder_add_folder_or_file (cdr fldr) new_object path))
                                            ))))
; Nombre: folder_add_folder_or_file
; Dominio: fldr(folder) X new_object(folder or file) X path(path)
; Recorrido: folder
; Descripcion: Funcion que recibe el interior de un folder, un file o un folder, un path y retorna el
;              interior del folder con un file o folder creado dentro de este, en el path indicado.
; Recursion: natural

(define folder_del (lambda (fldr name path)
                     (if (folder_empty? fldr) folder_empty
                         (if (null? (cdr path))
                             (if (equal? (folder_name (car fldr)) name)
                                 (folder_del (cdr fldr) name path)
                                 (cons (car fldr) (folder_del (cdr fldr) name path)))
                             (if (equal? (folder_name (car fldr)) (cadr path))
                                 (cons (recreate_folder
                                        (folder_name (car fldr))
                                        (if (not (folder_read_only? (car fldr)))
                                            (folder_del (folder_inside (car fldr)) name (cdr path))
                                            (folder_inside (car fldr)))
                                        (folder_owner (car fldr))
                                        (folder_creation_date (car fldr))
                                        current_date
                                        (folder_occult (car fldr))
                                        (folder_read_only (car fldr))
                                        (folder_encryption_data (car fldr))) (cdr fldr))
                                 (cons (car fldr) (folder_del (cdr fldr) name path))
                                 )))))
; Nombre: folder_del
; Dominio: fldr(folder) X name(string) X path
; Recorrido: folder
; Descripcion: Funcion que recibe un folder, un nombre, un path y retorna el folder con
;              el folder representada por el nombre indicado eliminado del path indicado.
; Recursion: natural

(define folder_remove_dir (lambda (fldr path)
                     (if (folder_empty? fldr) folder_empty
                         (if (equal? (folder_name (car fldr)) (car path))
                             (if (null? (cdr path))
                                 (if (and (folder_empty? (folder_inside (car fldr))) (folder? (car fldr)))
                                     (cdr fldr)
                                     fldr)
                                 (if (folder? (car fldr))
                                     (cons (recreate_folder
                                            (folder_name (car fldr))
                                            (if (not (folder_read_only? (car fldr)))
                                                (folder_remove_dir (folder_inside (car fldr)) (cdr path))
                                                (folder_inside (car fldr)))
                                            (folder_owner (car fldr))
                                            (folder_creation_date (car fldr))
                                            (folder_last_mod_date (car fldr))
                                            (folder_occult (car fldr))
                                            (folder_read_only (car fldr))
                                            (folder_encryption_data (car fldr))) (folder_remove_dir (cdr fldr) path))
                                     (cons (car fldr) (folder_remove_dir (cdr fldr) path))))
                             (cons (car fldr) (folder_remove_dir (cdr fldr) path)))
                             )))
; Nombre: folder_remove_dir
; Dominio: fldr(folder) X path
; Recorrido: folder
; Descripcion: Funcion que recibe el interior de un folder, un path y retorna el interior del folder indicado, con el folder al final
;              del path dentro de este eliminado si este se encuentra con su interior vacio.
; Recursion: arborea

(define folder_rename (lambda (fldr name new_name path)
                        (if (folder_empty? fldr) folder_empty
                         (if (null? (cdr path))
                             (if (equal? (folder_name (car fldr)) name)
                                 (if (folder? (car fldr))
                                        (cons (recreate_folder
                                               (if (not (folder_read_only? (car fldr)))
                                                   new_name
                                                   (folder_name (car fldr)))
                                               (folder_inside (car fldr))
                                               (folder_owner (car fldr))
                                               (folder_creation_date (car fldr))
                                               current_date
                                               (folder_occult (car fldr))
                                               (folder_read_only (car fldr))
                                               (folder_encryption_data (car fldr))) (cdr fldr))
                                        (cons (recreate_file
                                               (if (not (file_read_only? (car fldr)))
                                                   new_name
                                                   (file_name (car fldr)))
                                               (file_extension (car fldr))
                                               (file_content (car fldr))
                                               (file_creation_date (car fldr))
                                               current_date
                                               (file_occult (car fldr))
                                               (file_read_only (car fldr))
                                               (file_encryption_data (car fldr))) (cdr fldr)))
                                 (cons (car fldr) (folder_rename (cdr fldr) name new_name path)))
                             (if (equal? (folder_name (car fldr)) (cadr path))
                                 (cons (recreate_folder
                                        (folder_name (car fldr))
                                        (if (not (folder_read_only? (car fldr)))
                                            (folder_rename (folder_inside (car fldr)) name new_name (cdr path))
                                            (folder_inside (car fldr)))
                                        (folder_owner (car fldr))
                                        (folder_creation_date (car fldr))
                                        current_date
                                        (folder_occult (car fldr))
                                        (folder_read_only (car fldr))
                                        (folder_encryption_data (car fldr))) (cdr fldr))
                                 (cons (car fldr) (folder_rename (cdr fldr) name new_name path))
                                 )))))
; Nombre: folder_rename
; Dominio: fldr(folder) X name(string) X new_name(string) X path
; Recorrido: folder
; Descripcion: Funcion que recibe el interior de un folder, un nombre, un nuevo nombre, un path y retorna el interior del folder indicado
;              con el folder representado por el nombre, al final del path dentro de este, recreado con el nuevo nombre indicado.
; Recursion: natural

(define folder_encrypt (lambda (fldr encryptFn decryptFn pass path)
                         (if (folder_empty? fldr) folder_empty
                             (if (equal? (folder_name (car fldr)) (car path))
                                 (if (null? (cdr path))
                                     (if (folder_encrypted? (car fldr)) fldr
                                         (cons (car (folder_execute_encryption (list (car fldr)) encryptFn decryptFn pass)) (cdr fldr)))
                                     (if (folder? (car fldr))
                                         (cons (recreate_folder
                                                (folder_name (car fldr))
                                                (if (not (folder_read_only? (car fldr)))
                                                    (folder_encrypt (folder_inside (car fldr)) encryptFn decryptFn pass (cdr path))
                                                    (folder_inside (car fldr)))
                                                (folder_owner (car fldr))
                                                (folder_creation_date (car fldr))
                                                (folder_last_mod_date (car fldr))
                                                (folder_occult (car fldr))
                                                (folder_read_only (car fldr))
                                                (folder_encryption_data (car fldr))) (folder_encrypt (cdr fldr) encryptFn decryptFn pass path))
                                         (cons (car fldr) (folder_encrypt (cdr fldr) encryptFn decryptFn pass path))))
                                 (cons (car fldr) (folder_encrypt (cdr fldr) encryptFn decryptFn pass path)))
                             )))
; Nombre: folder_encrypt
; Dominio: fldr(folder) X encryptFn(procedure) X decryptFn(procedure) X pass(string) X path
; Recorrido: folder
; Descripcion: Funcion que recibe el interior de un folder, un funcion de encriptacion, una funcion
;              de desencriptacion, una contraseña, un path y retorna el interior del folder indicado con
;              el folder al final del path indicado dentro del folder anterior encriptado con
;              la funcion de encriptacion indicada, ademas guardando en el metadata de esta la funcion
;              de desencriptacion y la contraseña.
; Recursion: arborea

(define folder_decrypt (lambda (fldr pass path)
                         (if (folder_empty? fldr) folder_empty
                             (if (null? (cdr path))
                                 (if (folder? (car fldr))
                                     (if (folder_encrypted? (car fldr))
                                         (if (equal? ((folder_encryption_data_func (car fldr)) (folder_name (car fldr))) (car path))
                                             (cons (car (folder_execute_decryption (list (car fldr)) pass)) (cdr fldr))
                                             (cons (car fldr) (folder_decrypt (cdr fldr) pass path)))
                                         (cons (car fldr) (folder_decrypt (cdr fldr) pass path)))
                                     (if (file_encrypted? (car fldr))
                                         (if (equal? ((file_encryption_data_func (car fldr)) (folder_name (car fldr))) (car path))
                                             (cons (car (folder_execute_decryption (list (car fldr)) pass)) (cdr fldr))
                                             (cons (car fldr) (folder_decrypt (cdr fldr) pass path)))
                                         (cons (car fldr) (folder_decrypt (cdr fldr) pass path))))
                                 (if (equal? (folder_name (car fldr)) (car path))
                                     (if (folder? (car fldr))
                                         (cons (recreate_folder
                                                (folder_name (car fldr))
                                                (folder_decrypt (folder_inside (car fldr)) pass (cdr path))
                                                (folder_owner (car fldr))
                                                (folder_creation_date (car fldr))
                                                (folder_last_mod_date (car fldr))
                                                (folder_occult (car fldr))
                                                (folder_read_only (car fldr))
                                                (folder_encryption_data (car fldr))) (cdr fldr))
                                         fldr)
                                     (cons (car fldr) (folder_decrypt (cdr fldr) pass path)))
                             ))))
; Nombre: folder_decrypt
; Dominio: fldr(folder) X pass(string) X path
; Recorrido: folder
; Descripcion: Funcion que recibe el interior de un folder, una contraseña, un path y retorna interior del folder indicado con
;              el folder al final del path indicado dentro de este desencriptado, solo si la contraseña
;              indicada es igual a la contraseña de desencriptacion de la carpeta.
; Recursion: arborea

(define folder_execute_encryption (lambda (fldr encryptFn decryptFn pass)
                                    (if (folder_empty? fldr) fldr
                                        (if (folder? (car fldr))
                                            (cons (recreate_folder
                                                   (encryptFn (folder_name (car fldr)))
                                                   (folder_execute_encryption (folder_inside (car fldr)) encryptFn decryptFn pass)
                                                   (folder_owner (car fldr))
                                                   (folder_creation_date (car fldr))
                                                   current_date
                                                   (folder_occult (car fldr))
                                                   (folder_read_only (car fldr))
                                                   (list decryptFn pass)) (folder_execute_encryption (cdr fldr) encryptFn decryptFn pass))
                                            (cons (recreate_file
                                                   (encryptFn (file_name (car fldr)))
                                                   (file_extension (car fldr))
                                                   (encryptFn (file_content (car fldr)))
                                                   (file_creation_date (car fldr))
                                                   current_date
                                                   (file_occult (car fldr))
                                                   (file_read_only (car fldr))
                                                   (list decryptFn pass)) (folder_execute_encryption (cdr fldr) encryptFn decryptFn pass))
                                            ))))
; Nombre: folder_execute_encryption
; Dominio: fldr(folder) X encryptFn(procedure) X decryptFn(procedure) X pass(string)
; Recorrido: folder
; Descripcion: Funcion que recibe el interior de un folder, una funcion de encriptacion, una funcion de desencriptacion,
;              una contraseña y retorna el interior del folder con su contenido encriptado a traves de la funcion
;              de encriptacion, ademas con la funcion de desencriptacion y contraseña guardados en la metadata de cada objeto encriptado.
; Recursion: arborea

(define folder_execute_decryption (lambda (fldr pass)
                                    (if (folder_empty? fldr) fldr
                                        (if (folder? (car fldr))
                                            (if (equal? (folder_encryption_data_pass (car fldr)) pass)
                                                (cons (recreate_folder
                                                       ((folder_encryption_data_func (car fldr)) (folder_name (car fldr)))
                                                       (folder_execute_decryption (folder_inside (car fldr)) pass)
                                                       (folder_owner (car fldr))
                                                       (folder_creation_date (car fldr))
                                                       current_date
                                                       (folder_occult (car fldr))
                                                       (folder_read_only (car fldr))
                                                       null) (folder_execute_decryption (cdr fldr) pass))
                                                fldr)
                                            (if (equal? (file_encryption_data_pass (car fldr)) pass)
                                                (cons (recreate_file
                                                       ((file_encryption_data_func (car fldr)) (file_name (car fldr)))
                                                       (file_extension (car fldr))
                                                       ((file_encryption_data_func (car fldr)) (file_content (car fldr)))
                                                       (file_creation_date (car fldr))
                                                       current_date
                                                       (file_occult (car fldr))
                                                       (file_read_only (car fldr))
                                                       null) (folder_execute_decryption (cdr fldr) pass))
                                                fldr)
                                            ))))
; Nombre: folder_execute_decryption
; Dominio: fldr(folder) X pass(string)
; Recorrido: folder
; Descripcion: Funcion que recibe el interior de un folder, una contraseña y retorna el interior del folder
;              con su contenido desencriptado a traves de la funcion
;              de desencriptacion en la metadata de cada obejto solo si la contraseña
;              indicada es igual a la contraseña guardada en la metadata de esta.
; Recursion: arborea


;---- Otras Funciones ----;

(define dir_base (lambda (fldr)
                   (if (or (folder_empty? fldr) (folder_empty? (car fldr))) ""
                       (string-append (if (folder? (car fldr))
                                          (if (folder_occult? (car fldr)) "\n"
                                              (folder_to_string (car fldr)))
                                          (if (file_occult? (car fldr)) "\n"
                                              (file_to_string (car fldr))))
                                      (dir_base (cdr fldr))))))
; Nombre: dir_base
; Dominio: fldr(folder) 
; Recorrido: string
; Descripcion: Funcion que recibe el interior de un folder y retorna un string formateado 
;              que indica el contenido de este.
; Recursion: natural

(define dir_base_and_occult (lambda (fldr)
                              (if (or (folder_empty? fldr) (folder_empty? (car fldr))) ""
                                  (string-append (if (folder? (car fldr))
                                                     (folder_to_string (car fldr))
                                                     (file_to_string (car fldr)))
                                                 (dir_base_and_occult (cdr fldr)))
                                  )))
; Nombre: dir_base_and_occult
; Dominio: fldr(folder) 
; Recorrido: string
; Descripcion: Funcion que recibe el interior de un folder y retorna un string
;              formateado que indica el contenido de este, mostrando tambien contenido oculto.
; Recursion: natural

(define dir_subdir (lambda (fldr indentation)
                     (if (or (folder_empty? fldr) (folder_empty? (car fldr))) ""
                         (string-append indentation (if (folder? (car fldr))
                                                        (if (folder_occult? (car fldr)) "\n"
                                                            (string-append (folder_to_string (car fldr)) (dir_subdir (folder_inside (car fldr)) (string-append indentation "     "))))
                                                        (if (file_occult? (car fldr)) "\n"
                                                            (file_to_string (car fldr))))
                                        (dir_subdir (cdr fldr) indentation)))))
; Nombre: dir_subdir
; Dominio: fldr(folder) X indentation(string) 
; Recorrido: string
; Descripcion: Funcion que recibe el interior de un folder, una indentacion y retorna un string
;              formateado que indica el contenido de este ademas del contenido de folders que se
;              encuentren dentro de este, agregando la indentacion cada ves que se baja un nivel.
; Recursion: arborea

(define dir_subdir_and_occult (lambda (fldr indentation)
                                (if (or (folder_empty? fldr) (folder_empty? (car fldr))) ""
                                    (string-append indentation (if (folder? (car fldr))
                                                                   (string-append (folder_to_string (car fldr)) (dir_subdir_and_occult (folder_inside (car fldr)) (string-append indentation "     ")))
                                                                   (file_to_string (car fldr)))
                                                   (dir_subdir_and_occult (cdr fldr) indentation)))))
; Nombre: dir_subdir_and_occult
; Dominio: fldr(folder) X indentation(string) 
; Recorrido: string
; Descripcion: Funcion que recibe el interior de un folder, una indentacion y retorna un string
;              formateado que indica el contenido de este ademas del contenido de folders que se
;              encuentren dentro de este, agregando la indentacion cada ves que se baja un nivel
;              y ademas mostrando contenido oculto.
; Recursion: arborea

(define folder_to_string (lambda (fldr)
                           (string-append "[" (folder_creation_date fldr) "]" " [Folder] - " (folder_name fldr) "\n")))

; Nombre: folder_to_string
; Dominio: fldr(folder) 
; Recorrido: string
; Descripcion: Funcion que recibe un folder y retorna un string que representa a este,
;              indicando su fecha de creacion y nombre.
