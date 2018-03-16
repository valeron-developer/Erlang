-module(bs01).

-export([first_word/1]).


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
