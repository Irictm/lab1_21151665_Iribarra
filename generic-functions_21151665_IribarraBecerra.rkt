#lang racket
(provide add_not_duped_value)

(define add_not_duped_value (lambda (L element L_empty? L_empty)
                              (if (L_empty? L) (cons element L_empty)
                                  (if (list? (car L))
                                      (if (equal? (car element) (caar L)) L
                                         (cons (car L) (add_not_duped_value (cdr L) element L_empty? L_empty)))
                                      (if (equal? element (car L)) L
                                         (cons (car L) (add_not_duped_value (cdr L) element L_empty? L_empty))))
                               )))
; Nombre: add_not_duped_value
; Dominio: L(list) X element(any) X L_empty?(function) X L_empty(function)
; Recorrido: list
; Descripcion: Funcion que recibe una lista, un elemento, una funcion que indique si la lista esta vacia,
;              una funcion que entregue una lista vacia, y retorna la lista con el elemento agregado
;              asegurandose de que la lista no tenga ya este valor. Para asegurarse de estp ultimo la funcion
;              primero verifica si el elemento es un par(o lista) o otro elemento, de ser otro elemento esta
;              compara el elemento a introducir con los elementos de la lista; de ser el elemento un par(o lista)
;              este compara el identificador de esta (primera posicion) con los identificadores de los elementos de la lista.
; Recursion: natural