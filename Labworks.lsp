;		Вспомогательные функции.
;;;		Инверсия
(defun inv
	(lambda (x)
		(cond
		(x nil)
		(t t)
		)
	)
)
;;;		Максимум
(defun max
	(lambda (a b)
		(cond
		((inv (numberp a)) nil)
		((inv (numberp b)) nil)
		((> a b) a)
		(t b)
		)
	)
)
;;; 	Модуль
(defun abs
	(lambda (x)
		(cond
		((inv (numberp x)) nil)
		((< x 0) (* x -1))
		(t x)
		)
	)
)
;;; 	Эпсилон (точность)
(setq epsilon 0.0000001)
;;;		Возведение в квадрат
(defun sqr
	(lambda (x)
		(cond
		((inv (numberp x)) nil)
		(t (* x x))
		)
	)
)
;;;		Метод Ньютона: вычисление следующего приближённого значения
(defun nextsqrt
	(lambda (x nextx)
		(cond
		((inv (numberp x)) nil)
		((inv (numberp nextx)) nil)
		((< x 0) nil)
		((< nextx 0) nil)
		((= x 0) 0)
		((= nextx 0) 0)
		((= x 1) 1)
		((= nextx 1) 1)
		((< epsilon 0.0000001) nil)
		((< (abs (- nextx (/ (+ nextx (/ x nextx)) 2))) epsilon) nextx)
		(t (nextsqrt x (/ (+ nextx (/ x nextx)) 2)))
		)
	)
)
;	1.1.1.	Рекурсивная обработка числовой информации.
;	1.	Подсчитать сумму квадратов целых чисел в заданном интервале значений от m до n включительно.
(defun sumsqr
	(lambda (m n)
		(cond
		((inv (numberp m)) nil)
		((inv (numberp n)) nil)
		((> m n) nil)
		((> 0 (rem m 1)) (sumsqr (- m (rem m 1)) n))
		((< 0 (rem m 1)) (sumsqr (+ (- m (rem m 1)) 1) n))
		((> 0 (rem n 1)) (sumsqr m (- (- n (rem n 1)) 1)))
		((< 0 (rem n 1)) (sumsqr m (- n (rem n 1))))
		((= m n) (sqr m))
		(t (+ (sqr m) (sumsqr (+ m 1) n)))
		)
	)
)
;	2.	Определить наименьшее общее кратное двух заданных чисел.
(defun mincommul
	(lambda (m n)
		(cond
		((inv (numberp m)) nil)
		((inv (numberp n)) nil)
		((< m 0) nil)
		((< n 0) nil)
		((> (mod m 1) 0) nil)
		((> (mod n 1) 0) nil)
		((= m 0) nil)
		((= n 0) nil)
		((= m n) m)
		(t (/ (* m n) (maxcomdiv m n)))
		)
	)
)
;	3.	Определить наибольший общий делитель двух заданных чисел.
(defun maxcomdiv
	(lambda (m n)
		(cond
		((inv (numberp m)) nil)
		((inv (numberp n)) nil)
		((< m 0) nil)
		((< n 0) nil)
		((> (mod m 1) 0) nil)
		((> (mod n 1) 0) nil)
		((= m 0) nil)
		((= n 0) nil)
		((= m n) m)
		((> m n) (maxcomdiv (- m n) n))
		(t (maxcomdiv m (- n m)))
		)
	)
)
;	4.	Вычислить квадратный корень из заданного числа.
(defun sqrt
	(lambda (x)
		(cond
		((inv (numberp x)) nil)
		((< x 0) nil)
		(t (nextsqrt x x))
		)
	)
)
;	5.	Первые два члена ряда фибоначчи равны 1 и 2. Каждый следующий член ряда равен сумме двух предыдущих. Определить функцию, вычисляющую n-й член ряда Фибоначчи.
(defun fibnum
	(lambda (n)
		(cond
		((inv (numberp n)) nil)
		((< n 1) nil)
		((> (mod n 1) 0) nil)
		((= n 1) 1)
		((= n 2) 2)
		(t (+ (fibnum (- n 1)) (fibnum (- n 2))))
		)
	)
)
;	1.1.2.	Рекурсивная обработка списковой информаии.
;	6.	Определить предикат, распознающий списки, имеющие чётное (нечётное) количество элементов.
;		Нечётное = TRUE
(defun list_amount_oddp
	(lambda (l)
		(cond
		((null l) nil)
		((listp (cdr l)) (inv (list_amount_oddp (cdr l))))
		(t t)
		)
	)
)
;		Чётное = TRUE
(defun list_amount_evenp
	(lambda (l)
		(cond
		((null l) t)
		((listp (cdr l)) (inv (list_amount_evenp (cdr l))))
		(t nil)
		)
	)
)
;	7.	Подсчитать сумму всех числовых атомов в списке производьной структуры.
(defun list_sumnum
	(lambda (l)
		(cond
		((null l) 0)
		((numberp (car l)) (+ (car l) (list_sumnum (cdr l))))
		((listp (car l)) (+ (list_sumnum (car l)) (list_sumnum (cdr l))))
		(t (list_sumnum (cdr l)))
		)
	)
)
;	8.	Определить максимальную глубину списка произвольной структуры.
(defun list_maxdepth
	(lambda (l)
		(cond
		((null l) 0)
		((listp (car l)) (max (+ 1 (list_maxdepth (car l))) (list_maxdepth (cdr l))))
		(t (max 1 (list_maxdepth (cdr l))))
		)
	)
)
;	9.	Найти максимальный элемент в числовом списке произвольной структуры.
;	10.	Написать функцию, выполняющую вычисление арифметических выражений, заданных в виде списка.