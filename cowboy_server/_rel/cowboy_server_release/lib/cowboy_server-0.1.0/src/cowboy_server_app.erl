-module(cowboy_server_app).
% Define un proceso dentro de un árbol de supervisión
% el cual puede iniciar o detenerse como una unidad, y
% además define funciones para controlar aplicaciones, y
% acceder información sobre aplicaciones (parámetros de configuración, etc.)
-behaviour(application).

-export([start/2]).
-export([stop/1]).

% Configura el servidor HTTP y lo inicia
start(_Type, _Args) ->
        % Se compila la lista de rutas en sus recursos,
        % convirtiéndolos en una forma más eficiente de procesar
        Dispatch = cowboy_router:compile([
                {'_', [{"/", hello_handler, []}, % Ruta "/" asociado al recurso hello_handler
                       {"/saludo", salute_handler, []} % Ruta "/saludo" asociado el recurso salute_handler
                ]}
        ]),

        % Registra un listener en el puerto 8080 con la lista de rutas creada
        % para comenzar a escuchar por conexiones sobre un canal TCP limpio
        {ok, _} = cowboy:start_clear(my_http_listener,
                [{port, 8080}],
                #{env => #{dispatch => Dispatch}}
        ),
        cowboy_server_sup:start_link().

% Detiene el listener
stop(_State) ->
        ok.
