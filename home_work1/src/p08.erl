% задание 8(p08) удаляем последовательно следующие дубликаты:

-module(p08).
-export([compress/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
compress_test_() ->
[?_assert(compress([1,1,1,1,2,3,3,3,3,4,5]) == [1,2,3,4,5]),
?_assert(compress([a,b,b,c,d,d,e]) == [a,b,c,d,e]),
?_assertNot(compress([a,a,b,c,c,d]) == [a,a,b,c,c,d]),
?_assertMatch([s,f,e], compress([s,f,f,e,e])),
?_assertEqual(compress([a,a,a,b,b,c,d,d]), compress([a,a,b,b,b,c,c,d]))].
-endif.

% создаем функцию, в которой повторяются одинаковые элементы, она возвращает такую же функцию но без повторений элементов в списке:
compress([H|[H|T]]) ->  
   compress([H|T]);     

% когда список преобретает вид без повторных элементов то функция возвращает этот же список:
compress([H|T]) ->       
   [H|compress(T)];     

% если список пуст - выводим underfined:
compress([]) ->         
   [].     
