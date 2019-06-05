;;; Инверсия.
(DEFUN INV
	(LAMBDA (X)
		(COND
		(X NIL)
		(T T)
		)
	)
)
;;; Максимум.
(DEFUN MAX
	(LAMBDA (A B)
		(COND
		((INV (NUMBERP A)) NIL)
		((INV (NUMBERP B)) NIL)
		((> A B) A)
		(T B)
		)
	)
)
;;; 6. Определить предикат, распознающий списки, имеющие чётное (нечётное) количество элементов.
;;; Нечётное = T
(DEFUN LIST_AMOUNT_ODDP
	(LAMBDA (L)
		(COND
		((NULL L) NIL)
		((LISTP (CDR L)) (INV (LIST_AMOUNT_ODDP (CDR L))))
		(T T)
		)
	)
)
;;; Чётное = T
(DEFUN LIST_AMOUNT_EVENP
	(LAMBDA (L)
		(COND
		((NULL L) T)
		((LISTP (CDR L)) (INV (LIST_AMOUNT_EVENP (CDR L))))
		(T NIL)
		)
	)
)
;;; 7. Подсчитать сумму всех числовых атомов в списке производьной структуры.
(DEFUN LIST_SUMNUM
	(LAMBDA (L)
		(COND
		((NULL L) 0)
		((NUMBERP (CAR L)) (+ (CAR L) (LIST_SUMNUM (CDR L))))
		((LISTP (CAR L)) (+ (LIST_SUMNUM (CAR L)) (LIST_SUMNUM (CDR L))))
		(T (LIST_SUMNUM (CDR L)))
		)
	)
)
;;; 8. Определить максимальную глубину списка произвольной структуры.
(DEFUN LIST_MAXDEPTH
	(LAMBDA (L)
		(COND
		((NULL L) 0)
		((LISTP (CAR L)) (MAX (+ 1 (LIST_MAXDEPTH (CAR L))) (LIST_MAXDEPTH (CDR L))))
		(T (MAX 1 (LIST_MAXDEPTH (CDR L))))
		)
	)
)
;;; 9. Найти максимальный элемент в числовом списке произвольной структуры.
(DEFUN LIST_MAXNUM
	(LAMBDA (L)
		(COND
		
		)
	)
)
;;; 10. Написать функцию, выполняющую вычисление арифметических выражений, заданных в виде списка.
;;; Используемые 