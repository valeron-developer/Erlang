% задание 9(p09) запаковываем последовательно следующие дубликаты во вложеные списки

-module(p09).
-export([pack/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
pack_test_() ->
[?_assertNot(pack([1,2,3,4,5]) == [[1,1],[2],[3],[4],[5]]),
?_assert(pack([1,2,2,3,4,4,5]) == [[1],[2,2],[3],[4,4],[5]]),
?_assert(pack([a,b,b,c,d,d,e]) == [[a],[b,b],[c],[d,d],[e]]),
?_assertNot(pack([a,a,b,c,c,d]) == [[a,a],b,[c,c],[d]]),
?_assertEqual(pack([[a,a],[b,b],[c],[d,d]]), pack([[a,a],[b,b],[c],[d,d]]))].
-endif.

% если в списке только один элемент, то выводим его, помещая в новый список []:
pack([H|[]])->
   [H];

% если в списке есть повторяющиеся элементы, но между ними есть какие-либо другие элементы, то на выходе получаем след. функцию:
pack([[H|T1]|[H|T2]])->
   pack([[H|[H|T1]]|T2]);

% если в списке есть пустой писок, то исключаем его:
pack([[H1|T1]|[H2|[]]])->
   [[H1|T1],[H2]];

% если в списке нет повторяющихся элементов, то выводим список:
pack([[H1|T1]|[H2|T2]])->
[[H1|T1]|pack([H2|T2])];

% если в списке есть подряд повторяющиеся элементы, то на выходе получаем функцию, элементы головы в которой будут собираться в один отдельный список:
pack([H|[H|T]])->
   pack([[H,H]|T]);

% если список имеет след. вид, то выносим 1-й элемент за пределы функции:
pack([H1|[H2|T]])->
   [[H1]|pack([H2|T])];

% если список пустой, то на выходе получаем тоже пустой список:
pack([])->
   [].