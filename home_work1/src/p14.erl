% задание 14(p14) пишем дубликатор всех элементов входящего списка

-module(p14).
-export([duplicate/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
duplicate_test_() ->
[?_assert(duplicate([a,b,c,d,e]) == [a,a,b,b,c,c,d,d,e,e]),
?_assertNot(duplicate([a,b,c,c,d]) == [a,a,b,c,c,c,c,d,d]),
?_assertMatch([a,a,a,a,b,b,c,c,c,c,c,c,d,d], duplicate([a,a,b,c,c,c,d])),
?_assertEqual([a,a,b,b,c,c,d,d,e,e], [a,a,b,b,c,c,d,d,e,e]),
?_assertExit(normal, exit(normal))].
-endif.

% если список пуст - возвращаем пустой список:
duplicate([]) -> [];

% созаем функцию, которая дублирует при каждой итерации элемент в голове списка, при этом сама функция идет на уменьшение начиная с головы:
duplicate([H|T]) -> [H,H | duplicate(T)].
