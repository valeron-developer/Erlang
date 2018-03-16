% задание 15(p15) пишем функцию-репликатор всех элементов входящего списка

-module(p15).
-export([replicate/2]).

% создаем функцию, которая будет выводить пустой список, если был введен пустой список, вне зависимости от введенного числа-репликатора:
replicate([],_)->
[];

% если список не пустой, то на выходе получаем такую же функцию, только добавляем одну переменную:
replicate([H|T],Match)->
replicate([H|T],Match,Match).

% когда число-репликатор доходит до 0, то продолжаем работать над остальными элементами списока:
	replicate([_|T],0,Match)->
	   replicate(T,Match,Match);

% функция переносит один елемент головы и при этом уменьшает число-репликатор на 1, пока не дойдет до 0, вызывая таким образом клозу на порядок выше: 
	replicate([H|T],Count,Match)->
	   [H|replicate([H|T],Count-1,Match)];

% если вводимый список пустой - выводим пустой список:
	replicate([],_,_)->
	   [].




