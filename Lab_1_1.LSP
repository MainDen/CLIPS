;;; Инверсия.
(DEFUN INV
	(LAMBDA (X)
		(COND
		(X NIL)
		(T T)
		)
	)
)
;;; Модуль.
(DEFUN ABS
	(LAMBDA (X)
		(COND
		((INV (NUMBERP X)) NIL)
		((< X 0) (* X -1))
		(T X)
		)
	)
)
;;; Эпсилон(точность).
(SETQ EPSILON 0.0000001)
;;; Возведение в квадрат.
(DEFUN SQR
	(LAMBDA (X)
		(COND
		((INV (NUMBERP X)) NIL)
		(T (* X X))
		)
	)
)
;;; Метод Ньютона: вычисление следующего приближённого значения.
(DEFUN NEXTSQRT
	(LAMBDA (X NEXTX)
		(COND
		((INV (NUMBERP X)) NIL)
		((INV (NUMBERP NEXTX)) NIL)
		((< X 0) NIL)
		((< NEXTX 0) NIL)
		((= X 0) 0)
		((= NEXTX 0) 0)
		((= X 1) 1)
		((= NEXTX 1) 1)
		((< EPSILON 0.0000001) NIL)
		((< (ABS (- NEXTX (/ (+ NEXTX (/ X NEXTX)) 2))) EPSILON) NEXTX)
		(T (NEXTSQRT X (/ (+ NEXTX (/ X NEXTX)) 2)))
		)
	)
)
;;; 1. Подсчитать сумму квадратов целых чисел в заданном интервале значений от M до N включительно.
(DEFUN SUMSQR
	(LAMBDA (M N)
		(COND
		((INV (NUMBERP M)) NIL)
		((INV (NUMBERP N)) NIL)
		((> M N) NIL)
		((> 0 (REM M 1)) (SUMSQR (- M (REM M 1)) N))
		((< 0 (REM M 1)) (SUMSQR (+ (- M (REM M 1)) 1) N))
		((> 0 (REM N 1)) (SUMSQR M (- (- N (REM N 1)) 1)))
		((< 0 (REM N 1)) (SUMSQR M (- N (REM N 1))))
		((= M N) (SQR M))
		(T (+ (SQR M) (SUMSQR (+ M 1) N)))
		)
	)
)
;;; 2. Определить наименьшее общее кратное двух заданных чисел.
(DEFUN MINCOMMUL
	(LAMBDA (M N)
		(COND
		((INV (NUMBERP M)) NIL)
		((INV (NUMBERP N)) NIL)
		((< M 0) NIL)
		((< N 0) NIL)
		((> (MOD M 1) 0) NIL)
		((> (MOD N 1) 0) NIL)
		((= M 0) NIL)
		((= N 0) NIL)
		((= M N) M)
		(T (/ (* M N) (MAXCOMDIV M N)))
		)
	)
)
;;; 3. Определить наибольший общий делитель двух заданных чисел.
(DEFUN MAXCOMDIV
	(LAMBDA (M N)
		(COND
		((INV (NUMBERP M)) NIL)
		((INV (NUMBERP N)) NIL)
		((< M 0) NIL)
		((< N 0) NIL)
		((> (MOD M 1) 0) NIL)
		((> (MOD N 1) 0) NIL)
		((= M 0) NIL)
		((= N 0) NIL)
		((= M N) M)
		((> M N) (MAXCOMDIV (- M N) N))
		(T (MAXCOMDIV M (- N M)))
		)
	)
)
;;; 4. Вычислить квадратный корень из заданного числа.
(DEFUN SQRT
	(LAMBDA (X)
		(COND
		((INV (NUMBERP X)) NIL)
		((< X 0) NIL)
		(T (NEXTSQRT X X))
		)
	)
)
;;; 5. Первые два члена ряда Фибоначчи равны 1 и 2. Каждый следующий член ряда равен сумме двух предыдущих. Определить функцию, вычисляющую N- й член ряда Фибоначчи.
(DEFUN FIBNUM
	(LAMBDA (N)
		(COND
		((INV (NUMBERP N)) NIL)
		((< N 1) NIL)
		((> (MOD N 1) 0) NIL)
		((= N 1) 1)
		((= N 2) 2)
		(T (+ (FIBNUM (- N 1)) (FIBNUM (- N 2))))
		)
	)
)