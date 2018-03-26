% задание 1(p01) находим последний элемент списка

-module(p01).
-export([last/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
last_test_() ->
[?_assert(last([0,4,1]) == 1),
?_assert(last([3]) == 3),
?_assertNot(last([7,2,1]) == 4),
?_assertMatch(8, last([1,2,3,8])),
?_assertEqual(last([5,6,7,8]), last([1,2,3,8]))].
-endif.

% выводим элемент в списке если в списке он один:
last([H]) ->     
   H;

% если в списке множество элементов, то постепенно исключаем по одному элементу начиная с головы списка, пока функция не приобретет вид 1-й клозы:
last([_|T]) ->    
   last(T);     

% если список пуст - выводим underfined:
last([]) ->      
   underfined.

