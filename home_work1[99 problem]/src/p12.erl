% задание 12(p12) пишем декодер для модифицированого алгоритма RLE

-module(p12).
-export([decode_modified/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
decode_modified_test_() ->
[?_assert(decode_modified([[4,a],[2,b],c,[2,d],e]) == [a,a,a,a,b,b,c,d,d,e]),
?_assertNot(decode_modified([[2,a],b,[2,c],d]) == [a,a,b,c,c,d,d]),
?_assertMatch([a,a,a,a,b,c,c,a,a,d,e,e,e,e], decode_modified([[4,a],b,[2,c],[2,a],d,[4,e]])),
?_assertExit(normal, exit(normal)),
?_assertException(error, {bad_argument,_}, error({bad_argument,<<>>}))].
-endif.

% если список состоит из одного вложенного списка в котором голова = 2, а хвост равен одному элементу, то выводим этот элемент в списке 2 раза:
decode_modified([[2,X]|[]])->
[X,X];

% если список состоит из одного вложенного списка в котором голова равна любой цыфре кроме 2, то выводим элемент который стоит после цыфры 1 раз, затем пишем функция, которая отнимает от цыфры единицу и т.д,пока не дойдет до первой клозы:
decode_modified([[Count,X]|[]])->
[X|decode_modified([[Count-1,X]])];

% если список состоит из нескольких списков, и первая цыфра 2, то на выходе получаем повторение элемента, соящего за 2-кой, дальше обрабатываем оставшиеся элементы:
decode_modified([[2,X]|T])->
[X|[X|decode_modified(T)]];

% такой же прицип, как и во второй клозе, только с заполненым хвостом:
decode_modified([[Count,X]|T])->
[X|decode_modified([[Count-1,X]|T])];

% если в списке есть один элемент в голове списка, затем идет список со вложенным списком, то на выходе получаем элемент головы, дальше обрабатываем функцией оставшиеся элементы:
decode_modified([H|[[Count,X]|T]])->
[H|decode_modified([[Count,X]|T])];

% если список состоит из одного элемента, на выходе выводим его:
decode_modified([H|[]])->
[H];

% если список пустой - выводим пустой список:
decode_modified([])->
[].
