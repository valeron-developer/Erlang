% задание 2(p02) находим два последних элемента списка

-module(p02).
-export([but_last/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
but_last_test_() ->
[?_assert(but_last([0,c,t]) == [c,t]),
?_assert(but_last([a]) == underfined),
?_assertNot(but_last([7,2,1]) == [2,2]),
?_assertMatch([8,0], but_last([1,2,3,8,0])),
?_assertEqual(but_last([5,6,3,8]), but_last([1,2,3,8]))].
-endif.

% если в списке один элемент - выводим underfined, так как нам нужно 2 элемента:
but_last([_|[]]) ->       
    underfined;           

% разбиваем список на такой вид, что бы выводилось только два элемента, если в списке два элемента:
but_last([H|[H1|[]]]) ->  
   [H, H1];               

% если в списке множество элементов, то постепенно исключаем по одному элементу начиная с головы списка, пока функция не приобретет вид 2-й клозы:
but_last([_|T]) ->        
   but_last(T);           

% если список пуст - выводим underfined:
but_last([]) ->           
   underfined.
      
