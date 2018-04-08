-module(cache_server).

-export([start/1, init/1, start_link/1, insert/3, lookup/1, lookup_by_date/2]).

-record(state, {drop_interval=5 :: non_neg_integer()}).

-include_lib("stdlib/include/ms_transform.hrl").

-define(SEC(X), calendar:datetime_to_gregorian_seconds(X)).

-define(NOW, calendar:datetime_to_gregorian_seconds(erlang:localtime())).

% superviser запускает процесс gen_server'a, который создает таблицу, также следит за тем, что-бы эта таблица через определенный интервал времени очищалась:
start(Opts) ->
    gen_server:start({local, ?MODULE}, ?MODULE, Opts, []).

start_link(Opts) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Opts, []).

% в этой функии берем текущее время, что-бы знать, когда наш record был внесен в таблицу, и берем record из 4-х элементов(ключ, значени, текущее время, и время. когда наш record станет не актуальным):
insert(Key, Value, Timer) when is_integer(Timer), Timer > 0 ->
    TimeOut = ?NOW + Timer,
    ets:insert(new_table, {Key, Value, ?NOW, TimeOut}),
    ok.

% эта функция возвращает либо ok и значение, либо error, not_found. Для этого берем текущее время, для того что-бі случайно не взять устаревший record и делаем обычный lookup, который извлекает не устаревший record:
lookup(Key) ->	
	Now = ?NOW,
		case
		ets:lookup(new_table, Key) of
		[{Key, Value, _, TimeOut}] when TimeOut >= Now ->
			{ok, Value};
		_ -> {error, not_found}
		end.

% принимает два параметра, эти параметры конвертируем сразу в секунды, берем текущее время(тоже в секундах), выбирая все recordы, которые актуальны в диапазоне дат, которые мы задаем:
lookup_by_date(DateFrom, DateTo) ->
    DateFromSec = ?SEC(DateFrom),
    DateToSec = ?SEC(DateTo),
    Now = ?NOW,
    Dates = ets:select(new_table, ets:fun2ms(
        fun({Key, Value, DateStart, DateFinish}) 
            when DateStart > DateFromSec  andalso 
                 DateStart < DateToSec    andalso 
                 DateFinish >  Now ->
            {Key, Value} 
        end)),
    {ok, Dates}.

% функция, с которой запускается superviser, в которой создается таблица. Функция prer_state - парсит опции и заносит их в record:
init(Opts) ->
    ets:new(new_table, [named_table, public]),
    State = #state{drop_interval=DI} = prep_state(Opts),
    erlang:send_after(DI, self(), drop_obsolete),
    {ok, State}.

prep_state(Opt) ->
    prep_state(Opt, #state{}).

prep_state([{drop_interval, Val}|T], State) ->
    prep_state(T, State#state{drop_interval=Val * 1000});
prep_state([_|T], State) ->
    prep_state(T, State);
prep_state([], State) ->
    State.


% aplication - функция start запускает pid из aplication запускаем superviser. В top-level superviser передаем опции, которые хранятся в src-файле(файл в котором мы храним конфигурацию приложения, и определенные параметры). Из src с помощью функции getEn достаем опции и передаем их superviser'у. Есть общие параметры, для описания преложения(типо discription), registred - имена зарегистрированных модулей. Application - обязаткльное приложение, которое запустится до того как запустится наше приложение.
% env - дефолтовые настройки,которые срабатывают один раз при компиляции. start_link запускает сам супервайзер,он регистрируется, далее описание сервера.