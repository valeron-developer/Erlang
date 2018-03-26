% пишем библиотеку для кеширования:

-module(my_cache).
-include_lib("stdlib/include/ms_transform.hrl").
-export([create/0, insert/3, lookup/1, delete_obsolete/0]).
-define(NOW, calendar:datetime_to_gregorian_seconds(erlang:localtime())).

% функция создает новую таблицу для записей, с помощью ets(кеш-таблица):
create() -> ets:new(new_table, [named_table]), ok.

% функция, которая записывает данные(ключ,значение,время жизни записи) в таблицу:
insert(Key, Value, Timer) when is_integer(Timer), Timer > 0 -> 
	TimeOut = ?NOW + Timer,
	ets:insert(new_table, {Key, Value, TimeOut}), ok.

% функция, которая выводит значение по ключу, достает только не устаревшие данные:
должна доставать только НЕ устаревшие данные
lookup(Key) ->	
	Now = ?NOW,
	MS = ets:fun2ms(fun({KeyGen, Value, TimeOut}) 
						when Key =:= KeyGen, TimeOut > Now ->
					Value end),
	ets:select(new_table, MS).
 
% очистка утстаревших данных:
delete_obsolete() ->
	Now = ?NOW,
	ets:select_delete(new_table, ets:fun2ms(
			fun({_, _, TimeOut}) when TimeOut =< Now -> true end)).
