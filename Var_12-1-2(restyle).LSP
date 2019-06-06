;	Реализовать предикат (@NUM-SORT-P list test), который равен
;	T, если элементы списка list последовательно попарно удовлетворяют
;	условию test. Если аргумент test опущен, то test = EQUAL.
(defun	@NUM-SORT-P
	(lambda (list_numsort test_ loc_)
		(setq loc_ list_numsort)
		((null loc_) nil)
		((atom loc_) nil)
		((null (cdr loc_)) nil)
		(((null test_) (setq test_ equal)))
		(loop
			((null (cdr loc_)) t)
			((not (eval (cons test_ (cons (car loc_) (list (cadr loc_)))))) nil)
			(setq loc_ (cdr loc_))
		)
	)
)
;	реализовать функцию (@CASE-OF <селектор> <вариант1> ... <варантN>) - аналог
;	оператора CASE языка Си.
(defun @CASE-OF
	(nlambda list_caseof
		(cond
			((null list_caseof) nil)	;	запрос пустой
			(T (@-CASE-OF (eval (car list_caseof)) (cdr list_caseof)))	;	запрос непустой - делим на селектор и список вариантов
		)
	)
)
;	Вспомогательная функция.
(defun @-CASE-OF
	(lambda (sctr_-caseof list_-caseof)
		(loop
			((null list_-caseof) nil)	;	вариантов не осталось
			((@num-sort-p (cons sctr_-caseof (eval (caar list_-caseof)))) (cadar list_-caseof))	;	сравниваем селектор и случай
			(setq list_-caseof (cdr list_-caseof))	;	отбрасываем расмотренный вариант
		)
	)
)
(defun week
	(lambda (x)
		(@case-of x (1 Monday) (2 Tuesday) (3 Wednesday)
		(4 Thursday) (5 Friday) (6 Saturday) (7 Sunday) (x Warning)) 
	)
)