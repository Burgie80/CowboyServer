-module(salute_handler).
% Se registra como un middleware cuando es seleccionado por el router
-behavior(cowboy_handler).

-export([init/2]).

% Función para crear el mensaje de saludo
create_message(QsVals, Param) ->
    case lists:keyfind(Param, 1, QsVals) of
        {_, Name} -> ["¡Hola, ", Name, "!"];  % Caso donde el nombre es proporcionado
        false -> "No me diste tu nombre :("   % Caso donde no se proporciona el nombre
    end.

% Personaliza un saludo según el nombre dado
init(Req0, State) ->
    QsVals = cowboy_req:parse_qs(Req0),
    Message = create_message(QsVals, <<"name">>),  % Llama a create_message para construir el mensaje
    % Envía el mensaje creado
    Req = cowboy_req:reply(200,
            #{<<"content-type">> => <<"text/plain">>},
            Message,
            Req0),
    {ok, Req, State}.
