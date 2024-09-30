{application, 'cowboy_server', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['cowboy_server_app','cowboy_server_sup','hello_handler','salute_handler']},
	{registered, [cowboy_server_sup]},
	{applications, [kernel,stdlib,cowboy]},
	{optional_applications, []},
	{mod, {cowboy_server_app, []}},
	{env, []}
]}.