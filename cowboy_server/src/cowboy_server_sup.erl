-module(cowboy_server_sup).
% Se le da al proceso la tarea de supervisar sus procesos hijo
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

% Crear un proceso supervisor, con nombre, como parte de un árbol de supervisión
start_link() ->
        supervisor:start_link({local, ?MODULE}, ?MODULE, []).

% Función auxiliar en el que se encuentra la estrategia de reinicio
% intensidad de reinicio máxima, y los procesos hijo
init([]) ->
        Procs = [],
        {ok, {{one_for_one, 1, 5}, Procs}}.
