% Задание 2(bs02) разделяем строку на слова:

-module(bs02).
-export([words/1]).

% тесты для данного задания
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
words_test_() ->
[?_assert(words(<<"I can do this">>) == [<<"I">>, <<"can">>, <<"do">>, <<"this">>]),
?_assert(words(<<"   I like this game">>) == [<<"I">>, <<"like">>, <<"this">>, <<"game">>]),
?_assertNot(words(<<"Wonderful world">>) == [<<"world">>]),
?_assertMatch([<<"Erlang">>, <<"in">>, <<"the">>, <<"future">>], words(<<"Erlang in the future">>)),
?_assertEqual(words(<<"Erlang in the future">>), words(<<"Erlang in the future">>))].
-endif.

% создаем два аккумулятора, для того что-бы в 1-й записывать слова без пробела, а во второй - список слов состоящий из 1-го аккумулятора:
words(Bin) ->
    words(Bin, <<>>, []).

% если пробел стоит первым символом вводимых данных, то исключаем его:
words(<<X, Y/binary>>, <<>>, Res) when X == 32 ->
    words(Y, <<>>, Res);

% если пробел стоит первым символом вводимых данных, а аккумулятор не пустой, то исключаем пробел и добавляем аккумулятор в список слов, делая аккумулятор пустым:
words(<<X, Y/binary>>, Acc, Res) when X == 32 ->
    words(Y, <<>>, [Acc|Res]);

% если мы получили символ, который не является пробелом, мы добавляем этот символ в аккумулятор:
words(<<X, Y/binary>>, Acc, Res) when X =/= 32 ->
    words(Y, <<Acc/binary, X>>, Res);

% Если вводимые данные и аккумулятор пустые, мы выводим список слов:
words(<<>>, <<>>, Res) ->
    Res;

% если бинарник пустой, а аккумулятор имеет один или несколько символов, мы добавляем аккумулятор в список слов и делаем реверс:
words(<<>>, Acc, Res) ->
    lists:reverse([Acc|Res]).
