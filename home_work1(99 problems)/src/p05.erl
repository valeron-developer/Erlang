% задание 5(p05) поварачиваем список

-module(p05).
-export([reverse/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
reverse_test_() ->
[?_assert(reverse([0,4,1]) == [1,4,0]),
?_assert(reverse([3]) == [3]),
?_assertNot(reverse([a,b,c]) == [c,b,d]),
?_assertMatch([8,d,2,s], reverse([s,2,d,8])),
?_assertEqual(reverse([a,b,c,d]), reverse([a,b,c,d]))].
-endif.

% функция с одной переменной вызывает другую сункцию с двумя переменными, и срабатывает если во второй функции 2-я переменная - пустой список:
reverse(List) -> 
   reverse(List,[]).

% создаем функцию, которая выводит свою 2-ю переменную если 1-й переменной является пустой список:
	reverse([],Res) -> 
	   Res;

% если в списке есть какие либо значения, то срабатывает данная функция, которая с каждой итерацией записывает в себя по одному значению с головы, а хвост выводит в начало пока наш список не станет пустым:
	reverse([H|T],Res) -> 
	   reverse(T,[H|Res]).