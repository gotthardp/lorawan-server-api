%
% Copyright (c) 2016-2017 Petr Gotthard <petr.gotthard@centrum.cz>
% All rights reserved.
% Distributed under the terms of the MIT License. See the LICENSE file.
%

-type eui() :: <<_:128>>.
-type seckey() :: <<_:256>>.
-type devaddr() :: <<_:64>>.
-type frid() :: <<_:64>>.
-type intervals() :: [{integer(), integer()}].
-type adr_config() :: {integer(), integer(), intervals()}.
-type devstat() :: {integer(), integer()}.

-record(rxq, {
    freq :: number(),
    datr :: binary(),
    codr :: binary(),
    time :: calendar:datetime(),
    tmst :: integer(),
    srvtmst :: integer(), % when received by the server
    rssi :: number(),
    lsnr :: number()}).

-record(txq, {
    freq :: number(),
    datr :: binary(),
    codr :: binary(),
    tmst :: integer(),
    time :: 'undefined' | 'immediately' | calendar:datetime(),
    powe :: integer()}).

-record(user, {
    name :: nonempty_string(),
    pass :: string()}).

-record(gateway, {
    mac :: binary(),
    tx_rfch :: integer(), % rf chain for downlinks
    netid :: binary(), % network id
    desc :: string(),
    last_rx :: calendar:datetime(),
    gpspos :: {number(), number()}, % {latitude, longitude}
    gpsalt :: number()}). % altitude

-record(multicast_group, {
    devaddr :: devaddr(), % multicast address
    region :: binary(),
    chan :: integer(),
    datr :: binary(),
    codr :: binary(),
    nwkskey :: seckey(),
    appskey :: seckey(),
    mac :: binary(),
    fcntdown :: integer()}). % last downlink fcnt

-record(device, {
    deveui :: eui(),
    region :: binary(),
    app :: binary(),
    appid :: any(), % application route
    appargs :: any(), % application arguments
    appeui :: eui(),
    appkey :: seckey(),
    link :: devaddr(),
    can_join :: boolean(),
    last_join :: calendar:datetime(),
    fcnt_check :: integer(),
    adr_flag_set :: boolean(), % server requests
    adr_set :: adr_config()}). % requested after join

-record(link, {
    devaddr :: devaddr(),
    region :: binary(),
    app :: binary(),
    appid :: any(), % application route
    appargs :: any(), % application arguments
    nwkskey :: seckey(),
    appskey :: seckey(),
    fcntup :: integer(), % last uplink fcnt
    fcntdown :: integer(), % last downlink fcnt
    fcnt_check :: integer(),
    last_rx :: calendar:datetime(),
    last_mac :: binary(), % gateway used
    last_rxq :: #rxq{},
    adr_flag_use :: boolean(), % device supports
    adr_flag_set :: boolean(), % server requests
    adr_use :: adr_config(), % used
    adr_set :: adr_config(), % requested
    last_qs :: [{integer(), integer()}], % list of {RSSI, SNR} tuples
    devstat_time :: calendar:datetime(),
    devstat_fcnt :: integer(),
    devstat :: devstat()}). % {battery, margin}

-record(rxdata, {
    fcnt :: integer(),
    port :: integer(),
    data :: binary(),
    last_lost=false :: boolean(),
    shall_reply=false :: boolean()}).

-record(txdata, {
    confirmed=false :: boolean(),
    port :: integer(),
    data :: binary(),
    pending=false :: boolean()}).

-record(pending, {
    devaddr :: devaddr(),
    confirmed :: boolean(),
    phypayload :: binary()}).

-record(txframe, {
    frid :: frid(), % unique identifier
    datetime :: calendar:datetime(),
    devaddr :: devaddr(),
    txdata :: #txdata{}}).

-record(rxframe, {
    frid :: frid(), % unique identifier
    mac :: binary(), % gateway used
    rxq :: #rxq{},
    average_qs :: {number(), number()}, % average RSSI and SNR
    app :: binary(),
    appid :: any(), % application route
    region :: binary(),
    devaddr :: devaddr(),
    powe:: integer(),
    fcnt :: integer(),
    port :: integer(),
    data :: binary(),
    datetime :: calendar:datetime(),
    devstat :: devstat()}). % {battery, margin}

% end of file
