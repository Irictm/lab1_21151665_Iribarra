#lang racket
(provide add_not_duped_value)

(define add_not_duped_value (lambda (L element L_empty? L_empty)
                              (if (L_empty? L) (cons element L_empty)
                                  (if (pair? (car L))
                                      (if (equal? (car element) (caar L)) L
                                         (cons (car L) (add_not_duped_value (cdr L) element L_empty? L_empty)))
                                      (if (equal? element (car L)) L
                                         (cons (car L) (add_not_duped_value (cdr L) element L_empty? L_empty))))
                               )))
; Nombre: 
; Dominio: 
; Recorrido: 
; Descripcion:
;;; FALTA ASEGURARSE QUE LA FUNCION SOLO COMPARE EL IDENTIFICADOR PARA COMPARAR SI SON EL MISMO ELEMENTO;;;