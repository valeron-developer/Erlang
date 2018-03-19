-module(bs01).

-export([first_word/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
first_word_test_() ->
[?_assert(first_word(<<"I can do this">>) == <<"I">>),
?_assertNot(first_word(<<"Wonderful world">>) == <<"world">>),
?_assertMatch(<<"Erlang">>, first_word(<<"Erlang in the future">>)),
?_assertEqual(first_word(<<"Erlang in the future">>), first_word(<<"Erlang the best">>)),
?_assertException(error, {bad_argument,_}, error({bad_argument,<<"/">>}))].
-endif.

% создаем аккумулятор, для накопления бинарных данных:
first_word(Bin) ->
   first_word(Bin,<<>>).

% если 1-й символ вводимых данных не пробел, то записываем его в аккумулятор:
first_word(<<X,Y/binary>>, Acc) when X =/= 32 ->
   first_word(Y,<<X,Acc/binary>>);

% если 1-й символ вводимых данных пробел, то выводим аккумулятор:
first_word(<<X,_/binary>>, Acc) when X == 32 ->
   first_word(<<Acc/binary>>);

% если список вводимых данных пуст, то выводим аккумулятор:
first_word(<<>>, Acc) ->
   Acc.
