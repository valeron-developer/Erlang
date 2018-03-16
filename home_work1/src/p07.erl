% задание 7(p07) выравниваем структуру с вложеными списками

-module(p07).
-export([flatten/1]).


% если в списке есть элемент - пустой список в голове, то его исключаем, дальше работаем с элементами хвоста:
flatten([[]|T])->
  flatten(T);

% если в списке есть вложенный список, то выносим элемент головы списка отдельно, а хвост переносим к след. элементу:
flatten([[H|T]|T2])->
  flatten([H|[T|T2]]);

% если в списке нет вложенных списков и в нем больше 1-го элемента, то выносим 1-й элемент, дальше функция для хвоста:
flatten([H|T])->
  [H|flatten(T)];

% если список пустой, то на выходе получаем тоже пустой список:
flatten([])->
  [] .

