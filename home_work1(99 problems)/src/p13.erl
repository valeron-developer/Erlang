% задание 13(p13) пишем декодер для стандартного алгоритма RLE:

-module(p13).
-export([decode/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
decode_test_() ->
[?_assert(decode([[4,a],[2,b],[1,c],[2,d],[1,e]]) == [a,a,a,a,b,b,c,d,d,e]),
?_assertNot(decode([[2,a],[1,b],[2,c],[1,d]]) == [a,a,b,c,c,d,d]),
?_assertMatch([a,a,a,a,b,c,c,a,a,d,e,e,e,e], decode([[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]])),
?_assertExit(normal, exit(normal)),
?_assertException(error, {bad_argument,_}, error({bad_argument,<<>>}))].
-endif.

% если список пуст - выводим пустой список:
decode([]) -> [];

% если в голове списка в кортедже первый элемент 0, то выводим функцию хвоста:
decode([[0, _] | T]) -> decode(T);

% если в голове списка в кортедже первый элемент не 0, то выводим хвост кортеджа в голову списка, остальное без изминений, только первый элемент кортеджа уменьшаем на 1:
decode([[Num, X] | T]) -> [X | decode([[Num-1, X] | T])].
