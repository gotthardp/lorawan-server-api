%
% Copyright (c) 2016 Petr Gotthard <petr.gotthard@centrum.cz>
% All rights reserved.
% Distributed under the terms of the MIT License. See the LICENSE file.
%
-module(lorawan_application).

-include("lorawan_application.hrl").

-callback init(App :: binary()) ->
    ok | {ok, [Path :: cowboy_router:route_path()]}.
-callback handle_join(DevAddr :: binary(), App :: binary(), AppArgs :: binary()) ->
    ok | {error, Error :: term()}.
-callback handle_rx(DevAddr :: binary(), App :: binary(), AppArgs :: binary(), RxData :: #rxdata{}, RxQ :: #rxq{}) ->
    ok | retransmit |
    {send, Port :: integer(), Data :: #txdata{}} |
    {error, Error :: term()}.

% end of file
