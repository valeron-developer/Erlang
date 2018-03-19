% задание 11(p11) запаковываем последовательно следующие дубликаты во вложеные списки

-module(p11).
-export([encode_modified/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
encode_modified_test_() ->
[?_assert(encode_modified([a,b,b,c,d,d,e]) == [a,[2,b],c,[2,d],e]),
?_assertNot(encode_modified([a,a,b,c,c,d]) == [[2,a],a,b,[2,c],d]),
?_assertMatch([[4,a],b,[2,c],[2,a],d,[4,e]], encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e])),
?_assertEqual(encode_modified([a,a,b,b,b,c,c,d]), encode_modified([a,a,b,b,b,c,c,d])),
?_assertException(throw, {not_found,_}, throw({not_found,"@#"}))].
-endif.

% создаем функцию, в которой 1-й элемент списка будет равен числу последующих повторяющихся подряд элементов, который будет добавлять 1-цу при данных условиях:
encode_modified([[Count,Elem]|[Elem|[]]])->
   [[Count+1,Elem]];

% делает тоже самое что и первая клоза, только если хвост последнего элемента не "пустой", то выносит хвост в след.список элементов:
encode_modified([[Count,Elem]|[Elem|T]])->
   encode_modified([[Count+1,Elem]|T]);

% если в списке есть еще список с одним элементом и с пустым хвостом, то на выходе получаем просто список с одним вложенным(первым) списком:
encode_modified([[Count,Elem1]|[Elem2|[]]])->
   [[Count,Elem1],Elem2];

% если в списке вложено два списка, и во втором в голове два одинаковых элемента, то на выходе выводим цыфру 2 и повторяющийся элемент в голову 2-го списка: 
encode_modified([[Count,Elem1]|[Elem2,Elem2|T]])->
   [[Count,Elem1]|encode_modified([[2,Elem2]|T])];

% если в списке есть еще список с двумя элементами, то первый список выводим без изменений, так как он уже обработан первыми двумя клозами, дальше создаем функцию, которая выводит элементы 2-го списка:
encode_modified([[Count,Elem1]|[Elem2|T]])->
   [[Count,Elem1]|encode_modified([Elem2|T])];

% если есть список без вложенных списков, и в голове списка два одинаковых элемента, то на выходе получаем функцию, которая выводит список и добавляет в голову 2-ку, затем повторяющийся элемент:
encode_modified([Elem1,Elem1|T])->
   encode_modified([[2,Elem1]|T]);

% если есть список без вложенных списков, и в голове списка два разных элемента, то на выходе выводим 1-й элемент, затем функцию, которая обрабатывает оставшиеся элементы: 
encode_modified([Elem1,Elem2|T])->
   [Elem1|encode_modified([Elem2|T])];

% если список пустой - выводим пустой список:
encode_modified([])->
   [].
