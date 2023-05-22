#lang racket
(provide current_date)

; TDA date
; Representacion: Representado por una date(racket data type)


;---- Constructores ----;

(define raw-date (seconds->date (* 0.001 (current-inexact-milliseconds))))
; Nombre: raw-date
; Dominio: none
; Recorrido: date (date data type)
; Descripcion: Funcion constructora de date, que entrega la fecha actual en
;              el tipo de dato "date" de racket.

;---- Selectores ----;

(define raw-date->year (lambda (rw-dte) (date-year rw-dte)))
; Nombre: raw-date->year
; Dominio: date
; Recorrido: int
; Descripcion: Funcion que recibe una date y entrega el año de esta (int).

(define raw-date->month (lambda (rw-dte) (date-month rw-dte)))
; Nombre: raw-date->month
; Dominio: date
; Recorrido: int
; Descripcion: Funcion que recibe una date y entrega el mes de esta (int).

(define raw-date->day (lambda (rw-dte) (date-day rw-dte)))
; Nombre: raw-date->day
; Dominio: date
; Recorrido: int
; Descripcion: Funcion que recibe una date y entrega el dia de esta (int).

(define raw-date->hour (lambda (rw-dte) (date-hour rw-dte)))
; Nombre: raw-date->hour
; Dominio: date
; Recorrido: int
; Descripcion: Funcion que recibe una date y entrega la hora de esta (int).

(define raw-date->minute (lambda (rw-dte) (date-minute rw-dte)))
; Nombre: raw-date->minute
; Dominio: date
; Recorrido: int
; Descripcion: Funcion que recibe una date y entrega el minuto de esta (int).

;---- Pertenencia ----;

;---- Modificadores ----;

;---- Otras Funciones ----;

(define current_date (string-append "[" (number->string (raw-date->hour raw-date)) ":"
                                    (number->string (raw-date->minute raw-date)) "] "
                                    (number->string (raw-date->year raw-date)) "-"
                                    (number->string (raw-date->month raw-date)) "-"
                                    (number->string (raw-date->day raw-date))))
; Nombre: current_date
; Dominio: none
; Recorrido: string
; Descripcion: Funcion que a traves del uso de la funcion "raw-date" entrega un string que indica
;              datos sobre la fecha actual.