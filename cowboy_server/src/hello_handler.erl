-module(hello_handler).
% Se registra como un middleware cuando es seleccionado por el router
-behavior(cowboy_handler).

-export([init/2]).

% Envía una respuesta con código 200, y el mensaje en texto plano "Hello World!"
init(Req0, State) ->
        Req = cowboy_req:reply(200,
                #{<<"content-type">> => <<"text/plain">>},
                <<"¡Hola, Mundo!">>,
                Req0),
        {ok, Req, State}.
