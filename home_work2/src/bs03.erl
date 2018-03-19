% Задание 3(bs03), делим строку на части, с явным указанием разделителя::

-module(bs03).
-export([split/2]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
split_test_() ->
[?_assert(split(<<"Col1-Col2-Col3-Col4-Col5">>, "-") == [<<"Col1">>,<<"Col2">>,<<"Col3">>,<<"Col4">>,<<"Col5">>]),
?_assert(split(<<"I+like+this+game">>, "+") == [<<"I">>, <<"like">>, <<"this">>, <<"game">>]),
?_assertMatch([<<"Erlang">>, <<"in">>, <<"the">>, <<"future">>], split(<<"Erlang-in-the-future">>, "-")),
?_assertEqual(split(<<"Erlang-:-in-:-the-:-future">>, "-:-"), split(<<"Erlang-:-in-:-the-:-future">>, "-:-"))].
-endif.

% создаем функцию с 4-мя переменными, где 1 - разделитель, 2 - вводимый бинарник, 3 - индекс 0, 4 - аккумулятор:
split(Bin, Del) ->
    split(Del, Bin, 0, []).


split(Del, Bin, Idx, Acc) ->
   case Bin of
      <<Part:Idx/binary, Char, Tail/binary>> ->
         case lists:member(Char, Del) of
            false ->
               split(Del, Bin, Idx+1, Acc);
            true ->
               split(Del, Tail, 0, [Part|Acc])
         end;
      <<Part:Idx/binary>> ->
         lists:reverse(Acc, [Part])

    end.
