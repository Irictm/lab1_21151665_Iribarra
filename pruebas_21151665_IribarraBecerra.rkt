#lang racket
(require "system_21151665_IribarraBecerra.rkt" "file_21151665_IribarraBecerra.rkt")

;creando un sistema
(define S0 (system "newSystem"))

;añadiendo unidades. Incluye caso S2 que intenta añadir unidad con una letra que ya existe
(define S1 ((run S0 add-drive) #\C "SO" 1000))
(define S2 ((run S1 add-drive) #\C "SO1" 3000))
(define S3 ((run S2 add-drive) #\D "Util" 2000))

;añadiendo usuarios. Incluye caso S6 que intenta registrar usuario duplicado
(define S4 ((run S3 register) "user1"))
(define S5 ((run S4 register) "user1"))
(define S6 ((run S5 register) "user2"))

;iniciando sesión con usuarios. Incluye caso S8 que intenta iniciar sesión con user2 sin antes haber salido con user1
(define S7 ((run S6 login) "user1"))
(define S8 ((run S7 login) "user2"))

;cerrando sesión user1 e iniciando con user2
(define S9 (run S8 logout))
(define S10 ((run S9 login) "user2"))

;cambios de unidad, incluyendo unidad inexistente K
(define S11 ((run S10 switch-drive) #\K))
(define S12 ((run S11 switch-drive) #\C))

;añadiendo carpetas. Incluye casos de carpetas duplicadas.
(define S13 ((run S12 md) "folder1"))
(define S14 ((run S13 md) "folder2"))
(define S15 ((run S14 md) "folder2"))
(define S16 ((run S15 md) "folder3"))

;ingresa a carpeta folder2
(define S17 ((run S16 cd) "folder2"))

;crea subcarpeta folder21 dentro de folder2 (incluye caso S19 de carpeta con nombre duplicado)
(define S18 ((run S17 md) "folder21"))
(define S19 ((run S18 md) "folder21"))

;ingresa a subcarpeta e intenta ingresar a subcarpeta inexistente S221
(define S20 ((run S19 cd) "folder21"))
(define S21 ((run S20 cd) "folder22"))

;vuelve a carpeta anterior
(define S22 ((run S21 cd) ".."))

;vuelve a ingresar folder21
(define S23 ((run S22 cd) "folder21"))

;crea subcarpeta folder211 e ingresa
(define S24 ((run S23 md) "folder211"))
(define S25 ((run S24 cd) "folder211"))

;vuelve a la raíz de la unidad c:/
(define S26 ((run S24 cd) "/"))

;se cambia de unidad
(define S27 ((run S26 switch-drive) #\D))

;crea carpeta e ingresa a carpeta
(define S28 ((run S27 md) "folder5"))
(define S29 ((run S28 cd) "folder5"))

;se cambia de carpeta en base a la ruta especificada
(define S30 ((run S29 cd) "C:/folder1/"))

;formateando drive D:
(define S31 ((run S30 format) #\D "newD"))

;añadiendo archivos
(define S32 ((run S31 add-file) (file "foo1.txt" "txt" "hello world 1")))
(define S33 ((run S32 add-file) (file "foo2.txt" "txt" "hello world 2")))
(define S34 ((run S33 add-file) (file "foo3.docx" "docx" "hello world 3")))
(define S35 ((run S34 add-file) (file "goo4.docx" "docx" "hello world 4" #\h #\r))) ;con atributos de seguridad oculto (h) y de solo lectura (r)

;eliminando archivos
(define S36 ((run S35 del) "*.txt"))
(define S37 ((run S35 del) "f*.docx"))
(define S38 ((run S35 del) "goo4.docx"))
(define S39 ((run S35 cd) ".."))
(define S40 ((run S39 del) "folder1"))

;borrando una carpeta
(define S41 ((run S39 rd) "folder1"))  ;no debería borrarla, pues tiene archivos
(define S42 ((run S41 cd) "folder1"))
(define S43 ((run S42 del) "*.*"))
(define S44 ((run S43 cd) ".."))
(define S45 ((run S44 rd) "folder1"))

;copiando carpetas y archivos
(define S46 ((run S35 copy) "foo1.txt" "c:/folder3/"))
(define S47 ((run S46 cd) ".."))
(define S48 ((run S47 copy) "folder1" "d:/"))

;moviendo carpetas y archivos
(define S49 ((run S48 move) "folder3" "d:/"))
(define S50 ((run S49 cd) "folder1"))
(define S51 ((run S50 move) "foo3.docx" "d:/folder3/"))

;renombrando carpetas y archivos
(define S52 ((run S51 ren) "foo1.txt" "newFoo1.txt"))
(define S53 ((run S52 ren) "foo2.txt" "newFoo1.txt")) ;no debería efectuar cambios pues ya existe archivo con este nombre
(define S54 ((run S53 cd) ".."))
(define S55 ((run S54 ren) "folder1" "newFolder1"))

;listando la información
(display ((run S16 dir)))
(display ((run S55 dir)))
(display ((run S55 dir) "/s")) ;muestra carpetas y subcarpetas de la unidad C
(display ((run S55 dir) "/s" "/a")) ;muestra todo el contenido de carpetas y subcarpetas de la unidad C incluyendo archivo oculto goo4.docx

;encriptando archivos y carpetas
(define S56 ((run S55 encrypt) plus-one minus-one "1234" "newFolder1"))
(define S57 ((run S56 switch-drive) #\D))
(define S58 ((run S57 cd) "folder3"))
(define S59 ((run S58 encrypt) plus-one minus-one "4321" "foo3.docx"))

;desencriptando archivos y carpetas
(define S60 ((run S59 decrypt) "1234" "foo3.docx")) ;no logra desencriptar por clave incorrecta
(define S61 ((run S60 decrypt) "4321" "foo3.docx"))
(define S62 ((run S61 switch-drive) #\C))
(define S63 ((run S62 decrypt) "1234" "newFolder1"))

;buscando contenido
(define S64 ((run S63 cd) "newFolder1"))
;(display ((run S64 grep) "hello" "newFoo1.txt"))
;(display ((run S64 grep) "hello" "*.*"))

;viendo la papelera
;(display (run S45 viewTrash))

;restaurando
;(define S65 ((run S45 restore) "folder1"))

; NUEVOS EJEMPLOS
;probando system
(define E0 (system "NUEVOSYSTEMA"))
(define E1 (system "sys tema"))
(define E2 (system "system01"))

;probando add-drive
(define E3 ((run E2 add-drive) #\C "drive01" 10))
(define E4 ((run E3 add-drive) #\f "drive_NEW" 9999))
(define E5 ((run E4 add-drive) #\F "NUEVO_DRIVE" 9191))

;probando register
(define E6 ((run E5 register) "fernando iribarra"))
(define E7 ((run E6 register) "usuario_nuevo"))
(define E8 ((run E7 register) "new_user"))

;probando login
(define E9 ((run E8 login) "NUEVOUSUARIO"))
(define E10 ((run E9 login) "fernando iribarra"))
(define E11 ((run E10 login) "fernando iribarra"))

;probando logout
(define E12 (run E11 logout))
(define E13 (run E12 logout))
(define E14 ((run E13 login) "new_user"))
(define E15 (run E14 logout))
(define E16 ((run E15 login) "fernando iribarra"))

;probando switch-drive
(define E17 ((run E16 switch-drive) #\F))
(define E18 ((run E17 switch-drive) #\F))
(define E19 ((run E18 switch-drive) #\C))

;probando md
(define E20 ((run E19 md) "carpeta01"))
(define E21 ((run E20 switch-drive) #\F))
(define E22 ((run E21 md) "carpeta01"))
(define E23 ((run E22 md) "carpeta02"))

;probando cd
(define E24 ((run E23 cd) "k/folder01/folder"))
(define E25 ((run E24 cd) "c/carpeta01"))
(define E26 ((run E25 cd) "folder02/folder/fol/der"))

;probando add-file
(define E27 ((run E26 add-file) (file "notas.txt" "txt" "notas, notas y notas...")))
(define E28 ((run E27 add-file) (file "secreto.txt" "txt" ">:C"  #\h)))
(define E29 ((run E28 cd) "F:/carpeta02"))
(define E30 ((run E29 add-file) (file "hola.docx" "docx" "hola profe")))
(define E31 ((run E30 add-file) (file "hola.docx" "docx" "que tenga buen dia")))

;probando del
(define E32 ((run E31 del) "notas.txt"))
(define E33 ((run E32 cd) "C:/carpeta01"))
(define E34 ((run E33 del) "notas.txt"))
(define E35 ((run E34 del) "notas.txt"))

;probando rd
(define E36 ((run E35 rd) "secreto.txt"))
(define E37 ((run E36 md) "nueva_carpeta"))
(define E38 ((run E37 rd) "nueva_carpeta"))
(define E39 ((run E38 cd) "f:/"))
(define E40 ((run E39 rd) "carpeta02"))
(define E41 ((run E40 md) "foolder01"))

;probando copy
(define E42 ((run E41 copy) "foolder01" "C:/carpeta01"))
(define E43 ((run E42 copy) "carpeta02" "c"))
(define E44 ((run E43 copy) "carpeta01" "c"))

;probando move
(define E45 ((run E44 move) "carpeta01" "c"))
(define E46 ((run E45 move) "foolder01" "c/carpeta01/foolder01"))
(define E47 ((run E46 cd) "c"))
(define E48 ((run E47 move) "carpeta02" "f/carpeta01"))

;probando ren
(define E49 ((run E48 ren) "carpeta02" "nuevo"))
(define E50 ((run E49 cd) "carpeta01"))
(define E51 ((run E50 ren) "secreto.txt" "oculto.txt"))
(define E52 ((run E51 cd) "F"))
(define E53 ((run E52 ren) "carpeta01" "carpeta02"))

;probando dir
(define E54 (display ((run E53 dir))))
(define E55 (display ((run E53 dir) "/s")))
(define E56 ((run E53 cd) "C"))
(define E57 (display ((run E56 dir) "/s")))
(define E58 (display ((run E56 dir) "/s" "/a")))

;probando format
(define E59 ((run E56 format) #\m "nuevo"))
(define E60 ((run E59 add-drive) #\j "drive_nuevo" 20223))
(define E61 ((run E60 format) #\j "drive_formateado"))
(define E62 ((run E61 format) #\c "FORMATED"))

;probando encrypt y plus-one
(define E63 ((run E62 cd) "f"))
(define E64 ((run E63 encrypt) plus-one minus-one "8888" "carpeta01"))
(define E65 ((run E64 encrypt) minus-one plus-one "0001112" "carpeta02"))
(define E66 ((run E65 encrypt) plus-one minus-one "1" "carpeta02"))

;probando decrypt y minus-one
(define E67 ((run E66 decrypt) "8888" "carpeta01"))
(define E68 ((run E67 decrypt) "0" "carpeta02"))
(define E69 ((run E68 decrypt) "0001112" "carpeta02"))