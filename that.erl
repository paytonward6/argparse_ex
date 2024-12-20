#!/usr/bin/env escript

main(Args) ->
    argparse:run(Args, cli(), #{progname => mul}).

cli() ->
    #{
        arguments => [
            #{name => left, type => integer},
            #{name => right, type => integer},
            #{name => double, type => boolean, long => "-double"}
        ],
        handler =>
            fun (#{left := Left, right := Right} = Tot) ->
                io:write(Tot),
                io:format("~b~n", [Left * Right])
            end
    }.
