% задание 15(p15) пишем функцию-репликатор всех элементов входящего списка

-module(p15).
-export([replicate/2]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
decode_test_() ->
[?_assert(replicate([a,b,c,d,e],3) == [a,a,a,b,b,b,c,c,c,d,d,d,e,e,e]),
?_assertNot(replicate([a,b,c,d],2) == [a,a,b,c,c,d,d]),
?_assertMatch([a,a,b,b,c,c,d,d], replicate([a,b,c,d],2)),
?_assertThrow({can_use,_}, throw({can_use,"@"})),
?_assertException(error, {bad_argument,_}, error({bad_argument,<<>>}))].
-endif.

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





